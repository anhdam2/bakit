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
    "BA-kit workflow reference for Antigravity. Covers BA-friendly resume prompts, PROJECT-HOME.md usage, lifecycle routing, agent roles, template mapping, and artifact conventions." \
    "BA-kit Workflow Reference"

  cat > "${artifacts_dir}/workflow-reference.md" <<'KIEOF'
# BA-kit Workflow Reference For Antigravity

> Use this KI to understand the BA-kit lifecycle when working inside Antigravity.

## BA Lifecycle

1. Accept input → Parse into intake form
2. Create or refresh PROJECT-HOME.md as the BA-facing dashboard
3. Gap analysis → Clarifying questions
4. Scope lock → Select mode (lite/hybrid/formal)
5. Build requirements backbone (source of truth)
6. Emit downstream artifacts only when gates are open:
   - FRD, user stories, selective SRS, wireframe constraints
7. Manual wireframe handoff preparation from persisted input pack
8. Final screen descriptions with the wireframe handoff map
9. Quality review and HTML packaging

## BA-Friendly Entrypoints

Prefer natural Vietnamese intent first, then map to the internal workflow:

| BA says | Internal workflow |
|---------|-------------------|
| "Tạo dự án mới từ tài liệu này" | intake/full lifecycle |
| "Tiếp tục dự án này" | read PROJECT-HOME.md, then ba-next |
| "Tôi nên làm gì tiếp?" | ba-next |
| "Đánh giá thay đổi này" | impact |
| "Chuẩn bị handoff UI" | wireframes/manual handoff pack |
| "Xuất gói bàn giao" | package |
| "Kiểm tra trạng thái" | status |
| "Tôi nhận module X" | ba-collab claim |
| "Gửi module X cho Lead BA review" | ba-collab review packet |
| "Tạo PR cho module X" | ba-collab GitHub handoff; approval required |

PROJECT-HOME.md is a dashboard only. Use it to orient the user, but verify the contract artifacts before mutating anything.
COLLAB-HOME.md and MODULE-HOME.md are BA-facing collaboration dashboards. GitHub commit/push/PR/merge requires explicit user approval.

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
| `/ba-collab <description>` | "Read skills/ba-collab/SKILL.md and run collaboration workflow: <description>" |

## Agent Roles (reference only — no auto-delegation in Antigravity)

| Agent | Focus | Agent File |
|-------|-------|------------|
| requirements-engineer | Backbone, FRD, stories, SRS content | agents/requirements-engineer.md |
| ui-ux-designer | Wireframe constraints and handoff checklist | agents/ui-ux-designer.md |
| ba-documentation-manager | Quality, packaging, consistency | agents/ba-documentation-manager.md |
| ba-researcher | Domain research | agents/ba-researcher.md |

## Key Templates

| Artifact | Template |
|----------|----------|
| Intake form | templates/intake-form-template.md |
| Project Home / BA dashboard | templates/project-home-template.md |
| Collab Home / BA collaboration dashboard | templates/collab-home-template.md |
| Module Home | templates/module-home-template.md |
| Module review packet | templates/review-packet-template.md |
| Requirements backbone | templates/requirements-backbone-template.md |
| FRD | templates/frd-template.md |
| User stories | templates/user-story-template.md |
| SRS | templates/srs-template.md |
| Design system | templates/design-md-template.md |
| Wireframe input | templates/wireframe-input-template.md |
| Wireframe map | templates/wireframe-map-template.md |
| Project memory summary | templates/project-memory-template.md |
| Project memory index | templates/project-memory-index-template.md |
| Memory packet | templates/memory-packet-template.md |
| File-back record | templates/project-memory-fileback-record-template.md |

## Defaults

- Language: Vietnamese (unless English explicitly requested)
- Date token: YYMMDD-HHmm
- Mode: hybrid
- UI baseline: Shadcn UI (unless DESIGN.md overrides)
- Canonical contract: core/contract.yaml + core/contract-behavior.md
- Memory: compact `project-memory.md` by default; shard mode navigates via `project-memory/index.md` first
- Delegation: pass bounded packets, not full memory trees or merged artifacts
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
