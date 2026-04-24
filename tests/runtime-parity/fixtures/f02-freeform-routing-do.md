# Fixture F02: Freeform Routing via ba-do

## Scenario

Same freeform correction request routed via `ba-do` across all 3 runtimes. Verifies
that freeform text triggering a requirement change is consistently routed to `ba-impact`.

## Input State

```
plans/test-project-20260424/
├── 01_intake/intake.md
└── 02_backbone/
    ├── backbone.md
    └── project-memory.md
```

## Input Command

Freeform text (no explicit command prefix):

```
Thêm yêu cầu audit log cho Export CSV
```

## Expected Behavior

- Runtime detects freeform text as a requirement mutation request
- Routes to `ba-impact` (not `ba-do` directly)
- `ba-impact` reads backbone.md to assess affected artifacts
- Presents impact summary before any write
- Same routing decision across all 3 runtimes

## Expected Outcome

| Field | Expected Value |
| --- | --- |
| resolved_command | ba-impact |
| activation_level | Base |
| fallback_code | NONE |
| approval_gate | REQUIRED |
| source_of_truth_artifact | plans/test-project-20260424/02_backbone/backbone.md |

## Notes

- The freeform text must not bypass the impact gate.
- Routing to `ba-do` directly without impact check is a parity failure.
- Golden: `goldens/g02-freeform-routing-do.md`
