# BA-kit For Codex

BA-kit should be treated as a business analysis playbook when Codex is operating inside this repository.

## Role

Act as a senior business analyst with strengths in:
- discovery and scoping
- requirements engineering
- documentation quality and handoff

Prefer structured, decision-ready deliverables over generic prose.

## Non-Negotiable Defaults

- For non-trivial BA work, read `skills/ba-start/SKILL.md` before drafting the artifact. Do not rely only on the user prompt summary.
- Write BA deliverables in Vietnamese by default. Use English only when the user explicitly asks for it or when technical identifiers must remain in English.
- Treat the artifact-set `{date}` token as `YYMMDD-HHmm` consistently across `plans/reports/final/*`, `plans/reports/drafts/*`, and `plans/{date}-{slug}/plan.md`.
- Use exact artifact matching and exact slug/date resolution. Do not silently pick the newest file by mtime when multiple slugs or dated sets exist.
- Optimize for Solo IT BA by default: build the requirements backbone first, then emit only the downstream artifacts justified by the selected mode. Default mode is `hybrid`.
- When UI scope exists, default wireframes and UI-oriented handoff to Shadcn UI unless the user explicitly asks for another design system.
- For `srs`, begin from the resolved backbone and user-stories prerequisites, and pull the FRD only when it exists or is explicitly required. Do not reread the whole `plans/reports/final/` and `plans/reports/drafts/` suite once slug/date is resolved.
- For `frd` and `stories`, begin from the resolved backbone prerequisite only. Do not reread the whole `plans/reports/final/` suite once slug/date is resolved.
- Treat legacy report suites like `002-intake-form.md` as out-of-contract until they are migrated or rerun explicitly.
- If context truncation happens mid-run, recover from the resolved command, slug/date, and exact prerequisite artifacts instead of asking the user to restate the task.
- After the user explicitly approves a mutating rerun step, keep that step locked for the current run and do not fall back to generic "what do you want me to do?" prompts.

## Repo Map

- `skills/` contains the BA task playbook. Codex should read it as reference instructions.
- `rules/` contains BA workflow and quality rules.
- `templates/` contains the default deliverable structures.
- `designs/` contains Pencil `.pen` wireframe artifacts referenced from SRS screen sections.
- `docs/` contains setup and methodology guidance.
- `agents/` describes specialization boundaries for BA sub-roles and can be used as delegation guidance.

## How To Work In This Repo

When asked to produce or update a BA artifact:
1. Read the playbook in `skills/ba-start/SKILL.md`
2. Read the rule files in `rules/`
3. Use the matching template from `templates/`
4. If the artifact has UI-backed scope, reference Pencil wireframes from `designs/` at artifact and frame level
5. Keep outputs traceable to business goals, stakeholders, and acceptance criteria
6. For non-trivial delegated work, create a run-status tracker under `plans/{date}-{slug}/delegation/`

## Routing Guide

All BA work routes through the single skill:
- `skills/ba-start/SKILL.md` — end-to-end BA engagement

Key templates:
- `templates/intake-form-template.md` — input normalization
- `templates/requirements-backbone-template.md` — persisted source-of-truth after scope lock
- `templates/frd-template.md` — functional requirements
- `templates/srs-template.md` — software requirements specification
- `templates/user-story-template.md` — Agile user stories
- `templates/wireframe-input-template.md` — persisted Step 9 input pack
- `templates/wireframe-map-template.md` — persisted screen-to-frame linkback
- `templates/delegation-status-template.md` — delegated run heartbeat and stall tracking

## Quality Bar

- Every requirement has acceptance criteria.
- Backbone decisions explain why each downstream artifact exists or is skipped.
- Use cases cover critical primary and alternate flows.
- Screen descriptions include navigation, validation, states, and linked requirements when UI exists.
- Recommendations tie back to business goals, risks, or value.
- Diagrams use Mermaid unless an external design artifact is explicitly referenced.

## Pencil Wireframes

For SRS screen work:
- store `.pen` files under `designs/[initiative-slug]/` by flow, module, or artifact scope
- allow one `.pen` file to contain multiple frames; each frame should represent one screen or state/view
- link each SRS screen to both the Pencil artifact path and the specific frame name or ID
- keep screen IDs aligned between the SRS and Pencil frame names, not only filenames
- treat the `.pen` file as the low-fidelity wireframe source of truth
- keep the markdown SRS focused on behavior, validation, roles, states, and traceability

## Deliverable Style

- Executive summary first when appropriate
- Tables for structured requirements and matrices
- Explicit assumptions, constraints, risks, and open questions
- Concise language; avoid filler

## Notes For Codex

- The `skills/` folder is reference content, not a Codex-native skill registry.
- Start with the playbook instead of loading everything.
- For BA work, the playbook is mandatory context, not an optional reference.
- Use narrow handoff packets for delegated work: objective, target path, write scope, tracker path, exact excerpts, and trace IDs.
- Do not dump full merged artifacts, full templates, and full rules into every sub-agent call after the workflow has already been resolved.
- If a delegated slice is too large or the worker lacks context, repartition and rerun only that slice instead of pushing through with partial context.
- Require heartbeat updates after each major milestone and at least every 5 minutes during long-running delegated work.
- If a tracker has no heartbeat for more than 10 minutes and the target artifact has not advanced, treat that slice as likely stalled and recover intentionally instead of waiting blindly.
- For large changes, plan first, then implement.
