---
name: ba-do
description: Route freeform BA text to the right BA-kit command automatically.
argument-hint: "<description of the BA task or requirement change>"
allowed-tools:
  - Read
  - Bash
  - AskUserQuestion
---

# BA Do

Use this command when you know what you want to do in a BA workflow but do not know which BA-kit command should handle it.

## Invocation

```text
/ba-do xem next step cho project nay
/ba-do dang lam do SRS thi them yeu cau nay
/ba-do toi nhan module auth-flow
/ba-do gui module payment cho Lead BA review
/ba-do publish SRS len Notion
```

<execution_context>
Read `core/workflows/do.md`, `core/contract.yaml`, `core/contract-behavior.md` from the repo root.
</execution_context>

<context>
$ARGUMENTS
</context>

<process>
Execute the BA routing workflow from `core/workflows/do.md` end-to-end.
Dispatch to `ba-impact`, `ba-next`, `ba-start`, `ba-collab`, or `ba-notion`.
</process>
