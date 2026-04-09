---
name: "ba-impact"
description: "Analyze requirement changes against the current BA artifact set and recommend the next exact commands without mutating artifacts."
metadata:
  short-description: "Analyze requirement changes against the current BA artifact set and recommend the next exact commands without mutating artifacts."
---

<codex_skill_adapter>
## A. Skill Invocation
- This skill is invoked by mentioning `$ba-impact`.
- Treat all user text after `$ba-impact` as `{{BA_ARGS}}`.
- If no arguments are present, treat `{{BA_ARGS}}` as empty.

## B. AskUserQuestion → request_user_input Mapping
BA workflows may use `AskUserQuestion` (Claude Code syntax). Translate to Codex `request_user_input`:

- `header` -> `header`
- `question` -> `question`
- option text -> `{label, description}`

If `request_user_input` is unavailable, ask a concise plain-text question instead.
</codex_skill_adapter>

<objective>
Run BA change-impact triage for an existing project set.

This command must not mutate artifacts. It should analyze the change first, then return the next commands.
</objective>

<execution_context>
@$HOME/.codex/ba-kit/workflows/impact.md
@$HOME/.codex/ba-kit/contract.yaml
@$HOME/.codex/ba-kit/contract-behavior.md
</execution_context>

<context>
{{BA_ARGS}}
</context>

<process>
Execute the BA impact workflow from @$HOME/.codex/ba-kit/workflows/impact.md end-to-end.
Follow the installed `ba-start` impact contract exactly and return analysis only.
</process>
