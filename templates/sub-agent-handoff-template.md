# Sub-Agent Handoff Template

Use this template when delegating BA work to a specialist agent. Keep the packet narrow. Do not attach full merged artifacts when exact excerpts are enough.

## Delegation Packet

- Owner: `requirements-engineer | ui-ux-designer | ba-documentation-manager | ba-researcher`
- Objective: [single concrete goal]
- Target Artifact: [exact path]
- Allowed Write Scope: [exact section(s) or file(s)]

## Trace IDs

- FR: [...]
- UC: [...]
- SCR: [...]
- Stories: [...]

## Required Upstream Excerpts

- [artifact path + exact section]
- [artifact path + exact section]

## Constraints

- [template, rule, or design-system constraint only if relevant]

## Expected Output

- [exact sections or deliverables]

## Stop Conditions

- Stop if required upstream context is missing.
- Stop if the scope is too large to keep terminology and traceability consistent.
- Do not infer missing IDs, requirements, or screen behavior.

## Repartition Response

If the slice is overloaded or underspecified, return this format instead of guessing:

```md
NEEDS_REPARTITION

- Overloaded Scope: [artifact/section]
- Reason: [why the current slice is too large or underspecified]
- Smallest Viable Split:
  - [slice 1]
  - [slice 2]
- Required Upstream Inputs For Rerun:
  - [exact path + section]
  - [exact IDs]
```
