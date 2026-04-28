# BA-kit Instructions For Antigravity

## Canonical Sources

- `core/contract.yaml`
- `core/contract-behavior.md`
- `skills/ba-start/SKILL.md`

For non-trivial BA work, start from `skills/ba-start/SKILL.md` instead of improvising from the prompt alone.

## Automatic BA Routing

If the message matches one of these intents, read the indicated skill and execute it:

| User intent | Read this file | Then do |
| --- | --- | --- |
| Publishing to Notion | `skills/ba-notion/SKILL.md` | publish |
| Module claim/review/conflict/approve/integrate or GitHub handoff | `skills/ba-collab/SKILL.md` | collab |
| Checking status, completion, or missing artifacts | `skills/ba-start/SKILL.md` | run `status` |
| Continuing/resuming a project | `skills/ba-next/SKILL.md` | inspect and recommend |
| Asking what the next BA step should be | `skills/ba-next/SKILL.md` | inspect and recommend |
| Adding, changing, removing, or correcting a requirement or rule | `skills/ba-start/SKILL.md` | run `impact` |
| Naming a specific step such as `intake`, `backbone`, `frd`, `stories`, `srs`, `wireframes`, or `package` | `skills/ba-start/SKILL.md` | run that step |
| Providing raw requirements or business context for a new engagement | `skills/ba-start/SKILL.md` | run the full lifecycle |
| Other freeform BA requests | `skills/ba-do/SKILL.md` | route to the right command |

If a message could match both `impact` and a direct edit, prefer `impact` unless the user explicitly asks to update, overwrite, regenerate, or rerun a named artifact.

## Runtime Defaults

- Write BA deliverables in Vietnamese by default unless the user explicitly requests English.
- Use exact slug/date/module matching. Never choose by mtime.
- Default to `hybrid` mode for solo IT BA work.
- Treat the backbone as the source of truth after intake.
- Treat `plans/{slug}-{date}/PROJECT-HOME.md` as the BA-facing dashboard, not source of truth.
- Treat `plans/{slug}-{date}/02_backbone/project-memory.md` as persisted memory. In shard mode, read `project-memory/index.md` first.
- Keep module-scoped artifacts inside `plans/{slug}-{date}/03_modules/{module_slug}/`.
- When UI-backed scope needs wireframe support, prepare a manual wireframe constraint pack and let the user create and attach the actual mockup themselves.
- Use **incremental section-by-section writes** for large artifacts to avoid output token truncation.
- Preserve HITL guarantees: granular intervention, active push-back, fail-closed routing.

## Delivery Expectations

- Use `templates/` when a matching template exists.
- Keep final compiled HTML under `plans/{slug}-{date}/04_compiled/`.
- Keep active delegation trackers under `plans/{slug}-{date}/delegation/`.
- Prefer narrow handoff context to sub-agents instead of dumping full upstream documents.

## BA-Friendly Language

Accept Vietnamese first, then show internal step: tạo dự án -> intake; tiếp tục -> next; thay đổi -> impact; handoff UI -> wireframes; bàn giao -> package; trạng thái -> status.

Collab NLP -> `ba-collab`; GitHub commit/push/PR/merge requires explicit approval.
