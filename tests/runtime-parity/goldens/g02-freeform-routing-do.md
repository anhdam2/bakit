# Golden: F02 — Freeform Routing via ba-do

## Behavior Envelope

| Field | Expected Value |
| --- | --- |
| resolved_command | ba-impact |
| resolved_slug | test-project |
| source_of_truth_artifact | plans/test-project-20260424/02_backbone/backbone.md |
| read_scope | plans/test-project-20260424/02_backbone/backbone.md |
| write_target | NONE |
| approval_gate | REQUIRED |
| activation_level | Base |
| fallback_code | NONE |

## Runtime Parity Check

| Runtime | Status |
| --- | --- |
| Claude Code | PENDING |
| Codex | PENDING |
| Antigravity | PENDING |

## Notes

- Input is raw freeform Vietnamese text — no explicit command prefix.
- Correct routing: freeform requirement mutation → `ba-impact`, not `ba-do` directly.
- Any runtime that routes directly to `ba-do` and writes without impact assessment fails parity.
- `write_target: NONE` is required at this stage; impact summary is read-only output.
- Approval gate must be presented to user before any downstream artifact mutation.
