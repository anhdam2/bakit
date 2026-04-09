#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGET_HOME="${HOME}/.gemini/antigravity"
KI_BASE="${TARGET_HOME}/knowledge"
BA_KIT_KI="${KI_BASE}/ba-kit-workflow"
LOCAL_BIN_TARGET="${HOME}/.local/bin"
STATE_TARGET="${HOME}/.local/share/ba-kit/installations"

ensure_dir() {
  mkdir -p "$1"
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
  cat > "${STATE_TARGET}/antigravity.env" <<EOF
BA_KIT_RUNTIME=antigravity
BA_KIT_SOURCE_REPO=${ROOT_DIR}
BA_KIT_INSTALLED_AT=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
BA_KIT_INSTALLER=scripts/install-antigravity-ba-kit.sh
EOF
}

create_ki_metadata() {
  local ki_dir="$1"
  local summary="$2"
  local title="$3"
  ensure_dir "${ki_dir}"
  cat > "${ki_dir}/metadata.json" <<EOF
{
  "title": "${title}",
  "summary": "${summary}",
  "created": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")",
  "references": [
    {
      "type": "file",
      "path": "${ROOT_DIR}/GEMINI.md"
    },
    {
      "type": "file",
      "path": "${ROOT_DIR}/core/contract-behavior.md"
    },
    {
      "type": "file",
      "path": "${ROOT_DIR}/skills/ba-start/SKILL.md"
    }
  ]
}
EOF
}

create_workflow_ki() {
  local artifacts_dir="${BA_KIT_KI}/artifacts"
  ensure_dir "${artifacts_dir}"

  create_ki_metadata "${BA_KIT_KI}" \
    "BA-kit workflow reference for Antigravity. Covers the BA lifecycle, prompt patterns for invoking BA-kit commands without slash commands, agent roles, template mapping, and artifact conventions." \
    "BA-kit Workflow Reference"

  cat > "${artifacts_dir}/workflow-reference.md" <<'KIEOF'
# BA-kit Workflow Reference For Antigravity

> Use this KI to understand the BA-kit lifecycle when working inside Antigravity.

## BA Lifecycle

1. Accept input → Parse into intake form
2. Gap analysis → Clarifying questions
3. Scope lock → Select mode (lite/hybrid/formal)
4. Build requirements backbone (source of truth)
5. Emit downstream artifacts only when gates are open:
   - FRD, user stories, selective SRS, wireframes
6. Wireframe generation from persisted input pack
7. Final screen descriptions with wireframe map
8. Quality review and HTML packaging

## Prompt Patterns (Antigravity has no slash commands)

| Claude Code Command | Antigravity Prompt Equivalent |
|---------------------|-------------------------------|
| `/ba-start` | "Read skills/ba-start/SKILL.md and run the full BA workflow" |
| `/ba-start intake <file>` | "Read skills/ba-start/SKILL.md and run intake for <file>" |
| `/ba-start backbone --slug X` | "Read skills/ba-start/SKILL.md and run backbone for slug X" |
| `/ba-start frd --slug X --module Y` | "Read skills/ba-start/SKILL.md and run frd for slug X module Y" |
| `/ba-start stories --slug X --module Y` | "Read skills/ba-start/SKILL.md and run stories for slug X module Y" |
| `/ba-start srs --slug X --module Y` | "Read skills/ba-start/SKILL.md and run srs for slug X module Y" |
| `/ba-start wireframes --slug X --module Y` | "Read skills/ba-start/SKILL.md and run wireframes for slug X module Y" |
| `/ba-start package --slug X` | "Read skills/ba-start/SKILL.md and run package for slug X" |
| `/ba-start status --slug X` | "Read skills/ba-start/SKILL.md and run status for slug X" |
| `/ba-start impact --slug X` | "Read skills/ba-start/SKILL.md and run impact for slug X" |
| `/ba-do <description>` | "Read skills/ba-do/SKILL.md and route: <description>" |
| `/ba-next --slug X` | "Read skills/ba-next/SKILL.md and inspect slug X" |

## Agent Roles (reference only — no auto-delegation in Antigravity)

| Agent | Focus | Agent File |
|-------|-------|------------|
| requirements-engineer | Backbone, FRD, stories, SRS content | agents/requirements-engineer.md |
| ui-ux-designer | Wireframe generation | agents/ui-ux-designer.md |
| ba-documentation-manager | Quality, packaging, consistency | agents/ba-documentation-manager.md |
| ba-researcher | Domain research | agents/ba-researcher.md |

## Key Templates

| Artifact | Template |
|----------|----------|
| Intake form | templates/intake-form-template.md |
| Requirements backbone | templates/requirements-backbone-template.md |
| FRD | templates/frd-template.md |
| User stories | templates/user-story-template.md |
| SRS | templates/srs-template.md |
| Design system | templates/design-md-template.md |
| Wireframe input | templates/wireframe-input-template.md |
| Wireframe map | templates/wireframe-map-template.md |

## Defaults

- Language: Vietnamese (unless English explicitly requested)
- Date token: YYMMDD-HHmm
- Mode: hybrid
- UI baseline: Shadcn UI (unless DESIGN.md overrides)
- Canonical contract: core/contract.yaml + core/contract-behavior.md
KIEOF
}

echo "Installing BA-kit for Antigravity from: ${ROOT_DIR}"

ensure_dir "${TARGET_HOME}"
ensure_dir "${KI_BASE}"

create_workflow_ki
install_cli
write_manifest

echo "Created BA-kit KI at ${BA_KIT_KI}"
echo "Installed update CLI to ${LOCAL_BIN_TARGET}/ba-kit"
echo "BA-kit Antigravity installation complete."
echo ""
echo "Antigravity reads GEMINI.md and AGENTS.md directly from the repo."
echo "Use prompt patterns like 'Read skills/ba-start/SKILL.md and run intake' to invoke BA workflows."
