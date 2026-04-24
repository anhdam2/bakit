# Golden: F04 — Explicit ba-start backbone Command

## Behavior Envelope

| Field | Expected Value |
| --- | --- |
| resolved_command | ba-start backbone |
| resolved_slug | test-project |
| source_of_truth_artifact | plans/test-project-20260424/01_intake/intake.md |
| read_scope | plans/test-project-20260424/01_intake/intake.md |
| write_target | plans/test-project-20260424/02_backbone/backbone.md |
| approval_gate | NOT_REQUIRED |
| activation_level | Base |
| fallback_code | NONE |

## Overwrite Variant (backbone.md already exists)

| Field | Expected Value |
| --- | --- |
| resolved_command | ba-start backbone |
| approval_gate | REQUIRED |
| write_target | plans/test-project-20260424/02_backbone/backbone.md |
| fallback_code | NONE |

## Runtime Parity Check

| Runtime | Status |
| --- | --- |
| Claude Code | PENDING |
| Codex | PENDING |
| Antigravity | PENDING |

## Notes

- Primary case: `backbone.md` does not exist → no overwrite gate, write proceeds directly.
- Overwrite variant: `backbone.md` exists → approval gate activates, no write until approved.
- Read scope is strictly `intake.md`; runtimes must not pull in backbone.md or other artifacts
  when backbone.md does not yet exist.
- Parity fails if any runtime silently overwrites an existing backbone.md without approval.
