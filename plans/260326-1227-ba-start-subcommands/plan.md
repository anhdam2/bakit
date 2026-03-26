# Add Step-Level CLI Subcommands to /ba-start

**Date:** 2026-03-26
**Status:** Implemented — validation complete

---

## Problem

`/ba-start` currently runs the full 12-step workflow as a monolith. Users can't:
- Resume from a specific step after context resets or interruptions
- Run only FRD without SRS
- Re-generate wireframes without restarting from intake
- Skip already-completed steps on a re-run

## Solution

Add subcommands to `/ba-start` that route to individual workflow steps or step groups. Pattern follows ClaudeKit convention (`argument-hint` in frontmatter, argument parsing in skill body).

**Implementation scope:** update both the source playbook at `skills/ba-start/SKILL.md` and the installable Codex copy at `codex/skills/ba-start/SKILL.md` so local repo usage and installed Codex usage stay aligned.

## Design Decisions

### Subcommand Granularity

Not every step needs a standalone command. Steps 1-4 are tightly coupled (intake→gaps→questions→plan) and should stay grouped. Steps 6-7 are sequential but independently useful. Steps 8-11 form the SRS pipeline.

### Proposed Commands

```
/ba-start                        # Full workflow (current behavior, unchanged)
/ba-start intake <file|text>     # Steps 1-4: parse → normalize → gap → clarify → plan
/ba-start frd                    # Step 6: produce FRD from intake
/ba-start stories                # Step 7: produce user stories from FRD
/ba-start srs                    # Steps 8-11: UC → screen contract → wireframes → screen desc → assembly
/ba-start wireframes             # Step 9 only: generate wireframes from existing screen contract
/ba-start package                # Step 12: quality review + HTML packaging
/ba-start status                 # Show which steps have completed artifacts in plans/reports/
```

### Why Not One Command Per Step?

- Steps 1-4 (intake pipeline) are conversational — splitting them creates awkward UX where user answers questions in one command, gets plan in another
- Steps 8-11 (SRS pipeline) have strict sequential dependencies — running step 10 without 8-9 is always an error
- `wireframes` is the exception: it's a heavy, isolatable step that users commonly want to re-run independently after editing the screen contract

### State Detection

Each subcommand checks for prerequisite artifacts before running:

| Command | Requires | Produces |
|---|---|---|
| `intake` | Raw input (file/text) | `intake-{slug}-{date}.md`, `plan.md` |
| `frd` | intake exists | `frd-{date}-{slug}.md`, `frd-{date}-{slug}.html` |
| `stories` | FRD exists | `user-stories-{date}-{slug}.md` |
| `srs` | Stories + FRD exist | `srs-{date}-{slug}.md` (merged) |
| `wireframes` | Screen Contract Lite exists in `srs-{date}-{slug}-group-c.md` or merged `srs-{date}-{slug}.md` | `.pen` files + `.png` exports |
| `package` | SRS exists; wireframes may be present, skipped, or not applicable | `srs-{date}-{slug}.html`, delivery summary |
| `status` | — | Console output |

Prerequisite check: inspect expected artifacts by exact filename pattern, not broad `*-{slug}*` matches. If a required artifact is missing, print what is needed and which subcommand to run first.

### Wireframe State Model

Wireframes are not always mandatory at package time. Status logic should treat them as one of:
- `completed` — `.pen` artifacts and any expected exports exist
- `skipped` — user explicitly skipped wireframes in the Step 9 decision and that decision is persisted in an explicit marker
- `not-applicable` — scope has no UI-backed screens
- `missing` — wireframes are required by the SRS flow but artifacts are absent

`package` must only block on wireframes when state is `missing`.

Persist wireframe state explicitly after Step 9 so `status` and `package` do not have to guess from missing files alone.

### Slug Resolution

Subcommands need to know which project they're operating on. Resolution order:
1. Explicit `--slug <slug>` flag
2. If exactly one candidate project exists in `plans/reports/`, use that slug
3. If multiple candidate projects exist, require the user to choose or pass `--slug`

For mutating subcommands (`frd`, `stories`, `srs`, `wireframes`, `package`), never silently choose by mtime when multiple projects exist.

