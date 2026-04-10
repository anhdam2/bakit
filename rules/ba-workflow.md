# BA Workflow

Consolidated workflow rules for BA-kit covering lifecycle, delegation, documentation, and methodology.

Related rules:
- [BA Quality Standards](./ba-quality-standards.md)

## Lifecycle

BA-kit is optimized for a solo IT BA. The workflow should reduce duplicated writing and emit only the artifacts justified by the engagement.

1. Accept input (file or text)
2. Parse and normalize into intake form
3. Gap analysis and clarification
4. Scope lock and engagement-mode selection (`lite`, `hybrid`, or `formal`; default `hybrid`)
5. Build the persisted requirements backbone
6. Emit downstream artifacts from the backbone only when their gates are met
7. Produce behavioral specifications only for complex or risky flows
8. Produce the pre-wireframe screen spec (`Screen Contract Plus`) before any wireframe handoff when UI-backed scope exists
9. Produce technical specification slices only when integrations, NFR risk, or handoff needs justify them
10. Capture user-approved design decisions and persist a project `DESIGN.md` before preparing any wireframe handoff pack
11. Produce manual wireframe constraints and handoff checklists only for critical or explicitly requested screens
12. Run quality review and package only the artifacts actually emitted for the engagement

## Agent Delegation

| Agent | Scope |
| --- | --- |
| `requirements-engineer` | Intake refinement, requirements backbone, FRD, user stories, selective SRS content |
| `ui-ux-designer` | Manual wireframe constraint pack and handoff checklist from SRS usage |
| `ba-documentation-manager` | Validation pack, quality review, packaging, cross-references |
| `ba-researcher` | Domain research, standards, market context |

## Delegation Rules

- Route parallel work only when scopes do not overlap.
- Do not have two agents edit the same artifact at the same time.
- Prefer one primary owner per artifact.
- Merge outputs through the documentation manager or orchestrator.
- Escalate unresolved ambiguity before finalizing downstream work.
- Default to inline solo execution unless delegation materially reduces cycle time or improves quality.
- For Teamwork/Git-based branching: do not execute module-level tasks (`frd`, `srs`, `stories`, `wireframes`) outside of your explicitly assigned module feature branch. Do not scan or alter other modules unless assembling the compiled document.

## Delegation Hardening

- Build delegated work as narrow handoff packets, not full-document dumps.
- Each delegated packet should contain only the objective, target artifact, allowed write scope, exact upstream excerpts, trace IDs, and expected output sections.
- For non-trivial delegated work, include a dedicated tracker path under `plans/{slug}-{date}/delegation/` so progress is visible outside the live chat session.
- Do not pass the full playbook, full rule set, and full template into every sub-agent call once the orchestrator has already resolved the workflow.
- If the delegated packet still requires large merged artifacts to be understandable, repartition the work before spawning.
- When a delegated scope grows too large to keep terminology and traceability consistent, split it into smaller groups and rerun only the affected slice.
- If a worker lacks context or receives an overloaded scope, it must stop and return the exact missing inputs or a repartition request instead of guessing.
- A repartition response should identify the overloaded section, the reason it is too large, the smallest viable split, and the exact upstream inputs needed for the rerun.
- The orchestrator should create one tracker file per delegated slice, mark it `queued` before spawn, and require the worker to update it to `running` immediately on start.
- Workers should heartbeat after each major milestone and at least every 5 minutes during long-running work.
- If a delegated slice shows no heartbeat for more than 10 minutes and the target artifact has not advanced, treat it as likely stalled and recover intentionally instead of waiting blindly.
- **Never delegate assembly or merge steps** (merging SRS groups, FRD sections, or HTML conversion of large artifacts) to a sub-agent. Sub-agents have limited output tokens; a merged SRS easily exceeds that budget. Assembly must run inline in the orchestrator using incremental Read-then-Edit-append writes.

## Documentation Rules

- Use templates from `templates/` whenever a matching template exists.
- Document titles, headings, and filenames MUST align with the new Modular Architecture (System-level vs Module-level separation).
- Use descriptive kebab-case filenames for module slugs.
- System-level artifacts (Intake/Backbone) go in `plans/{slug}-{date}/01_intake/` and `plans/{slug}-{date}/02_backbone/`.
- Module-level (Feature) artifacts go in `plans/{slug}-{date}/03_modules/{module_slug}/`.
- Compiled, auto-merged artifacts go in `plans/{slug}-{date}/04_compiled/`.
- Delegation trackers for active sub-agent slices belong in `plans/{slug}-{date}/delegation/`.
- Preserve traceability links between source, analysis, and final outputs.
- Broken links and stale references must be corrected before handoff.
- For UI-backed SRS work, lock the system-level `Portal Matrix` in `02_backbone/backbone.md` before module screen authoring.
- For UI-backed SRS work, persist a project-specific runtime `designs/{slug}/DESIGN.md` before Step 9 wireframe handoff preparation.
- The `wireframe-input.md` and `wireframe-map.md` artifacts belong inside the specific module folder: `plans/{slug}-{date}/03_modules/{module_slug}/`.
- Persist the backbone as `plans/{slug}-{date}/02_backbone/backbone.md`. This is the default authoring source for downstream artifact emission.
- *Breaking Change:* Legacy report filenames (e.g., `plans/reports/final/*` or `002-intake-form.md`) are completely unsupported in the modular architecture. They must be migrated manually.

