# Golden: F01 — Summary-Only Compact Mode

## Behavior Envelope

| Field | Expected Value |
| --- | --- |
| resolved_command | ba-start status |
| resolved_slug | test-project |
| source_of_truth_artifact | plans/test-project-20260424/02_backbone/project-memory.md |
| read_scope | plans/test-project-20260424/02_backbone/project-memory.md |
| write_target | NONE |
| approval_gate | NOT_REQUIRED |
| activation_level | COMPACT |
| fallback_code | NONE |

## Runtime Parity Check

| Runtime | Status |
| --- | --- |
| Claude Code | PENDING |
| Codex | PENDING |
| Antigravity | PENDING |

## Notes

- Compact mode must emit a visible activation notice (not silent degradation).
- The absence of `project-memory/index.md` and `project-memory/` directory is the trigger.
- A flat `project-memory.md` is the only valid memory artifact present.
- Parity fails if any runtime reads a different artifact or skips the activation notice.
