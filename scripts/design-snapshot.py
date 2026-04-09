#!/usr/bin/env python3
"""Create a compact runtime design snapshot from DESIGN.md."""

from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path


SECTION_RE = re.compile(r"^(##+)\s+(.+)$")


def parse_sections(text: str) -> dict[str, list[str]]:
    sections: dict[str, list[str]] = {}
    current = "_preamble"
    sections[current] = []
    for line in text.splitlines():
        match = SECTION_RE.match(line.strip())
        if match and len(match.group(1)) == 2:
            current = match.group(2).strip()
            sections[current] = []
            continue
        sections.setdefault(current, []).append(line)
    return sections


def clean_lines(lines: list[str]) -> list[str]:
    result: list[str] = []
    for line in lines:
        clean = line.strip()
        if clean:
            result.append(clean)
    return result


def take_bullets(lines: list[str], prefix: str = "- ", limit: int = 6) -> list[str]:
    items = []
    for line in lines:
        clean = line.strip()
        if clean.startswith("- "):
            items.append(prefix + clean[2:].strip())
        elif clean.startswith("|") and clean.count("|") > 2 and not re.fullmatch(r"\|?[\s:-]+(?:\|[\s:-]+)+\|?", clean):
            cells = [cell.strip() for cell in clean.strip("|").split("|")]
            if cells and cells[0].lower() not in {"role", "level", "portal / app"}:
                items.append(prefix + " | ".join(cells))
        if len(items) >= limit:
            break
    return items


def build_snapshot(text: str, slug: str) -> str:
    sections = parse_sections(text)
    preamble = clean_lines(sections.get("Metadata", []))
    lines = [
        f"# DESIGN Snapshot - {slug}",
        "",
        "Auto-generated from `DESIGN.md` for token-efficient wireframe context.",
    ]

    if preamble:
        lines.extend(["", "## Metadata"])
        lines.extend(f"- {line.lstrip('- ').strip()}" for line in preamble[:6])

    mapping = [
        ("0. Phạm vi áp dụng (Scope Of Use)", "Scope", 5),
        ("1. Visual Theme & Atmosphere", "Theme", 6),
        ("2. Information Architecture (Portals & Navigation)", "Navigation", 6),
        ("3. Color Palette & Roles", "Color Roles", 8),
        ("4. Typography Rules", "Typography", 6),
        ("5. Component Stylings", "Components", 6),
        ("6. Layout Principles", "Layout", 5),
        ("7. Depth & Elevation", "Depth", 4),
        ("8. Do's and Don'ts", "Do / Don't", 6),
        ("9. Responsive Behavior", "Responsive", 5),
        ("10. Agent Prompt Guide", "Prompt Guide", 5),
    ]

    for source_heading, target_heading, limit in mapping:
        bullets = take_bullets(sections.get(source_heading, []), limit=limit)
        if not bullets:
            continue
        lines.extend(["", f"## {target_heading}"])
        lines.extend(bullets)

    return "\n".join(lines).rstrip() + "\n"


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--design-doc", required=True)
    parser.add_argument("--output", required=True)
    parser.add_argument("--slug", required=True)
    args = parser.parse_args()

    design_doc = Path(args.design_doc).expanduser()
    if not design_doc.exists():
        raise SystemExit(f"Design doc not found: {design_doc}")

    snapshot = build_snapshot(design_doc.read_text(encoding="utf-8"), args.slug)
    output = Path(args.output).expanduser()
    output.parent.mkdir(parents=True, exist_ok=True)
    output.write_text(snapshot, encoding="utf-8")
    print(output)
    return 0


if __name__ == "__main__":
    sys.exit(main())
