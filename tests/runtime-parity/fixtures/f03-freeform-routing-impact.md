# Fixture F03: Freeform Routing via Explicit ba-impact

## Scenario

Explicit `ba-impact` command across all 3 runtimes. Verifies that the same artifact
read scope and stop conditions apply regardless of runtime.

## Input State

```
plans/test-project-20260424/
├── 01_intake/intake.md
└── 02_backbone/
    ├── backbone.md
    └── project-memory.md
└── 03_modules/export/
    ├── frd.md
    └── user-stories.md
```

## Input Command

```
ba-impact --slug test-project "Thêm trường Exported By vào audit log Export CSV"
```

## Expected Behavior

- Reads backbone.md as primary artifact
- Reads frd.md and user-stories.md for affected module
- Produces impact summary listing affected sections
- Stops for approval before any downstream mutation
- Same read scope and stop conditions across all 3 runtimes

## Expected Outcome

| Field | Expected Value |
| --- | --- |
| resolved_command | ba-impact |
| activation_level | Modular |
| fallback_code | NONE |
| approval_gate | REQUIRED |
| source_of_truth_artifact | plans/test-project-20260424/02_backbone/backbone.md |
| read_scope | backbone.md, 03_modules/export/frd.md, 03_modules/export/user-stories.md |
| write_target | NONE (impact summary only, no write until approved) |

## Notes

- Stop before write is the critical gate. Any runtime that writes without approval fails parity.
- Read scope must include module artifacts when a module_slug is resolvable.
- Golden: `goldens/g03-freeform-routing-impact.md`
