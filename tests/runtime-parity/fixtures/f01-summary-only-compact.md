# Fixture F01: Summary-Only Compact Mode

## Scenario

Project with only `project-memory.md` (no shard tree). Verifies compact mode activates
automatically and routing remains correct across runtimes.

## Input State

```
plans/test-project-20260424/
└── 02_backbone/
    └── project-memory.md   # single-file summary, no index.md, no shards/
```

## Input Command

```
ba-start status --slug test-project
```

## Expected Behavior

- Compact mode activates (no shard tree detected)
- `project-memory.md` read as the sole context source
- Status output reflects compact activation notice
- No errors, no crashes
- Same routing decision across all 3 runtimes

## Expected Outcome

| Field | Expected Value |
| --- | --- |
| resolved_command | ba-start status |
| activation_level | COMPACT |
| fallback_code | NONE |
| approval_gate | NOT_REQUIRED |
| source_of_truth_artifact | plans/test-project-20260424/02_backbone/project-memory.md |

## Notes

- This fixture tests the most minimal valid project state.
- Compact mode must not downgrade silently; the activation notice is observable output.
- Golden: `goldens/g01-summary-only-compact.md`
