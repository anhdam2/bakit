#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SOURCE_ROOT="${BA_KIT_CODEX_SOURCE_ROOT:-${ROOT_DIR}/codex}"
SOURCE_SKILLS="${SOURCE_ROOT}/skills"
SOURCE_AGENTS="${SOURCE_ROOT}/agents"
CORE_SOURCE="${BA_KIT_CORE_SOURCE_ROOT:-${ROOT_DIR}/core}"
TARGET_HOME="${HOME}/.codex"
TARGET_SKILLS="${TARGET_HOME}/skills"
TARGET_AGENTS="${TARGET_HOME}/agents"
CORE_TARGET="${TARGET_HOME}/ba-kit"
TARGET_CONFIG="${TARGET_HOME}/config.toml"
LOCAL_BIN_TARGET="${HOME}/.local/bin"
STATE_TARGET="${HOME}/.local/share/ba-kit/installations"

if [[ ! -d "${SOURCE_SKILLS}" ]] && [[ ! -d "${SOURCE_AGENTS}" ]]; then
  echo "BA-kit Codex conversion not found."
  echo "Expected converted assets under: ${SOURCE_ROOT}/skills and ${SOURCE_ROOT}/agents"
  echo "Set BA_KIT_CODEX_SOURCE_ROOT if your converted assets live elsewhere."
  exit 1
fi

install_cli() {
  local temp_target
  mkdir -p "${LOCAL_BIN_TARGET}"
  temp_target="$(mktemp "${LOCAL_BIN_TARGET}/ba-kit.tmp.XXXXXX")"
  cp "${ROOT_DIR}/scripts/ba-kit" "${temp_target}"
  chmod +x "${temp_target}"
  mv "${temp_target}" "${LOCAL_BIN_TARGET}/ba-kit"
}

copy_tree() {
  local source_dir="$1"
  local target_dir="$2"

  mkdir -p "$target_dir"
  cp -R "${source_dir}/." "$target_dir/"
}

write_manifest() {
  mkdir -p "${STATE_TARGET}"
  cat > "${STATE_TARGET}/codex.env" <<EOF
BA_KIT_RUNTIME=codex
BA_KIT_SOURCE_REPO=${ROOT_DIR}
BA_KIT_INSTALLED_AT=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
BA_KIT_INSTALLER=scripts/install-codex-ba-kit.sh
EOF
}

node - "${SOURCE_SKILLS}" "${SOURCE_AGENTS}" "${TARGET_HOME}" "${TARGET_SKILLS}" "${TARGET_AGENTS}" "${TARGET_CONFIG}" <<'NODE'
const fs = require("node:fs");
const path = require("node:path");

const [sourceSkills, sourceAgents, targetHome, targetSkills, targetAgents, targetConfig] =
  process.argv.slice(2);

const ensureDir = (dirPath) => {
  fs.mkdirSync(dirPath, { recursive: true });
};

const copyContents = (sourceDir, targetDir) => {
  if (!fs.existsSync(sourceDir)) {
    return [];
  }

  ensureDir(targetDir);
  const copied = [];

  for (const entry of fs.readdirSync(sourceDir, { withFileTypes: true })) {
    const sourcePath = path.join(sourceDir, entry.name);
    const targetPath = path.join(targetDir, entry.name);
    fs.cpSync(sourcePath, targetPath, {
      recursive: true,
      force: true,
      dereference: false,
      preserveTimestamps: true,
    });
    copied.push(targetPath);
  }

  return copied;
};

const parseField = (content, field) => {
  const match = content.match(new RegExp(`^${field}\\s*=\\s*"((?:\\\\.|[^"])*)"$`, "m"));
  if (!match) {
    return "";
  }

  return match[1].replace(/\\"/g, '"');
};

const escapeTomlString = (value) => value.replace(/\\/g, "\\\\").replace(/"/g, '\\"');

const appendAgentRegistration = (configPath, agentTomlPath) => {
  const content = fs.readFileSync(agentTomlPath, "utf8");
  const agentName =
    parseField(content, "name") || path.basename(agentTomlPath, path.extname(agentTomlPath));
  const description =
    parseField(content, "description") || `Codex BA agent from ${path.basename(agentTomlPath)}`;
  const registrationHeader = `[agents.${agentName}]`;
  const registrationBlock = [
    registrationHeader,
    `description = "${escapeTomlString(description)}"`,
    `config_file = "agents/${path.basename(agentTomlPath)}"`,
    "",
  ].join("\n");

  const configContent = fs.existsSync(configPath) ? fs.readFileSync(configPath, "utf8") : "";
  const headerPattern = new RegExp(`^\\[agents\\.${agentName.replace(/[.*+?^${}()|[\]\\]/g, "\\$&")}\\]$`, "m");
  if (headerPattern.test(configContent)) {
    return false;
  }

  ensureDir(path.dirname(configPath));
  const updated =
    configContent.length === 0
      ? registrationBlock
      : `${configContent}${configContent.endsWith("\n") ? "\n" : "\n\n"}${registrationBlock}`;
  fs.writeFileSync(configPath, updated);
  return true;
};

ensureDir(targetHome);
ensureDir(targetSkills);
ensureDir(targetAgents);

const installedSkills = copyContents(sourceSkills, targetSkills);
const installedAgents = copyContents(sourceAgents, targetAgents);

const registrations = [];
for (const entry of installedAgents) {
  if (entry.endsWith(".toml")) {
    if (appendAgentRegistration(targetConfig, entry)) {
      registrations.push(path.basename(entry, ".toml"));
    }
  }
}

console.log(`Installed skills into ${targetSkills}`);
console.log(`Installed agents into ${targetAgents}`);
if (installedSkills.length === 0) {
  console.log("No skill files were found to install.");
}
if (installedAgents.length === 0) {
  console.log("No agent files were found to install.");
}
if (registrations.length > 0) {
  console.log(`Registered Codex agents in ${targetConfig}: ${registrations.join(", ")}`);
} else {
  console.log(`No new agent registrations were needed in ${targetConfig}`);
}
NODE

install_cli
if [[ -d "${CORE_SOURCE}" ]]; then
  copy_tree "${CORE_SOURCE}" "${CORE_TARGET}"
  echo "Installed BA core to ${CORE_TARGET}"
fi
write_manifest
echo "Installed update CLI to ${LOCAL_BIN_TARGET}/ba-kit"
