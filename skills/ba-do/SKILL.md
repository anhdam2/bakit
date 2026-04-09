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
/ba-do publish SRS len Notion
```

<execution_context>
@$HOME/.claude/ba-kit/workflows/do.md
@$HOME/.claude/ba-kit/contract.yaml
@$HOME/.claude/ba-kit/contract-behavior.md
</execution_context>

<context>
$ARGUMENTS
</context>

<process>
Execute the BA routing workflow from @$HOME/.claude/ba-kit/workflows/do.md end-to-end.
Dispatch to `ba-impact`, `ba-next`, `ba-start`, or `ba-notion`.
</process>
