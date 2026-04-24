# BA Start Step - SRS Router

This step requires:

- `core/contract.yaml`
- `core/contract-behavior.md`

## Memory Read Scope

- **Must read:** `core/contract.yaml`, `core/contract-behavior.md`, `paths.backbone`, `paths.stories`
- **May read:** `paths.project_memory` or (`paths.memory_hot_vocabulary` + `paths.memory_hot_decisions`) when shard mode active; module `warm/` shard; `paths.frd` when exists
- **Must NOT read:** `log.md`, `cold/`, other module shards

## Governance Gate

Before mutating this artifact:
1. **Skip this gate for first-pass creation** (when `paths.srs` does not yet exist).
2. For reruns (artifact already exists): verify write authority and confirm an approved impact run (skip only for `wording-only` changes).
3. If either check fails on a rerun: emit `GOVERNANCE_BLOCK: {reason}` and stop.
4. After mutation completes: offer to file the change into canonical memory using `templates/project-memory-fileback-record-template.md`.

## Scope

Run Steps 8-11 only. This path is intentionally split to avoid loading the full SRS contract at once.

## Read Order

1. Read this file for SRS preflight and orchestration.
2. Read [srs-core.md](./srs-core.md) for Step 8 and Step 8.1.
3. Read [srs-wireframes.md](./srs-wireframes.md) for Step 8.2, Step 9, and Step 10.
4. Read [srs-assembly.md](./srs-assembly.md) for Step 10.1 and Step 11.

## Prerequisites

- Resolve slug, date, and module using the shared contract.
- Require:
  - `paths.backbone`
  - `paths.stories`
- If a required artifact is missing, print the exact missing path, tell the user which subcommand to run first, and stop.
- Run an SRS preflight before reading content:
  - read only the resolved backbone, user stories, optional FRD from the module, and `paths.plan` when it exists
  - do not scan other module folders once slug, date, and module are resolved

## Outputs

- `paths.srs_group` for groups `a` through `f`
- `paths.srs`
- `paths.wireframe_input`
- any wireframe artifacts and state produced during Step 9

## Execution Order

```text
Step 8   -> srs-core.md
Step 8.2 -> srs-wireframes.md
Step 9   -> srs-wireframes.md
Step 10  -> srs-wireframes.md
Step 10.1 + 11 -> srs-assembly.md
```
