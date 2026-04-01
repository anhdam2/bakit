#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TMP_DIR="$(mktemp -d "${TMPDIR:-/tmp}/ba-kit-md-to-html.XXXXXX")"
trap 'rm -rf "$TMP_DIR"' EXIT

mkdir -p "$TMP_DIR/designs/test-flow"

python3 - "$TMP_DIR/designs/test-flow/SCR-01-login.png" <<'PY'
import base64
import pathlib
import sys

png = (
    "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mP8"
    "/w8AAgMBgI6D+wAAAABJRU5ErkJggg=="
)
pathlib.Path(sys.argv[1]).write_bytes(base64.b64decode(png))
PY

cat >"$TMP_DIR/frd-260330-1010-demo-portal.md" <<'EOF'
# Tài liệu yêu cầu chức năng (Functional Requirements Document)

**Dự án (Project):** Demo Portal
**Phiên bản (Version):** v1.2
**Chủ sở hữu (Owner):** Lead BA
**Ngày (Date):** 2026-03-30

## Luồng nghiệp vụ

```mermaid
flowchart TD
  A[User submits] --> B{Valid?}
  B -- Yes --> C[Continue]
  B -- No --> D[Show error]
```
EOF

cat >"$TMP_DIR/srs-260330-1010-demo-portal.md" <<'EOF'
# Sample BA Output

**Dự án (Project):** Demo Portal
**Phiên bản (Version):** v1.2
**Chủ sở hữu (Owner):** Lead BA
**Ngày (Date):** 2026-03-30

## Risks & Constraints <Review>

1. Capture credentials
  - Show username field
  - Show password field with reference `designs/test-flow/SCR-01-login.png`
2. Validate sign-in
  1. Reject empty values
  2. Show an inline error

- Delivery packaging
  1. Generate stakeholder HTML
  2. Preserve Mermaid blocks

> Stakeholder copy should render without editing controls.

| Artifact | Status |
| --- | --- |
| FRD | Ready |
| SRS | Ready |

```mermaid
flowchart TD
  A[User submits] --> B{Valid?}
  B -- Yes --> C[Continue]
  B -- No --> D[Show error]
```

```bash
echo "package"
```
EOF

python3 "$ROOT_DIR/scripts/md-to-html.py" --base-dir "$TMP_DIR" --no-editor "$TMP_DIR/frd-260330-1010-demo-portal.md"
python3 "$ROOT_DIR/scripts/md-to-html.py" --base-dir "$TMP_DIR" --no-editor "$TMP_DIR/srs-260330-1010-demo-portal.md"

FRD_HTML="$TMP_DIR/frd-260330-1010-demo-portal.html"
SRS_HTML="$TMP_DIR/srs-260330-1010-demo-portal.html"

test -f "$FRD_HTML"
test -f "$SRS_HTML"

python3 - "$FRD_HTML" "$SRS_HTML" <<'PY'
from html.parser import HTMLParser
from pathlib import Path
import sys


class Probe(HTMLParser):
    def __init__(self):
        super().__init__()
        self.stack = []
        self.ids = set()
        self.classes = set()
        self.has_table = False
        self.has_blockquote = False
        self.has_mermaid = False
        self.has_bash = False
        self.has_nav = False
        self.has_image = False
        self.has_nested_ol_ul = False
        self.has_nested_ul_ol = False

    def handle_starttag(self, tag, attrs):
        attrs = dict(attrs)
        self.stack.append((tag, attrs))
        element_ids = attrs.get("id")
        if element_ids:
            self.ids.add(element_ids)
        element_classes = attrs.get("class", "")
        for name in element_classes.split():
            self.classes.add(name)
        if tag == "table":
            self.has_table = True
        elif tag == "blockquote":
            self.has_blockquote = True
        elif tag == "nav" and attrs.get("class") == "toc":
            self.has_nav = True
        elif tag == "img" and attrs.get("src", "").startswith("data:image/png;base64,"):
            self.has_image = True
        elif tag == "pre" and attrs.get("class") == "mermaid":
            self.has_mermaid = True
        elif tag == "code" and attrs.get("class") == "language-bash":
            self.has_bash = True

        parent_tags = [name for name, _ in self.stack[:-1]]
        if tag == "ul" and parent_tags[-2:] == ["ol", "li"]:
            self.has_nested_ol_ul = True
        if tag == "ol" and parent_tags[-2:] == ["ul", "li"]:
            self.has_nested_ul_ol = True

    def handle_endtag(self, tag):
        for index in range(len(self.stack) - 1, -1, -1):
            if self.stack[index][0] == tag:
                del self.stack[index:]
                break


frd_html = Path(sys.argv[1]).read_text(encoding="utf-8")
srs_html = Path(sys.argv[2]).read_text(encoding="utf-8")

for html, doc_type in (
    (frd_html, "frd"),
    (srs_html, "srs"),
):
    probe = Probe()
    probe.feed(html)
    assert "editor-toolbar" not in probe.ids, f"Unexpected editor toolbar found in read-only output for {doc_type}"
    assert "document-chrome" in probe.classes, f"Missing shared document chrome for {doc_type}"
    assert "doc-meta-grid" in probe.classes, f"Missing shared document metadata grid for {doc_type}"
    assert f'data-doc-type="{doc_type}"' in html, f"Missing doc type marker for {doc_type}"
    assert "BA-kit Unified HTML Deliverable" in html, f"Missing shared shell label for {doc_type}"
    assert "Source Markdown" in html, f"Missing source metadata row for {doc_type}"
    assert "Generated" in html, f"Missing generated metadata row for {doc_type}"

assert "Demo Portal" in frd_html, "Missing FRD project metadata"

probe = Probe()
probe.feed(srs_html)
assert probe.has_nav, "Missing table of contents"
assert probe.has_table, "Missing table"
assert probe.has_blockquote, "Missing blockquote"
assert probe.has_mermaid, "Missing Mermaid block"
assert probe.has_bash, "Missing bash code block"
assert probe.has_image, "Missing embedded image"
assert probe.has_nested_ol_ul, "Missing ordered list with nested unordered list"
assert probe.has_nested_ul_ol, "Missing unordered list with nested ordered list"
assert srs_html.count('<pre class="mermaid">') == 1, "Unexpected Mermaid block count"
assert srs_html.count('</code></pre>') == 1, "Unexpected fenced code closing count"
assert 'Risks &amp; Constraints &lt;Review&gt;' in srs_html, "TOC/body heading escaping regression"
assert "startOnLoad: false" in srs_html, "Missing explicit Mermaid bootstrap"
assert "mermaid.run({ querySelector: 'pre.mermaid' })" in srs_html, "Missing Mermaid render call"
assert "wireframe-lightbox" in srs_html, "Missing wireframe preview lightbox"
assert "max-height: min(68vh, 960px);" in srs_html, "Missing constrained wireframe image sizing"
PY

grep -q '<script src="https://cdn.jsdelivr.net/npm/mermaid/dist/mermaid.min.js"></script>' "$SRS_HTML"

echo "Smoke test passed: $FRD_HTML $SRS_HTML"
