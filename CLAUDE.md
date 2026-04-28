# BA-kit Instructions For Claude Code

## Canonical Sources

- `core/contract.yaml`
- `core/contract-behavior.md`
- `skills/ba-start/SKILL.md` — lifecycle stub that dispatches into the active step file

For non-trivial BA work, start from `skills/ba-start/SKILL.md` instead of improvising from the prompt alone.

## Core Defaults

- Write BA deliverables in Vietnamese by default unless the user explicitly requests English.
- Use exact slug/date/module resolution. Never choose by mtime.
- Default to `hybrid` mode for solo IT BA work.
- Treat `plans/{slug}-{date}/02_backbone/project-memory.md` as persisted project memory; do not rely on Claude chat memory as the system of record.
- Route requirement changes through `impact` before mutating downstream artifacts unless the edit is clearly wording-only.
- Keep the accepted rerun step locked once the user explicitly approves it.
- Use **incremental section-by-section writes** for large artifacts to avoid output token truncation.
- Apply runtime-neutral HITL behavior: granular artifact intervention, active push-back on material ambiguity, and fail-closed routing instead of plausible guessing.

## Artifact Model

- Project root: `plans/{slug}-{date}/`
- Project Home: `PROJECT-HOME.md` — BA-facing dashboard
- Intake: `01_intake/intake.md`
- Plan: `01_intake/plan.md`
- Backbone: `02_backbone/backbone.md`
- Project memory (compact): `02_backbone/project-memory.md`
- Project memory shards: `02_backbone/project-memory/`
- Module artifacts: `03_modules/{module_slug}/`
- Compiled HTML: `04_compiled/`
- Delegation: `delegation/`, `delegation/packets/`
- Collaboration: `COLLAB-HOME.md`, `MODULE-HOME.md`, `delegation/review-packets/`

## Delegation

Use agent roles under `agents/` when delegation improves quality or throughput.

- `requirements-engineer` for backbone, FRD, stories, and selective SRS content
- `ui-ux-designer` for wireframe constraint packs and manual handoff checklists
- `ba-documentation-manager` for validation, quality review, and packaging
- `ba-researcher` for domain research

Always pass narrow packets: exact path, write scope, trace IDs, and targeted excerpts. Do not attach full merged artifacts when exact sections are enough.

## BA-Friendly UX

Use `PROJECT-HOME.md` to resume, lead with friendly labels, then show commands: tạo dự án mới -> intake; tiếp tục -> next; thay đổi -> impact; handoff UI -> wireframes; bàn giao -> package. Verify source-of-truth before mutation.

Route module collaboration NLP to `ba-collab`. Commit/push/PR/merge require explicit approval.
