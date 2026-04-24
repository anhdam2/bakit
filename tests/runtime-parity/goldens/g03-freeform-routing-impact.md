# Golden: F03 — Freeform Routing via Explicit ba-impact

## Behavior Envelope

| Field | Expected Value |
| --- | --- |
| resolved_command | ba-impact |
| resolved_slug | test-project |
| source_of_truth_artifact | plans/test-project-20260424/02_backbone/backbone.md |
| read_scope | plans/test-project-20260424/02_backbone/backbone.md, plans/test-project-20260424/03_modules/export/frd.md, plans/test-project-20260424/03_modules/export/user-stories.md |
| write_target | NONE |
| approval_gate | REQUIRED |
| activation_level | Modular |
| fallback_code | NONE |

## Runtime Parity Check

| Runtime | Status |
| --- | --- |
| Claude Code | PENDING |
| Codex | PENDING |
| Antigravity | PENDING |

## Notes

- Module slug `export` is resolved from command context, not mtime or alphabetical order.
- Read scope must include both backbone and the named module's artifacts (frd + user-stories).
- No write occurs before approval; impact summary is the sole output at this step.
- Parity fails if: (a) read scope omits module artifacts, (b) write occurs before approval,
  or (c) module slug resolves to wrong module.
- Activation level is `Modular` because a module artifact tree is present and resolvable.
