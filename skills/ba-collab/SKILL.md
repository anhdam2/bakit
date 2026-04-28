---
name: ba-collab
description: Route BA-friendly collaboration requests into module ownership, review packets, and optional approval-gated GitHub handoff.
argument-hint: "<claim module|send review|check conflict|approve|integrate>"
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash
  - AskUserQuestion
---

# BA Collab

Use this command when a BA describes teamwork, module ownership, review, PR, commit, merge, or GitHub handoff in natural language.

## Invocation

```text
/ba-collab Tôi nhận module auth-flow
/ba-collab Kiểm tra module payment trước khi gửi review
/ba-collab Tôi làm xong module payment, gửi Lead BA review
/ba-collab Lead BA approve module auth-flow
/ba-collab Tạo PR cho module auth-flow
```

<execution_context>
Read `core/workflows/collab.md`, `core/contract.yaml`, and `core/contract-behavior.md` from the repo root.
</execution_context>

<context>
$ARGUMENTS
</context>

<process>
Execute the BA collaboration workflow from `core/workflows/collab.md` end-to-end.

Rules:
- Treat GitHub as an optional transport layer, not the BA-facing workflow.
- Do not commit, push, create PR, request review, or merge without explicit user approval.
- If the request changes requirements or shared decisions, route to `impact` first.
- Keep module work inside the assigned module scope unless Lead BA approves escalation.
</process>
