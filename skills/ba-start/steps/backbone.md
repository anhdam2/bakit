# BA Start Step - Backbone

This step requires:

- `core/contract.yaml`
- `core/contract-behavior.md`

## Memory Read Scope

- **Must read:** `core/contract.yaml`, `core/contract-behavior.md`, `paths.intake`
- **May read:** `paths.project_memory`, `paths.memory_index` (navigation only), `paths.memory_hot_vocabulary`, `paths.memory_hot_decisions`
- **Must NOT read:** `log.md`, `cold/`, `warm/` shards

## Governance Gate

Before mutating this artifact:
1. **Skip this gate for first-pass creation** (when `paths.backbone` does not yet exist).
2. For reruns (artifact already exists): verify write authority and confirm an approved impact run (skip only for `wording-only` changes).
3. If either check fails on a rerun: emit `GOVERNANCE_BLOCK: {reason}` and stop.
4. After mutation completes: offer to file the change into canonical memory using `templates/project-memory-fileback-record-template.md`.

## Scope

Run Step 5 only.

## Prerequisites

- Resolve slug and date using the shared contract.
- Require `paths.intake`.
- If intake is missing, print the exact missing path and stop.
- Run a narrow backbone preflight:
  - read only `paths.intake` and `paths.plan` when it exists
  - do not scan other folders once slug and date are resolved

## Output

- `paths.project_home`
- `paths.backbone`
- `paths.project_memory`

## Step 5 - Build the requirements backbone

Create the persisted source-of-truth artifact using [../../../templates/requirements-backbone-template.md](../../../templates/requirements-backbone-template.md).

The backbone must contain:

- scope lock summary
- selected engagement mode (`lite`, `hybrid`, or `formal`)
- business goals and success metrics
- actors and feature map
- system-level portal matrix for UI-backed scope
- FR/NFR draft inventory
- preliminary story map
- UI/screen coverage assessment
- artifact emission gates
- assumptions, risks, and open questions

After writing the backbone, initialize or refresh `paths.project_memory` using [../../../templates/project-memory-template.md](../../../templates/project-memory-template.md).

Also refresh `paths.project_home` using [../../../templates/project-home-template.md](../../../templates/project-home-template.md) so non-technical BAs can resume without understanding slug/date/module internals.

Project Home refresh must summarize scope lock, artifact gates, next safe step, and runtime quick prompts. It is a dashboard only; do not duplicate full requirements or replace `backbone.md`.

The project memory must persist only the reusable anti-hallucination layer:

- canonical vocabulary and naming
- approved scope, actor, navigation, and rule decisions
- accepted assumptions with triggers for re-validation
- rejected assumptions or false trails that must not reappear
- accepted corrections and push-back triggers

Backbone rules:

- treat the backbone as the primary authoring source after intake
- do not draft FRD, stories, or SRS directly from raw intake once the backbone exists
- when UI-backed scope exists, lock portal ownership and route-group ownership here before any module-level screen work starts
- keep the artifact concise and decision-oriented
- keep `project-memory.md` runtime-neutral so Claude Code, Codex, and Antigravity can all resume from the same accepted facts
