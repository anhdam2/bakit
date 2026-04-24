# Fixture F05: Compact Fallback on Missing index.md

## Scenario

Corrupted or missing `project-memory/index.md` causing compact fallback. Verifies the
runtime degrades gracefully: no crash, no silent wrong behavior.

## Input State

```
plans/test-project-20260424/
└── 02_backbone/
    └── project-memory/       # directory exists, but index.md is absent
        ├── shard-01.md
        └── shard-02.md
```

`project-memory/index.md` is missing. No flat `project-memory.md` either.

## Input Command

```
ba-start status --slug test-project
```

## Expected Behavior

- Runtime detects `project-memory/` directory but no `index.md`
- Activates compact fallback (COMPACT_FALLBACK code)
- Emits a visible warning: index.md not found, falling back to compact mode
- Does NOT silently use shards without index; does NOT crash
- Status output reflects degraded-but-functional state
- Same fallback and warning behavior across all 3 runtimes

## Expected Outcome

| Field | Expected Value |
| --- | --- |
| resolved_command | ba-start status |
| activation_level | COMPACT |
| fallback_code | COMPACT_FALLBACK |
| approval_gate | NOT_REQUIRED |
| source_of_truth_artifact | NONE (no valid memory artifact found) |
| write_target | NONE |

## Notes

- Silent wrong behavior (e.g., reading shards without index in undefined order) is a parity
  failure even if no error is raised.
- Runtimes must surface the warning visibly, not log-only.
- Golden: `goldens/g05-compact-fallback-missing-index.md`
