# BA-kit Instructions For Antigravity

BA-kit turns Antigravity into a senior business analysis workstation. Default to business-analysis workflows, structured deliverables, and clear decision support.

## Canonical Sources

- `core/contract.yaml` — exact paths, prerequisites, states, and defaults
- `core/contract-behavior.md` — routing, recovery, execution lock, and delegation behavior
- `skills/ba-start/SKILL.md` — lifecycle stub that dispatches into the active step file

For non-trivial BA work, start from `skills/ba-start/SKILL.md` instead of improvising from the prompt alone.

## Automatic BA Routing

If the message matches one of these intents, read the indicated skill and execute it:

| User intent | Read this file | Then do |
| --- | --- | --- |
| Publishing BA artifacts to Notion | `skills/ba-notion/SKILL.md` | execute the publish workflow |
| Checking status, completion, or missing artifacts | `skills/ba-start/SKILL.md` | run `status` |
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
- Keep module-scoped artifacts inside `plans/{slug}-{date}/03_modules/{module_slug}/`.
- Never use built-in image generation for wireframes; persist `.pen` artifacts and runtime `DESIGN.md` instead.

## Delivery Expectations

- Use `templates/` when a matching template exists.
- Keep final compiled HTML under `plans/{slug}-{date}/04_compiled/`.
- Keep active delegation trackers under `plans/{slug}-{date}/delegation/`.
- Prefer narrow handoff context to sub-agents instead of dumping full upstream documents.