If a single slug has multiple dated artifact sets, require the user to choose the target dated set rather than silently taking the latest one.

---

## Phases

### Phase 1 — Update SKILL.md Frontmatter and Argument Routing

**Files:** `skills/ba-start/SKILL.md`, `codex/skills/ba-start/SKILL.md`

| Task | Detail |
|---|---|
| 1.1 | Add `argument-hint: "[intake\|frd\|stories\|srs\|wireframes\|package\|status] [file\|--slug]"` to frontmatter |
| 1.2 | Add argument parsing section at top of workflow: detect subcommand from `ARGUMENTS`, route to the matching step block, preserve no-argument full workflow behavior |
| 1.3 | Add `--slug <slug>` flag parsing for project targeting |
| 1.4 | Mirror source SKILL.md verbatim to `codex/skills/ba-start/SKILL.md` after all edits complete |

### Phase 2 — Add Prerequisite Check Logic

**Files:** `skills/ba-start/SKILL.md`, `codex/skills/ba-start/SKILL.md`

| Task | Detail |
|---|---|
| 2.1 | Add prerequisite artifact table (as above) to SKILL.md as a reference section |
| 2.2 | For each subcommand section, add a "Prerequisites" block: inspect exact required artifacts, if missing → print which step to run first and stop |
| 2.3 | Add slug resolution logic: explicit flag > single detected project > ask user when ambiguous |
| 2.4 | Add wireframe state handling so `package` and `status` distinguish `completed`, `skipped`, `not-applicable`, and `missing` |
| 2.5 | Define standalone `wireframes` source resolution: prefer `srs-{date}-{slug}-group-c.md`; fallback to merged `srs-{date}-{slug}.md` if Screen Contract Lite is already assembled there |
| 2.6 | Add overwrite detection: when target artifact already exists, prompt user before proceeding. Applies to `frd`, `stories`, `srs`, `wireframes`, `package` |
| 2.7 | Persist explicit wireframe-state marker after Step 9 so later subcommands can distinguish `skipped` from `missing` |
| 2.8 | When one slug has multiple dated artifact sets, prompt the user to choose the target set before mutating or reporting status |

### Phase 3 — Extract Step Sections into Routable Blocks

**Files:** `skills/ba-start/SKILL.md`, `codex/skills/ba-start/SKILL.md`

| Task | Detail |
|---|---|
| 3.1 | Wrap Steps 1-5 under `## Subcommand: intake` heading |
| 3.1a | For `/ba-start intake`, prompt for file or pasted text when no input argument is provided; accept a direct file path when supplied |
| 3.2 | Wrap Step 6 under `## Subcommand: frd` |
| 3.3 | Wrap Step 7 under `## Subcommand: stories` |
| 3.4 | Wrap Steps 8-11 under `## Subcommand: srs`, with Step 9 also accessible via `## Subcommand: wireframes` |
| 3.5 | Wrap Step 12 under `## Subcommand: package` |
| 3.6 | Add `## Subcommand: status` — inspect `plans/reports/` and `designs/`, print checklist with artifact name, exists/missing status, last-modified date, and explicit wireframe state |
| 3.7 | Ensure `wireframes` rerun path is read-only on upstream artifacts: it should regenerate design outputs from existing screen-contract artifacts without redoing intake, FRD, or stories |

### Phase 4 — Update Documentation

**Files:** `README.md`, `CLAUDE.md`, `docs/skill-catalog.md`, `docs/getting-started.md`, `docs/codex-setup.md`

| Task | Detail |
|---|---|
| 4.1 | Update invocation examples to show full `/ba-start` and subcommand usage patterns |
| 4.2 | Update references to `/ba-start` as a single entry point so they clarify: one skill, multiple subcommands |
| 4.3 | Document `--slug` requirements and ambiguous-project behavior for rerun commands |
| 4.4 | Document `status` output semantics, especially skipped/not-applicable wireframe states |

### Phase 5 — Validate

