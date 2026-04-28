---
name: "ba-do"
description: "Route freeform BA text to the right BA-kit command automatically."
metadata:
  short-description: "Route freeform BA text to the right BA-kit command automatically."
---

<codex_skill_adapter>
## A. Skill Invocation
- This skill is invoked by mentioning `$ba-do`.
- Treat all user text after `$ba-do` as `{{BA_ARGS}}`.
- If no arguments are present, treat `{{BA_ARGS}}` as empty.

## B. AskUserQuestion → request_user_input Mapping
BA workflows may use `AskUserQuestion` (Claude Code syntax). Translate to Codex `request_user_input`:

- `header` -> `header`
- `question` -> `question`
- option text -> `{label, description}`

If `request_user_input` is unavailable, ask a concise plain-text question instead.
</codex_skill_adapter>

<objective>
Analyze freeform BA text and dispatch to the most appropriate BA-kit command.

This is a dispatcher. It should not do the downstream BA work itself.
</objective>

<execution_context>
@$HOME/.codex/ba-kit/workflows/do.md
@$HOME/.codex/ba-kit/contract.yaml
@$HOME/.codex/ba-kit/contract-behavior.md
</execution_context>

<context>
{{BA_ARGS}}
</context>

<process>
Execute the BA routing workflow from @$HOME/.codex/ba-kit/workflows/do.md end-to-end.
Dispatch to `ba-impact`, `ba-next`, `ba-start`, `ba-collab`, or `ba-notion`.
</process>
