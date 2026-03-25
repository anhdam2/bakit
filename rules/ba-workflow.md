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
6. User story generation (stories + AC become input for SRS and downstream)
7. SRS production (parallel delegation, driven by user stories)
8. Wireframe generation (for SRS screens)
9. Quality review and packaging

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

## Documentation Rules

- Use templates from `templates/` whenever a matching template exists.
- Keep document titles, headings, and filenames aligned.
- Use descriptive kebab-case filenames.
- Final artifacts go in `plans/reports/`. Work plans go in `plans/{date}-{slug}/`.
- Preserve traceability links between source, analysis, and final outputs.
- Broken links and stale references must be corrected before handoff.

## Naming Convention

- `{date}` uses `YYMMDD` format matching `.ck.json` convention.
- Intake: `plans/reports/intake-{slug}-{date}.md`
- FRD: `plans/reports/frd-{date}-{slug}.md`
- SRS: `plans/reports/srs-{date}-{slug}.md`
- User stories: `plans/reports/user-stories-{date}-{slug}.md`
- Wireframes: `designs/{slug}/{artifact-name}.pen` plus frame-level screen mapping in the SRS

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
- Verify quality before handoff.
