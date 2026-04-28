---
name: "ba-start"
description: "Lifecycle engine for BA-kit. Accepts raw requirements, normalizes them, locks scope, builds a requirements backbone, emits only the necessary downstream artifacts, and packages deliverables."
metadata:
  short-description: "Run the BA-kit lifecycle from explicit BA step commands."
---

<codex_skill_adapter>
## A. Skill Invocation
- This skill is invoked by mentioning `$ba-start`.
- Treat all user text after `$ba-start` as `{{BA_ARGS}}`.
- If no arguments are present, treat `{{BA_ARGS}}` as empty.

## B. AskUserQuestion -> request_user_input Mapping
BA workflows may use `AskUserQuestion` (Claude Code syntax). Translate to Codex `request_user_input` when available. If it is unavailable, ask one concise plain-text question instead.
</codex_skill_adapter>

<objective>
Run the explicit BA lifecycle step requested by the user.
</objective>

<required_reading>
Read these files in order:
- `@$HOME/.codex/ba-kit/contract.yaml`
- `@$HOME/.codex/ba-kit/contract-behavior.md`
- `@$HOME/.codex/skills/ba-start/steps/<active-step>.md`

The active step file depends on the resolved subcommand:
- no subcommand or `intake` -> `intake.md`
- `impact` -> `impact.md`
- `backbone` -> `backbone.md`
- `frd` -> `frd.md`
- `stories` -> `stories.md`
- `srs` -> `srs.md`, then load the narrower `srs-*.md` step files on demand
- `wireframes` -> `wireframes.md`
- `package` -> `package.md`
- `status` -> `status.md`
- `next` -> `@$HOME/.codex/ba-kit/workflows/next.md`
</required_reading>

<context>
{{BA_ARGS}}
</context>

<process>
1. Parse `{{BA_ARGS}}` using the shared contract.
2. Resolve the subcommand, slug, date, and module scope exactly.
3. Read only the matching step file.
4. Execute that step end-to-end using the shared contract and behavior rules.
</process>
