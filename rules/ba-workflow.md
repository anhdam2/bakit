# BA Workflow

Consolidated workflow rules for BA-kit covering lifecycle, delegation, documentation, and methodology.

Related rules:
- [BA Quality Standards](./ba-quality-standards.md)

## Lifecycle

1. Accept input (file or text)
2. Parse and normalize into intake form
3. Gap analysis and clarification
4. Work planning and deliverable selection
5. FRD production
6. User story generation (stories + AC become input for use cases and downstream)
7. Use case specification production
8. Screen Contract Lite production
9. Wireframe generation (from use cases + screen contract)
10. Final screen description production
11. Quality review and unified HTML packaging

## Agent Delegation

| Agent | Scope |
| --- | --- |
| `requirements-engineer` | FRD, user stories, SRS groups, traceability |
| `ui-ux-designer` | Pencil wireframes from SRS screens |
| `ba-documentation-manager` | Quality review, packaging, cross-references |
| `ba-researcher` | Domain research, standards, market context |

## Delegation Rules

- Route parallel work only when scopes do not overlap.
- Do not have two agents edit the same artifact at the same time.
- Prefer one primary owner per artifact.
- Merge outputs through the documentation manager or orchestrator.
- Escalate unresolved ambiguity before finalizing downstream work.

## Delegation Hardening

- Build delegated work as narrow handoff packets, not full-document dumps.
- Each delegated packet should contain only the objective, target artifact, allowed write scope, exact upstream excerpts, trace IDs, and expected output sections.
- Do not pass the full playbook, full rule set, and full template into every sub-agent call once the orchestrator has already resolved the workflow.
- If the delegated packet still requires large merged artifacts to be understandable, repartition the work before spawning.
- When a delegated scope grows too large to keep terminology and traceability consistent, split it into smaller groups and rerun only the affected slice.
- If a worker lacks context or receives an overloaded scope, it must stop and return the exact missing inputs or a repartition request instead of guessing.
- A repartition response should identify the overloaded section, the reason it is too large, the smallest viable split, and the exact upstream inputs needed for the rerun.

## Documentation Rules

- Use templates from `templates/` whenever a matching template exists.
- Keep document titles, headings, and filenames aligned.
- Use descriptive kebab-case filenames.
- Final artifacts go in `plans/reports/`. Work plans go in `plans/{date}-{slug}/`.
- Preserve traceability links between source, analysis, and final outputs.
- Broken links and stale references must be corrected before handoff.

## Naming Convention

- `{date}` uses `YYMMDD-HHmm` format matching `.ck.json` convention.
- Use the same `{date}` token for the report artifacts and the corresponding `plans/{date}-{slug}/plan.md` directory so a dated artifact set resolves unambiguously.
- Intake: `plans/reports/intake-{slug}-{date}.md`
- FRD: `plans/reports/frd-{date}-{slug}.md`
- SRS: `plans/reports/srs-{date}-{slug}.md`
- User stories: `plans/reports/user-stories-{date}-{slug}.md`
- Wireframes: `designs/{slug}/{artifact-name}.pen` plus frame-level screen mapping in the SRS
- Supporting wireframe frames: use the parent screen ID prefix plus a stable suffix such as `SCR-01-EMPTY`, `SCR-01-ERROR`, or `SCR-01-TOAST-SUCCESS`
- Modal/drawer/dialog overlays that affect flow should get their own primary `SCR-xx` IDs, not supporting-state suffix IDs

## Methodology

- Default to hybrid BA: formal analysis where risk is high, lightweight artifacts where speed matters.
- Reference BABOK 3.0 knowledge areas where useful, but keep outputs practical.
- Match artifact depth to business criticality, regulatory exposure, and audience.
- Start with discovery before solutioning.
- Validate requirements against business goals before finalizing.

## Critical Gates

- Approve scope before deep analysis.
- Approve requirements before downstream production.
- **Cross-artifact consistency check before packaging:** UC steps, screen fields/actions, and wireframe labels must use identical terminology and describe the same behavior.
- Wireframe linkage must be screen-to-frame, not screen-to-file only. A single `.pen` file may cover multiple screens.
- Supporting frames that are not expanded into full screen sections must still be captured in the SRS screen inventory and present in the `.pen` artifact.
- Modal and overlay screens that affect flow must be treated like first-class screens in traceability, not collapsed into supporting-state inventory entries.
- Verify quality before handoff.
