# BA-kit Contract Behavior

Use this file as the canonical LLM policy layer for BA-kit.

- `core/contract.yaml` is the canonical data layer for paths, prerequisites, defaults, state enums, thresholds, and resolution sequences.
- This file is the canonical behavior layer for routing, recovery, execution locking, delegation discipline, and model-facing stop conditions.
- If this file and `core/contract.yaml` disagree on a literal path or threshold, trust `core/contract.yaml` for the value and this file for the policy intent.

## Required Read Order

1. Read `core/contract.yaml` for exact values.
2. Read the selected BA workflow or skill stub.
3. Read only the step file(s) needed for the active command.
4. Read templates or upstream artifacts only when the active step actually needs them.

## Shared Operating Rules

- Write BA deliverables in Vietnamese by default unless the user explicitly requests English.
- Use the defaults defined under `defaults.*`.
- Treat the backbone as the primary authoring source once it exists.
- Use exact artifact matching only. Never infer from "closest looking" filenames.
- Never silently choose a slug, dated set, or module by mtime.
- Keep module-scoped authoring inside `paths.module_root` and project-scoped compiled output inside `paths.compiled_root`.
- Treat `paths.project_home` as the BA-facing dashboard for resume/status guidance. It is not a source of truth and must not override `backbone`, `intake`, or module artifacts.

## Argument Parsing

Parse arguments before doing any work.

1. Read tokens left to right.
2. Extract `--slug <slug>`, `--date <date>`, `--module <module_slug>`, and `--mode <lite|hybrid|formal>` when present.
3. The first remaining lifecycle token is the subcommand:
   - `intake`
   - `impact`
   - `backbone`
   - `frd`
   - `stories`
   - `srs`
   - `wireframes`
   - `package`
   - `status`
   - `next`
4. Friendly aliases may be translated before execution: "continue/resume" -> `next`, "đánh giá thay đổi" -> `impact`, "chuẩn bị handoff UI" -> `wireframes`, "xuất gói bàn giao" -> `package`, "kiểm tra trạng thái" -> `status`.
5. If no subcommand is present, run the full lifecycle from intake.
6. For `intake`, allow one free argument as the source path hint.
7. For `impact`, allow one free argument as the change file path hint.
8. For `frd`, `stories`, `srs`, and `wireframes`, enforce `commands.<name>.module_required`.
9. Reject unknown subcommands and unexpected free arguments instead of guessing.

## Natural-Language Routing

When the user does not explicitly name a subcommand, infer `impact` when all of these are true:

- the user refers to an existing project set or a downstream artifact already in progress
- the user says a requirement, rule, actor, acceptance criterion, screen behavior, or scope item changed, was added, or was removed
- the request is not obviously limited to wording, typo, formatting, or layout cleanup

Also infer `impact` when:

- exactly one project set can be resolved from disk, and
- the user sends a bare correction statement without explicitly asking to update, overwrite, regenerate, or rerun a named artifact

Do not mutate artifacts directly from a bare correction statement. Route to impact first.

Collaboration intent such as module claim, review handoff, conflict check, PR, commit, push, or merge routes to `ba-collab`. GitHub actions are external side effects and require explicit approval after showing files and action plan.

## Resolution Rules

Use the resolution order from `resolution.*`.

### Slug

- Prefer explicit `--slug`.
- Otherwise inspect directories matching `patterns.project_dir` under `plans/`.
- Ignore legacy report trees as resolution sources.
- If more than one slug exists, stop and ask.

### Date

- Prefer explicit `--date`.
- Otherwise derive the date from the resolved project directory name.
- If more than one dated set exists for the slug, stop and ask.

### Module

- For commands where `commands.<name>.module_required` is `true`, prefer explicit `--module`.
- If the project contains exactly one module directory, use it.
- If multiple module directories exist, stop and ask.
- Never infer a module from partial filename matches.

## Legacy Detection

- Treat anything under `legacy.roots` as out-of-contract for current lifecycle execution.
- If legacy artifacts exist but modular artifacts do not, stop and tell the user to migrate or rerun.
- Do not mix legacy and modular artifacts in one silent pass.

## Prerequisite Behavior

- Use `commands.<name>.requires` plus `paths.*` to resolve the exact prerequisite file(s).
- If any required artifact is missing, print the exact missing path, the exact prior command to run, and stop.
- For `package`, block only when wireframe state is `missing`.
- If no wireframe-state marker exists, treat it as `not-applicable` only when the SRS set has no UI-backed screens or Screen Contract Plus section. Otherwise treat it as `missing`.

## Overwrite Behavior

Before mutating `backbone`, `frd`, `stories`, `srs`, `wireframes`, or `package`:

