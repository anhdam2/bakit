#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BUDGET_DOC="${ROOT_DIR}/core/token-budget.md"

python3 - "${ROOT_DIR}" "${BUDGET_DOC}" <<'PY'
import json
import re
import sys
from pathlib import Path

root = Path(sys.argv[1])
budget_doc = Path(sys.argv[2])
text = budget_doc.read_text(encoding="utf-8")
match = re.search(r"```json\n(.*?)\n```", text, re.S)
if not match:
    raise SystemExit(f"Could not find JSON budget block in {budget_doc}")

budget = json.loads(match.group(1))
failures = []

def size_of(rel_path: str) -> int:
    path = root / rel_path
    if not path.exists():
        failures.append(f"missing path: {rel_path}")
        return 0
    return path.stat().st_size

print("Token budget check")
print("")

for item in budget.get("files", []):
    actual = size_of(item["path"])
    label = item.get("label", item["path"])
    maximum = item["max"]
    baseline = item["baseline"]
    if actual > maximum:
        failures.append(
            f"file budget exceeded: {item['path']} actual={actual} max={maximum}"
        )
        print(f"- [fail] {label}: {actual} bytes (baseline {baseline}, max {maximum})")
    else:
        print(f"- [ok] {label}: {actual} bytes (baseline {baseline}, max {maximum})")

print("")

for bundle in budget.get("bundles", []):
    actual = sum(size_of(path) for path in bundle["paths"])
    maximum = bundle["max"]
    baseline = bundle["baseline"]
    if actual > maximum:
        failures.append(
            f"bundle budget exceeded: {bundle['name']} actual={actual} max={maximum}"
        )
        print(f"- [fail] {bundle['name']}: {actual} bytes (baseline {baseline}, max {maximum})")
    else:
        print(f"- [ok] {bundle['name']}: {actual} bytes (baseline {baseline}, max {maximum})")

if failures:
    print("")
    print("Budget failures:")
    for failure in failures:
        print(f"- {failure}")
    raise SystemExit(1)

print("")
print("Token budget checks passed.")
PY
