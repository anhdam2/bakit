#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "${TMP_DIR}"' EXIT

legacy_hits="$(
  cd "${ROOT_DIR}" &&
    rg -n "artifact-contract\\.md|plans/reports/final|plans/reports/drafts|plans/\\{date\\}-\\{slug\\}" \
      AGENTS.md GEMINI.md CLAUDE.md skills core scripts codex templates \
      --glob '!core/contract.yaml' \
      --glob '!rules/ba-workflow.md' \
      --glob '!scripts/test-contract-sync.sh' \
      || true
)"

if [[ -n "${legacy_hits}" ]]; then
  echo "Unexpected legacy contract references found:" >&2
  echo "${legacy_hits}" >&2
  exit 1
fi

python3 - "${ROOT_DIR}/templates/manifest.json" "${ROOT_DIR}/templates" <<'PY'
import json
import re
import sys
from pathlib import Path

manifest_path = Path(sys.argv[1])
templates_dir = Path(sys.argv[2])
manifest = json.loads(manifest_path.read_text(encoding="utf-8"))
heading_re = re.compile(r"^(#{1,6})\s+(.+)$")

for template_name, info in manifest.items():
    template_path = templates_dir / template_name
    if not template_path.exists():
        raise SystemExit(f"Missing template from manifest: {template_path}")
    headings = {
        line.strip()
        for line in template_path.read_text(encoding="utf-8").splitlines()
        if heading_re.match(line.strip())
    }
    for group_name, group_info in info.get("groups", {}).items():
        for heading in group_info.get("headings", []):
            if heading not in headings:
                raise SystemExit(
                    f"Manifest heading not found: template={template_name} group={group_name} heading={heading}"
                )
PY

python3 -m py_compile \
  "${ROOT_DIR}/scripts/source-extract.py" \
  "${ROOT_DIR}/scripts/design-snapshot.py" \
  "${ROOT_DIR}/scripts/stitch-state.py"

bash -n "${ROOT_DIR}/scripts/ba-kit"
bash -n "${ROOT_DIR}/scripts/check-token-budget.sh"
bash "${ROOT_DIR}/scripts/check-token-budget.sh" >/dev/null

cp "${ROOT_DIR}/codex/skills/ba-start/SKILL.md" "${TMP_DIR}/ba-start.before"
bash "${ROOT_DIR}/scripts/generate-codex-assets.sh" >"${TMP_DIR}/generator.log"
cmp "${TMP_DIR}/ba-start.before" "${ROOT_DIR}/codex/skills/ba-start/SKILL.md" >/dev/null

echo "Contract sync checks passed."