| Task | Detail |
|---|---|
| 5.1 | Read both final skill copies, verify every subcommand routes to correct steps and both copies stay aligned |
| 5.2 | Verify prerequisite table is consistent with what each subcommand section checks |
| 5.3 | Verify full `/ba-start` (no args) still runs the complete workflow unchanged |
| 5.4 | Verify `wireframes` works from both group-C and merged-SRS source assumptions |
| 5.5 | Verify `package` and `status` correctly handle `completed`, `skipped`, `not-applicable`, and `missing` wireframe states |
| 5.6 | Verify ambiguous multi-project cases require explicit `--slug` rather than silently selecting by mtime |

---

## Dependency Graph

```
Phase 1 (frontmatter + routing)
    │
Phase 2 (prerequisite checks) ─── depends on Phase 1
    │
Phase 3 (step extraction) ─── depends on Phase 1
    │
Phase 4 (docs) ─── depends on Phase 3
    │
Phase 5 (validation) ─── depends on all
```

Phase 2 and 3 can run in parallel after Phase 1.

---

## Out of Scope

- Splitting SKILL.md into multiple files (keep single-file skill per ClaudeKit convention)
- Adding persistent state/database for step completion tracking (artifact presence is sufficient)
- Creating separate skills per step (violates "single entry point" design)
- Changing agent delegation or workflow logic — only adding routing around existing steps

## Resolved Questions

1. **`srs` includes wireframes by default.** `/ba-start wireframes` exists for re-runs only.
2. **`status` shows a checklist with dates** — artifact name, exists/missing, last-modified date.

## Validation Notes

- `docs/development-rules.md` is referenced by the planning skill but does not exist in this repo. Implementation and validation should follow `AGENTS.md`, `rules/ba-workflow.md`, and `rules/ba-quality-standards.md` instead.

---

## Validation Log

### Session 1 — 2026-03-26
**Trigger:** `/plan validate` before implementation
**Questions asked:** 7

#### Questions & Answers

1. **[Scope]** The `intake` subcommand covers Steps 1-5, which includes Step 5 (work plan generation with deliverable selection). When the user later runs `/ba-start frd`, should it re-check the work plan to confirm FRD was selected, or trust the user knows what they want?
   - Options: Trust the user | Check work plan first | Skip Step 5 from intake
   - **Answer:** Trust the user
   - **Rationale:** Subcommands are explicit user intent. Adding a work-plan gate creates unnecessary friction. If user says `frd`, produce FRD.

2. **[SRS + wireframes]** Should `/ba-start srs` include wireframe generation (Step 9) by default?
   - Options: srs includes wireframes | srs skips wireframes
   - **Answer:** srs includes wireframes
   - **Rationale:** Normal workflow always needs wireframes as part of SRS pipeline. `/ba-start wireframes` exists as a standalone re-run tool only.

3. **[Status output]** What should `/ba-start status` display?
   - Options: Checklist with dates | Detailed table | Minimal checklist only
   - **Answer:** Checklist with dates
   - **Rationale:** Balance of information vs scannability. Artifact name + exists/missing + last-modified date.

4. **[File size risk]** Adding routing, prerequisite checks, and subcommand headings will grow SKILL.md significantly. How should this be managed?
   - Options: Inline everything | Use reference files | Separate sub-skill files
   - **Answer:** Inline everything
   - **Rationale:** ClaudeKit convention is single-file skills. 600-700 lines is manageable for LLM context. No reference files needed.

5. **[Edge case]** When a user runs `/ba-start frd` but a FRD artifact already exists for that slug, what should happen?
   - Options: Prompt before overwriting | Overwrite silently | Version artifacts
   - **Answer:** Prompt before overwriting
   - **Rationale:** Prevents accidental data loss. Show existing artifact path, ask overwrite or skip.

6. **[Codex copy]** How should the source and Codex copies stay aligned?
   - Options: Mirror copy | Codex gets subset
   - **Answer:** Mirror copy
   - **Rationale:** Source `skills/ba-start/SKILL.md` is the single source of truth. After editing, copy verbatim to `codex/skills/ba-start/SKILL.md`.

