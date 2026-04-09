---
name: "ba-next"
description: "Detect the next logical BA-kit step from the current artifact set."
metadata:
  short-description: "Detect the next logical BA-kit step from the current artifact set."
---

<codex_skill_adapter>
## A. Skill Invocation
- This skill is invoked by mentioning `$ba-next`.
- Treat all user text after `$ba-next` as `{{BA_ARGS}}`.
- If no arguments are present, treat `{{BA_ARGS}}` as empty.

## B. AskUserQuestion → request_user_input Mapping
BA workflows may use `AskUserQuestion` (Claude Code syntax). Translate to Codex `request_user_input`:

- `header` -> `header`
- `question` -> `question`
- option text -> `{label, description}`

If `request_user_input` is unavailable, ask a concise plain-text question instead.
</codex_skill_adapter>

<objective>
Detect the next logical BA step from the current BA artifact set and recommend the exact command to run next.
</objective>

<execution_context>
@$HOME/.codex/ba-kit/workflows/next.md
@$HOME/.codex/ba-kit/contract.yaml
@$HOME/.codex/ba-kit/contract-behavior.md
</execution_context>

<context>
{{BA_ARGS}}
</context>

<process>
Execute the BA next-step workflow from @$HOME/.codex/ba-kit/workflows/next.md end-to-end.
Recommend the next exact command without mutating artifacts.
</process>
