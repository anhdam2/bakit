#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_HOME="${HOME}/.claude"
SKILLS_TARGET="${TARGET_HOME}/skills"
RULES_TARGET="${TARGET_HOME}/rules/ba-kit"
AGENTS_TARGET="${TARGET_HOME}/agents"
TEMPLATES_TARGET="${TARGET_HOME}/templates"
CORE_SOURCE="${ROOT_DIR}/core"
CORE_TARGET="${TARGET_HOME}/ba-kit"
LOCAL_BIN_TARGET="${HOME}/.local/bin"
STATE_TARGET="${HOME}/.local/share/ba-kit/installations"

copy_tree() {
  local source_dir="$1"
  local target_dir="$2"

  mkdir -p "$target_dir"
  cp -R "${source_dir}/." "$target_dir/"
}

install_cli() {
  local temp_target
  mkdir -p "${LOCAL_BIN_TARGET}"
  temp_target="$(mktemp "${LOCAL_BIN_TARGET}/ba-kit.tmp.XXXXXX")"
  cp "${ROOT_DIR}/scripts/ba-kit" "${temp_target}"
  chmod +x "${temp_target}"
  mv "${temp_target}" "${LOCAL_BIN_TARGET}/ba-kit"
}

write_manifest() {
  mkdir -p "${STATE_TARGET}"
  cat > "${STATE_TARGET}/claude.env" <<EOF
BA_KIT_RUNTIME=claude
BA_KIT_SOURCE_REPO=${ROOT_DIR}
BA_KIT_INSTALLED_AT=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
BA_KIT_INSTALLER=install.sh
EOF
}

echo "Installing BA-kit from: ${ROOT_DIR}"
mkdir -p "${TARGET_HOME}"

mkdir -p "${SKILLS_TARGET}"
for skill_dir in "${ROOT_DIR}"/skills/*; do
  if [[ -d "${skill_dir}" ]]; then
    copy_tree "${skill_dir}" "${SKILLS_TARGET}/$(basename "${skill_dir}")"
  fi
done
copy_tree "${ROOT_DIR}/rules" "${RULES_TARGET}"
copy_tree "${ROOT_DIR}/agents" "${AGENTS_TARGET}"
copy_tree "${ROOT_DIR}/templates" "${TEMPLATES_TARGET}"
copy_tree "${CORE_SOURCE}" "${CORE_TARGET}"
install_cli
write_manifest

mkdir -p "${ROOT_DIR}/docs" "${ROOT_DIR}/templates" "${ROOT_DIR}/designs"

echo "Installed skills to ${SKILLS_TARGET}"
echo "Installed rules to ${RULES_TARGET}"
echo "Installed agents to ${AGENTS_TARGET}"
echo "Installed templates to ${TEMPLATES_TARGET}"
echo "Installed BA core to ${CORE_TARGET}"
echo "Installed update CLI to ${LOCAL_BIN_TARGET}/ba-kit"
echo "BA-kit installation complete."