7. **[Error UX]** When a prerequisite artifact is missing, how should the error behave?
   - Options: Print + stop | Offer to chain
   - **Answer:** Print + stop
   - **Rationale:** Print what's missing, show exact command to run, and stop. Clear, explicit, no hidden chaining complexity.

#### Confirmed Decisions
- Trust user intent: no work-plan re-validation on subcommands
- `srs` = full pipeline including wireframes; `wireframes` = re-run only
- `status` = checklist with dates format
- Single-file inline approach, no reference files
- Prompt before overwriting existing artifacts
- Mirror copy between source and Codex
- Print-and-stop on missing prerequisites

#### Action Items
- [x] Resolve Q1: `srs` includes wireframes — confirmed
- [x] Resolve Q2: `status` format — checklist with dates
- [x] Add "overwrite prompt" logic to Phase 2 (prerequisite checks) for all mutating subcommands
- [x] Ensure Phase 1 task 1.4 specifies verbatim copy, not behavioral alignment

#### Impact on Phases
- Phase 2: Add overwrite detection — when target artifact already exists, prompt user before proceeding. Applies to `frd`, `stories`, `srs`, `wireframes`, `package`.
- Phase 1 (task 1.4): Clarify "keep aligned" means verbatim mirror copy after source edits complete.
- Phase 3 (task 3.6): `status` output format is checklist with last-modified dates, not raw file listing.

---

## Implementation Log

### Session 3 — 2026-03-26
**Outcome:** Completed

- Updated `skills/ba-start/SKILL.md` with subcommand routing, `argument-hint`, slug and dated-set resolution, overwrite prompts, prerequisite checks, explicit wireframe-state handling, and a `status` checklist flow.
- Mirrored the final source playbook verbatim to `codex/skills/ba-start/SKILL.md`.
- Updated `README.md`, `CLAUDE.md`, `docs/skill-catalog.md`, `docs/getting-started.md`, and `docs/codex-setup.md` to document subcommands, `--slug`, ambiguous-project behavior, and wireframe-state semantics.
- Validated that the two skill copies match exactly and that the new sections are present in both the playbook and docs.

### Session 2 — 2026-03-26
**Trigger:** Follow-up validation on remaining ambiguity before implementation
**Questions asked:** 3

#### Questions & Answers

1. **[Architecture]** How should `status` distinguish wireframes `skipped` vs `missing` when both may have no `.pen` artifacts?
   - Options: Persist an explicit marker after Step 9 in a report/plan artifact | Infer only from SRS content | Collapse both into one `no-wireframes` state
   - **Answer:** Persist an explicit marker after Step 9 in a report/plan artifact
   - **Rationale:** `status` and `package` need deterministic state, not inference from absent files.

2. **[Scope]** How should `/ba-start intake` handle raw text now that it has a subcommand form?
   - Options: `/ba-start intake` prompts for file or pasted text unless a file path is provided | Require an inline argument every time | Support file paths only
   - **Answer:** `/ba-start intake` prompts for file or pasted text unless a file path is provided
   - **Rationale:** Preserves current UX while still supporting explicit subcommand routing.

3. **[Risk]** If multiple dated artifact sets exist for the same slug, how should rerun commands and `status` pick the target set?
   - Options: Ask the user to choose the dated set when ambiguous | Auto-pick the latest dated set | Require an explicit date flag in addition to `--slug`
   - **Answer:** Ask the user to choose the dated set when ambiguous
   - **Rationale:** Avoids silently mutating or reporting on the wrong artifact generation.

#### Confirmed Decisions
- Wireframe state is explicit, not inferred
- `/ba-start intake` keeps prompt-first behavior when no path is supplied
- Ambiguous dated artifact sets require user choice

#### Action Items
- [x] Add explicit wireframe-state marker requirement to prerequisite/state logic
- [x] Add `/ba-start intake` prompt behavior to routed step extraction
- [x] Add dated-set ambiguity handling to slug/artifact resolution

#### Impact on Phases
- Phase 2: Persist a wireframe-state marker and use it in `status`/`package`.
- Phase 2: Prompt user to choose among multiple dated sets for one slug.
- Phase 3: Preserve prompt-first intake behavior when no direct file path is provided.