1. Check whether the target output path already exists.
2. If it exists, print the exact path and ask whether to overwrite.
3. If the user does not explicitly approve overwrite, stop without mutating.

## Context-Loss Recovery

If exploration consumes context or the host truncates conversation history:

1. Reconstruct the active target from the resolved command, slug, date, optional module, and on-disk artifacts.
2. Continue from the next unresolved step when those values are still unambiguous.
3. Do not ask the user to restate the original request merely because exploration consumed context.

## Accepted-Scope Execution Lock

After the user explicitly approves a mutating rerun step:

- keep the current step locked for the rest of the run
- do not reopen generic discovery
- do not fall back to prompts like "what do you want me to do next?"
- only break the lock when command, slug, date, module, or overwrite approval becomes genuinely ambiguous

## Delegation Contract

Use narrow handoff packets only.

- Trackers live under `paths.delegation_root`.
- Tracker states must use `states.delegation`.
- Heartbeat cadence uses `states.heartbeat_minutes`.
- Stall detection uses `states.stall_after_minutes`.

Packet rules:

- Pass objective, exact target path, write scope, trace IDs, and the few exact upstream excerpts needed.
- Do not attach full merged artifacts when exact excerpts or IDs are enough.
- If a packet grows beyond a concise brief plus targeted excerpts, repartition before delegating.
- Require the worker to stop and return exact missing context instead of guessing.
- If a worker returns `NEEDS_REPARTITION`, rerun only the overloaded slice.

## Wireframe-State Behavior

- Use `states.wireframe` only.
- `wireframes` is read-only on upstream BA artifacts.
- It may regenerate only the runtime `DESIGN.md`, wireframe input pack, wireframe map, and wireframe state.

## Packaging Behavior

- `package` is a validation-and-compile step, not a full rebuild.
- HTML output belongs under `paths.compiled_root`.
- Keep markdown artifacts as the source of truth.

## Token Discipline

- Read the selected step file, not the whole BA lifecycle.
- Read only the exact upstream artifacts needed by the active step.
- Use `templates/manifest.json` or CLI extraction helpers instead of loading full templates when only one group is needed.
- Reuse summaries and excerpts instead of rereading large raw sources when normalized artifacts already exist.

## Large Artifact Write Protocol

When generating artifacts that exceed ~150 lines (e.g., `backbone`, `frd`, `stories`, `srs`), you MUST use **incremental writes**.
Writing entire documents in memory and flushing in one call causes `<max_tokens>` truncation and infinite retry loops.

1. **Write the skeleton first**: Create the target file with the template structure (headings, boilerplate, front matter) using a single write.
2. **Append group content sequentially**: For each logic group (e.g., one Epic, one Use Case), generate the fragment and append it into the correct section of the file. Complete one group before starting the next.
3. **Never attempt to assemble and flush the full artifact in memory**.

## Runtime-Neutral HITL Contract

BA-kit is a playbook, not a UI product. Human-in-the-loop behavior must be enforced through artifact routing and contract rules, not through screen interactions.

- The core guarantees must stay identical across Claude Code, Codex, and Antigravity even when their command syntax or tool surfaces differ.
- Runtime-local memory is never authoritative. Persist reusable project memory on disk under `paths.project_memory`.
- A runtime adapter may translate command syntax or question prompts, but it must preserve the same resolution, stop conditions, approval gates, and rerun rules.

## Granular Artifact Intervention

Treat these as the minimum intervention units whenever they exist:

- goal / metric IDs
- actor IDs
- feature IDs
- FR / NFR IDs
- story IDs and acceptance criteria
- use case IDs and step rows
- screen IDs
- rule codes and message codes
- glossary terms

When a user change can be attached to one or more stable nodes, update only the narrowest source-of-truth artifact that owns those nodes. Do not rewrite the whole project set when a narrower rerun path is sufficient.

## Active Push-back And Fail-Closed Behavior

When uncertainty is material, stop and ask instead of filling the gap with plausible prose.

Material uncertainty includes:

- ambiguous scope, actor ownership, or target module
- conflicting terminology between artifacts
- unclear acceptance behavior, validation rules, or error handling
- unclear portal ownership, navigation schema, or active-menu behavior
- a change statement that could touch multiple source-of-truth layers with different rerun paths

Fail-closed rules:

- If a required fact is missing, mark it as an assumption or open question instead of presenting it as settled.
- If a downstream artifact would require guessing an upstream decision, stop and route back to the owning step.
- If a correction invalidates a persisted assumption, record the rejected assumption in `paths.project_memory` on the next approved mutating rerun.

## Project Memory Contract

Use `paths.project_memory` as the runtime-neutral memory layer for the active project set.

