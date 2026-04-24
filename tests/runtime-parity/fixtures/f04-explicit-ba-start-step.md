# Fixture F04: Explicit ba-start backbone Command

## Scenario

Explicit `ba-start backbone` command across all 3 runtimes. Verifies same read scope,
write target, and overwrite gate behavior.

## Input State

```
plans/test-project-20260424/
└── 01_intake/
    └── intake.md
```

No `02_backbone/backbone.md` yet (first-time backbone generation).

## Input Command

```
ba-start backbone --slug test-project
```

## Expected Behavior

- Reads `01_intake/intake.md` as sole source input
- Resolves write target to `02_backbone/backbone.md`
- Since backbone.md does not exist: no overwrite gate prompt, proceed directly
- Generates backbone structure from intake
- Same read scope and write target across all 3 runtimes

## Expected Outcome

| Field | Expected Value |
| --- | --- |
| resolved_command | ba-start backbone |
| activation_level | Base |
| fallback_code | NONE |
| approval_gate | NOT_REQUIRED |
| source_of_truth_artifact | plans/test-project-20260424/01_intake/intake.md |
| read_scope | 01_intake/intake.md |
| write_target | 02_backbone/backbone.md |

## Variant: backbone.md Already Exists

If `02_backbone/backbone.md` exists:
- Overwrite gate activates: approval_gate = REQUIRED
- No write until user approves
- Same gate behavior across all 3 runtimes

## Notes

- The overwrite gate variant is critical for parity. A runtime that silently overwrites fails.
- Golden: `goldens/g04-explicit-ba-start-step.md`
