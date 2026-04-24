# Golden: F05 — Compact Fallback on Missing index.md

## Behavior Envelope

| Field | Expected Value |
| --- | --- |
| resolved_command | ba-start status |
| resolved_slug | test-project |
| source_of_truth_artifact | NONE |
| read_scope | NONE |
| write_target | NONE |
| approval_gate | NOT_REQUIRED |
| activation_level | COMPACT |
| fallback_code | COMPACT_FALLBACK |

## Runtime Parity Check

| Runtime | Status |
| --- | --- |
| Claude Code | PENDING |
| Codex | PENDING |
| Antigravity | PENDING |

## Notes

- `project-memory/` directory exists but `index.md` is absent — this is the trigger condition.
- No flat `project-memory.md` exists as fallback either.
- `source_of_truth_artifact: NONE` — no valid memory artifact is available.
- Runtimes MUST emit a visible warning surfaced to the user, not a log-only or silent event.
- Runtimes MUST NOT read shards in undefined order as a silent substitute for the missing index.
- Status output must clearly indicate degraded state; functional but context-limited.
- Parity fails if: (a) runtime crashes, (b) silent wrong behavior (unindexed shard reads),
  or (c) no visible warning is emitted.