- Initialize or refresh it from the latest accepted intake/backbone decisions.
- Keep it concise: only stable vocabulary, approved decisions, accepted assumptions, rejected assumptions, accepted corrections, and push-back triggers.
- Do not dump full transcript history into the memory file.
- When an impact run reveals a cross-artifact correction pattern, carry that pattern into the next approved mutating rerun so later runs can reuse it safely.
- `paths.project_memory` is recommended support context once `paths.backbone` exists, but it must not block the lifecycle when missing.

## Memory Architecture Contract

BA-kit adopts compiled support memory from LLM Wiki concepts while keeping BA-kit lifecycle, governance, and source-of-truth hierarchy intact. The boundary is:

- `backbone.md` remains the primary scope truth and mutating artifact source.
- `project-memory.md` (compact/summary form) remains the anti-drift support layer in simple projects.
- `project-memory/` shard tree is the structured memory extension for complex projects.

### Shard Tree vs Compact Mode

- **Compact mode**: only `project-memory.md` exists; used for simple/summary-only projects; backward compatible.
- **Shard mode**: `project-memory.md` + `project-memory/` tree; used when index navigation benefit justifies the structure.
- Shard tree is optional; existing projects without it remain fully operational.

### Index Role Constraint

`project-memory/index.md` is a bounded navigator:
- It routes agents to the right shards/modules.
- It must not become a second monolith or a memory dump.
- Detail lives in hot/warm/cold shards, not in the index itself.

### Log Role Constraint

`project-memory/log.md` is optional append-only chronology:
- It is never part of default command reads.
- Commands that need recent-history or audit context may read it explicitly.
- It never outranks `backbone.md` or hot shards as source of truth.

### Cold Tier Constraint

`project-memory/cold/` is never loaded by default:
- Only via explicit escalation with a stated reason.
- Superseded facts move here after archive.

### Migration Path (Summary-Only to Shard Tree)

For projects currently using only `project-memory.md`:
1. Keep `project-memory.md` as the compact summary — no changes needed to run.
2. Optionally create `project-memory/` directory with `index.md` when cross-shard navigation becomes valuable.
3. Populate hot shards from existing vocabulary/decisions sections of `project-memory.md`.
4. Roadmap plan directories under `plans/` are NOT migration targets; use dedicated BA project fixtures.

## Activation Contract

BA-kit auto-activates stricter memory and governance behavior based on project signals. Activation is deterministic and runtime-neutral.

### Activation Levels

- `Base`: single BA, single module, or simple project. Compact mode eligible.
- `Modular`: two or more modules or owners. Index-first navigation required.
- `Program`: cross-module dependencies or two or more concurrent delegation slices.

### Activation Rules

- Use the structured rule tree in `activation.thresholds` from `core/contract.yaml` for all threshold comparisons. Supported rule nodes are `any_of`, `all_of`, and leaf comparisons with `signal`, `operator`, and `value`; supported leaf operators are `gte` and `equals`.
- Thresholds are locked for v1 in `core/contract.yaml` after fixture validation; runtime parity execution is exempted by maintainer release decision.
- Compute signals from the persisted sources defined in `activation.signals`.
- When no shard/index metadata exists, use the compact-fallback value for each signal.
- Auto-escalation is allowed. Auto-downgrade is not; downgrade requires explicit refresh.
- Persist activation state inside `paths.memory_index` when shard mode is active.
- When compact mode is active, record observed activation level in `paths.project_memory` header.

### Activation Freeze Fallback

When runtime mismatch is detected between stored and computed activation level:
- Freeze activation to `Base`.
- Emit: `ACTIVATION_FREEZE: computed level {X} conflicts with stored level {Y}; frozen to Base pending explicit refresh.`
- Do not proceed with Modular or Program behavior until the user explicitly refreshes activation.

## Read Scope Contract

Every command has deterministic read scope. Commands must navigate: summary → index → targeted shards.

### Read Scope Per Command

