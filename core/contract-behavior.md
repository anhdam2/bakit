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
4. If no subcommand is present, run the full lifecycle from intake.
5. For `intake`, allow one free argument as the source path hint.
6. For `impact`, allow one free argument as the change file path hint.
7. For `frd`, `stories`, `srs`, and `wireframes`, enforce `commands.<name>.module_required`.
8. Reject unknown subcommands and unexpected free arguments instead of guessing.

## Natural-Language Routing

When the user does not explicitly name a subcommand, infer `impact` when all of these are true:

- the user refers to an existing project set or a downstream artifact already in progress
- the user says a requirement, rule, actor, acceptance criterion, screen behavior, or scope item changed, was added, or was removed
- the request is not obviously limited to wording, typo, formatting, or layout cleanup

Also infer `impact` when:

- exactly one project set can be resolved from disk, and
- the user sends a bare correction statement without explicitly asking to update, overwrite, regenerate, or rerun a named artifact

Do not mutate artifacts directly from a bare correction statement. Route to impact first.

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