## Naming Convention

- **Root Folder:** `plans/{slug}-{date}/` (Replacing the old `{date}` token logic to maintain a single unified project root)
- **Intake:** `plans/{slug}-{date}/01_intake/intake.md`
- **Backbone:** `plans/{slug}-{date}/02_backbone/backbone.md`
- **Module Folders:** `plans/{slug}-{date}/03_modules/{module_slug}/`
- **FRD (Module):** `.../03_modules/{module_slug}/frd.md`
- **SRS (Module):** `.../03_modules/{module_slug}/srs.md`
- **User stories (Module):** `.../03_modules/{module_slug}/user-stories.md`
- **Compiled Outputs:** `plans/{slug}-{date}/04_compiled/compiled-frd.html` and `compiled-srs.html`
- Wireframes: a manual wireframe constraint pack plus a handoff checklist for user-supplied mockups
- Project runtime design system document: `designs/{slug}/DESIGN.md`
- Supporting wireframe frames: use the parent screen ID prefix plus a stable suffix such as `SCR-01-EMPTY`, `SCR-01-ERROR`, or `SCR-01-TOAST-SUCCESS`
- Modal/drawer/dialog overlays that affect flow should get their own primary `SCR-xx` IDs, not supporting-state suffix IDs

## Methodology

- Default to hybrid BA: formal analysis where risk is high, lightweight artifacts where speed matters.
- Optimize for one analyst holding the primary context. Prefer one persisted source of truth plus derived artifacts over parallel authoring of overlapping documents.
- Treat business requirements, stakeholder goals, process narratives, policies, and user flows as the primary scope inputs.
- Treat API docs, schemas, sample payloads, database contracts, and webhook specs as supporting technical inputs that clarify feasibility, integrations, and constraints.
- Do not let supporting technical inputs define scope on their own when primary requirement sources exist.
- Use supporting technical inputs to validate or refine FRD/SRS details after the backbone is established, not to replace backbone-first scoping.
- Reference BABOK 3.0 knowledge areas where useful, but keep outputs practical.
- Match artifact depth to business criticality, regulatory exposure, and audience.
- Start with discovery before solutioning.
- Validate requirements against business goals before finalizing.

## Critical Gates

- Approve scope before deep analysis.
- Build and review the backbone before emitting FRD, stories, SRS, or wireframes.
- Before Step 9, ask for or confirm project design decisions and persist them in `designs/{slug}/DESIGN.md`.
- Approve requirements before downstream production.
- Once a mutating rerun step is explicitly approved, keep that step locked for the current run; do not reopen generic discovery or ask the user to restate the task unless command, slug, date, or overwrite approval became genuinely ambiguous.
- `lite` mode should stop at intake + backbone + stories unless the user explicitly asks for more.
- `hybrid` mode is the default for solo IT BA work: backbone + targeted FRD + stories + selective SRS + critical-screen wireframe constraints when needed.
- `formal` mode should emit the full artifact set only when governance, vendor handoff, or regulatory needs require it.
- Pre-wireframe screen specs must lock `Portal ID`, `Nav Schema ID`, and expected active/highlight behavior before Step 9.
- **Cross-artifact consistency check before packaging:** UC steps, screen fields/actions, and wireframe constraints or user-supplied mockup labels must use identical terminology and describe the same behavior.
- Final screen descriptions may enrich content after Step 9, but they must not silently redefine portal ownership, global menu schema, or active/highlight behavior.
- Reusable cross-screen rules and standard messages should be centralized once in the SRS and referenced by code from individual screen descriptions to reduce duplication and drift.
- Shared SRS codes should follow one convention only: `CR-{TYPE}-{NN}` for rules and `MSG-{TYPE}-{NN}` for messages; do not mix local ad-hoc formats inside the same artifact set.
- Manual wireframe linkage must be screen-to-screen ID and final SRS insertion point or external reference location.
- Supporting frames that are not expanded into full screen sections must still be captured in the SRS screen inventory and present in the manual handoff checklist.
- Modal and overlay screens that affect flow must be treated like first-class screens in traceability, not collapsed into supporting-state inventory entries.
- Verify quality before handoff.
- **SRS preflight gate:** once slug/date and prerequisites are resolved, start from the exact backbone and user-stories artifacts, and pull the FRD only when it exists or is explicitly required.
- **FRD/stories preflight gate:** once slug/date and prerequisites are resolved, start from the exact backbone artifact instead of rereading unrelated report or module trees.
- **Context-loss recovery gate:** if exploration causes context pressure, recover from resolved command + slug/date + exact artifacts on disk; do not ask the user to restate the task unless the target really became ambiguous.
