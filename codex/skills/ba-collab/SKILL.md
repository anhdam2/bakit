---
name: "ba-collab"
description: "Route BA-friendly collaboration requests into module ownership, review packets, and optional approval-gated GitHub handoff."
metadata:
  short-description: "Run BA collaboration workflow without exposing Git first."
---

<codex_skill_adapter>
## A. Skill Invocation
- This skill is invoked by mentioning `$ba-collab`.
- Treat all user text after `$ba-collab` as `{{BA_ARGS}}`.
- If no arguments are present, treat `{{BA_ARGS}}` as empty.

## B. AskUserQuestion -> request_user_input Mapping
BA workflows may use `AskUserQuestion` (Claude Code syntax). Translate to Codex `request_user_input` when available. If unavailable, ask one concise plain-text question.
</codex_skill_adapter>

<objective>
Run the BA collaboration workflow for module ownership, review packets, and optional GitHub handoff.
</objective>

<execution_context>
@$HOME/.codex/ba-kit/workflows/collab.md
@$HOME/.codex/ba-kit/contract.yaml
@$HOME/.codex/ba-kit/contract-behavior.md
</execution_context>

<context>
{{BA_ARGS}}
</context>

<process>
Execute the BA collaboration workflow from @$HOME/.codex/ba-kit/workflows/collab.md end-to-end.
Do not commit, push, create PR, request review, or merge without explicit user approval.
</process>
