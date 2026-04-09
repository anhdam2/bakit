# BA-kit Instructions For Claude Code

BA-kit turns Claude Code into a senior business-analysis workstation focused on structured deliverables and deterministic lifecycle routing.

## Canonical Sources

- `core/contract.yaml` — exact paths, prerequisites, states, and defaults
- `core/contract-behavior.md` — routing, recovery, execution lock, and delegation behavior
- `skills/ba-start/SKILL.md` — lifecycle stub that dispatches into the active step file

For non-trivial BA work, start from `skills/ba-start/SKILL.md` instead of improvising from the prompt alone.

## Core Defaults

- Write BA deliverables in Vietnamese by default unless the user explicitly requests English.
- Use exact slug/date/module resolution. Never choose by mtime.
- Default to `hybrid` mode for solo IT BA work.
- Route requirement changes through `impact` before mutating downstream artifacts unless the edit is clearly wording-only.
- Keep the accepted rerun step locked once the user explicitly approves it.

## Artifact Model

- Project root: `plans/{slug}-{date}/`
- Intake: `01_intake/intake.md`
- Plan: `01_intake/plan.md`
- Backbone: `02_backbone/backbone.md`
- Module artifacts: `03_modules/{module_slug}/`
- Compiled HTML: `04_compiled/`
- Delegation trackers: `delegation/`

## Delegation

Use agent roles under `agents/` when delegation improves quality or throughput.

- `requirements-engineer` for backbone, FRD, stories, and selective SRS content
- `ui-ux-designer` for wireframe generation
- `ba-documentation-manager` for validation, quality review, and packaging
- `ba-researcher` for domain research

Always pass narrow packets: exact path, write scope, trace IDs, and targeted excerpts. Do not attach full merged artifacts when exact sections are enough.