| Command | Must Read | May Read | Must NOT Read |
| --- | --- | --- | --- |
| intake | contract.yaml, contract-behavior.md | paths.project_memory (compact only) | memory shards, log.md, cold/ |
| backbone | contract.yaml, contract-behavior.md, paths.intake | paths.project_memory, paths.memory_index (nav only), paths.memory_hot_vocabulary, paths.memory_hot_decisions | log.md, cold/, warm/ |
| impact | contract.yaml, contract-behavior.md, paths.intake, paths.backbone | paths.project_memory, paths.memory_index, paths.memory_hot_*, selected warm/ module shard, relevant downstream artifacts; log.md only for explicit audit | cold/ (unless escalated) |
| frd | contract.yaml, contract-behavior.md, paths.backbone, paths.plan | paths.project_memory or hot vocabulary+decisions shards | log.md, cold/, warm/, unrelated module shards |
| stories | contract.yaml, contract-behavior.md, paths.backbone | paths.plan, paths.frd (if exists), paths.project_memory or hot shards | log.md, cold/, warm/, unrelated module shards |
| srs | contract.yaml, contract-behavior.md, paths.backbone, paths.stories | paths.project_memory or hot shards, module warm shard, paths.frd (if exists) | log.md, cold/, other module shards |
| wireframes | contract.yaml, contract-behavior.md, paths.wireframe_input | paths.project_memory or paths.memory_hot_decisions, paths.design_doc, module warm shard | log.md, cold/, other module shards |
| package | contract.yaml, contract-behavior.md | paths.project_memory (compact, consistency check), paths.memory_index (health overview) | log.md, cold/, warm/ shards |
| status | contract.yaml, contract-behavior.md | paths.project_home, paths.project_memory header, paths.memory_index (activation + freshness) | log.md (unless --audit), warm/ shards, cold/ |

### Index-First Navigation Rule

When shard memory exists:
1. Read `paths.memory_index` first to determine which shards are relevant.
2. Load only the shards the index routes to.
3. Never load the full shard tree when a targeted read is possible.

### `impact` Broad-Read Exception

`impact` is the only command that may read across warm/ module shards by default when Modular or Program activation is detected.

### Log Exclusion Rule

`log.md` is excluded from all default command reads. Only `impact` may read it and only when the user explicitly requests audit or recent-history context.

### Escalation Rule

A command may escalate its read scope only when:
- The index explicitly routes to an additional shard.
- The user states an explicit audit or context need.
- Missing shard routing would otherwise require guessing.

Emit: `READ_ESCALATION: {command} read {path} due to {reason}.`

## Multi-BA Governance Contract

### Memory Ownership Matrix

| Memory Layer | Primary Owner | Who May Write |
| --- | --- | --- |
| `project-memory.md` (compact) | Lead BA | Lead BA |
| `project-memory/index.md` | Lead BA | Lead BA |
| `project-memory/hot/*.md` | Lead BA | Lead BA |
| `project-memory/warm/modules/{module_slug}.md` | Module BA | Module BA; cross-module entries require Lead BA approval |

### Conflict Escalation Rules

- When a module BA attempts to write a global hot shard: `GOVERNANCE_CONFLICT: {actor} does not own {path}; escalate to Lead BA.`
- Two module BAs claiming the same shard: escalate before proceeding.
- A warm shard change that creates a cross-module dependency: route to Lead BA for approval before writing.
- Ambiguous ownership escalates rather than guesses.

### Promotion Rules

Canonical memory changes only after an approved rerun:
1. Detect a change that affects accepted terminology, decisions, or push-back triggers.
2. Run `impact` to trace scope.
3. Get explicit user approval of the impact and proposed rerun path.
4. Execute the approved mutating rerun.
5. Promote the change to canonical memory using `templates/project-memory-fileback-record-template.md`.
6. Append a traceable entry to `log.md` when shard mode is active.

### File-Back Approval Authority

- **Lead BA approves:** global or cross-module file-back, hot shard updates, index changes.
- **Module owner approves:** module-local warm shard file-back.
- **End-user approval required when:** filed-back content changes accepted business scope or policy.
- **Ambiguity rule:** ambiguous classification forces explicit end-user approval before file-back.
- Command-level approval alone is not sufficient for file-back.

### Trace Schema

Every filed-back memory item must carry: `source_artifact`, `source_ids`, `promotion_target`, `approved_by`, `approved_role`, `approved_at`, `approval_basis`, `approval_trigger`, `impact_ref`, `supersedes`, `superseded_by` (optional).

### Archive Policy

- Active facts stay in `hot/` and `warm/`.
- Superseded facts move to `cold/` with a `superseded_by` trace.
- `log.md` carries chronology; it does not hold canonical facts.
- Cold tier is not loaded by default.

### Pre-Mutate Governance Validation

Before mutating `backbone`, `frd`, `stories`, `srs`, or `wireframes`:
1. Verify write authority for the target artifact and its owning memory shard.
2. Confirm an impact run is completed and approved (skip only for `wording-only`).
3. If either check fails: emit `GOVERNANCE_BLOCK: {reason}` and stop.
4. After approved mutation: offer to file the change into canonical memory using the trace schema.

### Packet-Only Delegation Rule

Sub-agents must receive a memory packet containing objective, write scope, trace IDs, and exact upstream excerpts — not the full memory tree. Return `NEEDS_REPARTITION` with exact missing inputs when the packet is insufficient.
