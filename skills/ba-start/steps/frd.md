# BA Start Step - FRD

This step requires:

- `core/contract.yaml`
- `core/contract-behavior.md`

## Memory Read Scope

- **Must read:** `core/contract.yaml`, `core/contract-behavior.md`, `paths.backbone`, `paths.plan` (when exists)
- **May read:** `paths.project_memory` or (`paths.memory_hot_vocabulary` + `paths.memory_hot_decisions`) when shard mode is active
- **Must NOT read:** `log.md`, `cold/`, `warm/` shards, unrelated module shards

## Governance Gate

Before mutating this artifact:
1. **Skip this gate for first-pass creation** (when `paths.frd` does not yet exist).
2. For reruns (artifact already exists): verify write authority and confirm an approved impact run (skip only for `wording-only` changes).
3. If either check fails on a rerun: emit `GOVERNANCE_BLOCK: {reason}` and stop.
4. After mutation completes: offer to file the change into canonical memory using `templates/project-memory-fileback-record-template.md`.

## Scope

Run Step 6 only.

## Prerequisites

- Resolve slug, date, and module using the shared contract.
- Require `paths.backbone`.
- If backbone is missing, print the exact missing path and stop.
- Trust accepted user intent. Do not reopen scope discovery after FRD execution is accepted.
- Run a narrow FRD preflight:
  - read only `paths.backbone` and `paths.plan` when it exists
  - do not scan unrelated module folders once slug, date, and module are resolved

## Output

- `paths.frd`

## Step 6 - Produce FRD

Produce the FRD from the backbone using [../../../templates/frd-template.md](../../../templates/frd-template.md):

- Functional overview
- User personas
- Feature list with MoSCoW priorities
- Workflows (Mermaid)
- Data requirements
- Business rules
- Integration points
- Acceptance criteria

Execution rules:

- Start from the exact backbone artifact only, plus the exact plan path when it exists.
- In `hybrid` mode, keep the FRD concise and focused on features, workflows, business rules, and integration-relevant context.
- In `lite` mode, emit the FRD only when the user explicitly asks for it.

Save to `paths.frd`.
