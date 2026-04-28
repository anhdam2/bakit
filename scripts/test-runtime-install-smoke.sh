#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TMP_HOME="$(mktemp -d)"
LOG_DIR="${TMP_HOME}/logs"

cleanup() {
  if [[ "${BA_KIT_KEEP_INSTALL_SMOKE_HOME:-0}" == "1" ]]; then
    printf 'Keeping smoke HOME at %s\n' "${TMP_HOME}"
  else
    rm -rf "${TMP_HOME}"
  fi
}
trap cleanup EXIT

mkdir -p "${LOG_DIR}"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

check_file() {
  local path="$1"
  [[ -f "${path}" ]] || fail "missing file: ${path}"
  printf '  OK: %s\n' "${path#"${TMP_HOME}/"}"
}

check_dir() {
  local path="$1"
  [[ -d "${path}" ]] || fail "missing directory: ${path}"
  printf '  OK: %s\n' "${path#"${TMP_HOME}/"}"
}

run_installer() {
  local runtime="$1"
  local log_path="${LOG_DIR}/${runtime}.log"
  shift

  printf 'Running %s installer...\n' "${runtime}"
  if ! HOME="${TMP_HOME}" "$@" >"${log_path}" 2>&1; then
    printf 'Installer failed: %s\n' "${runtime}" >&2
    sed -n '1,220p' "${log_path}" >&2
    exit 1
  fi
}

printf 'Runtime install smoke HOME: %s\n\n' "${TMP_HOME}"

run_installer "claude" bash "${ROOT_DIR}/install.sh"
run_installer "codex" bash "${ROOT_DIR}/scripts/install-codex-ba-kit.sh"
run_installer "antigravity" bash "${ROOT_DIR}/scripts/install-antigravity-ba-kit.sh"

printf '\nChecking installed runtime assets...\n'
check_file "${TMP_HOME}/.local/bin/ba-kit"
check_file "${TMP_HOME}/.local/share/ba-kit/installations/claude.env"
check_file "${TMP_HOME}/.local/share/ba-kit/installations/codex.env"
check_file "${TMP_HOME}/.local/share/ba-kit/installations/antigravity.env"

check_file "${TMP_HOME}/.claude/skills/ba-start/SKILL.md"
check_file "${TMP_HOME}/.claude/skills/ba-collab/SKILL.md"
check_file "${TMP_HOME}/.claude/skills/ba-start/steps/status.md"
check_file "${TMP_HOME}/.claude/templates/project-home-template.md"
check_file "${TMP_HOME}/.claude/templates/collab-home-template.md"
check_file "${TMP_HOME}/.claude/templates/project-memory-index-template.md"
check_file "${TMP_HOME}/.claude/ba-kit/contract.yaml"

check_file "${TMP_HOME}/.codex/skills/ba-start/SKILL.md"
check_file "${TMP_HOME}/.codex/skills/ba-collab/SKILL.md"
check_file "${TMP_HOME}/.codex/skills/ba-start/steps/status.md"
check_file "${TMP_HOME}/.codex/templates/project-home-template.md"
check_file "${TMP_HOME}/.codex/templates/collab-home-template.md"
check_file "${TMP_HOME}/.codex/templates/project-memory-index-template.md"
check_file "${TMP_HOME}/.codex/ba-kit/contract.yaml"
check_file "${TMP_HOME}/.codex/config.toml"

check_dir "${TMP_HOME}/.gemini/antigravity/knowledge/ba-kit-workflow"
check_file "${TMP_HOME}/.gemini/antigravity/knowledge/ba-kit-workflow/metadata.json"
check_file "${TMP_HOME}/.gemini/antigravity/knowledge/ba-kit-workflow/artifacts/workflow-reference.md"

printf '\nRunning installed CLI doctor...\n'
if ! HOME="${TMP_HOME}" BA_KIT_SKIP_UPDATE_CHECK=1 "${TMP_HOME}/.local/bin/ba-kit" doctor >"${LOG_DIR}/doctor.log" 2>&1; then
  sed -n '1,260p' "${LOG_DIR}/doctor.log" >&2
  fail "installed ba-kit doctor failed"
fi

if rg -q '^\- \[fail\]' "${LOG_DIR}/doctor.log"; then
  sed -n '1,260p' "${LOG_DIR}/doctor.log" >&2
  fail "installed ba-kit doctor reported failures"
fi

printf 'Runtime install smoke passed.\n'
