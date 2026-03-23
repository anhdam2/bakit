---
name: ba-requirements
description: Handles requirements elicitation, analysis, documentation, prioritization, and validation across BRD, FRD, SRS, and user story formats.
---

# BA Requirements

Use this skill to turn business intent into precise, testable requirements.

## Workflow

### Phase 1 — Requirements Elicitation & Documentation

1. Confirm scope, goal, and audience.
2. Elicit requirements using interviews, workshops, or document review.
3. Normalize statements into clear business, functional, and non-functional requirements.
4. Add supporting structure for the chosen artifact: use cases, business rules, screen descriptions, and traceability where needed.
5. Prioritize with MoSCoW or WSJF.
6. Validate each requirement for SMART quality and ambiguity.
7. Package the result in the right document format.

**For BRD/FRD:** Execute Phase 1 inline (single agent). These are shorter documents.

**For SRS:** Use the parallel delegation workflow in Phase 1a below.

### Phase 1a — SRS Parallel Delegation

SRS is the longest BA artifact. Split the work across subagents using 6 groups with dependency ordering. The orchestrating agent coordinates handoffs and assembles the final document.

**Prerequisite:** Intake form and FRD (if available) must be provided as context to all subagents.

#### Group A — Core (runs first, blocks all others)

**Agent:** `requirements-engineer`
**Sections:** Purpose and Scope, Overall Description, Functional Requirements table
**Output:** `plans/reports/srs-{date}-{slug}-group-a.md`
**Instructions to agent:**
- Read intake form, FRD, and any source material
- Write Purpose and Scope, Overall Description (product perspective, user classes, operating environment, assumptions)
- Produce the full Functional Requirements table (FR-01..FR-N) with IDs, priorities, sources, acceptance criteria
- This output is the foundation — all other groups depend on it

#### Groups B, C, D — run in parallel after Group A completes

**Group B — Behavioral**
**Agent:** `requirements-engineer`
**Sections:** Use Case Specifications (summary table + detailed use cases with alternate flows, business rules, acceptance notes)
**Output:** `plans/reports/srs-{date}-{slug}-group-b.md`
**Instructions to agent:**
- Read Group A output for FR references
- Write use case summary table and expand critical use cases
- Each use case must reference FRs, include alternate flows, and state business rules

**Group C — Screens**
**Agent:** `requirements-engineer`
**Sections:** Screen Descriptions (summary table + screen details with layout, wireframe intent, screen regions, low-fidelity text wireframe, fields, actions, states, permissions, responsive notes, accessibility notes)
**Output:** `plans/reports/srs-{date}-{slug}-group-c.md`
**Instructions to agent:**
- Read Group A output for FR references and user classes
- Write screen summary table (SCR-01..SCR-N)
- Expand each screen with all `srs-template.md` Screen Detail sub-sections: layout summary, navigation rules, wireframe intent, screen regions table, low-fidelity text wireframe, field/control table, user actions, error/empty states, state variants, permission/visibility rules, responsive notes, accessibility/UX notes
- For linked use cases: use placeholder references (UC-TBD) — resolved during Assembly cross-linking pass
- For linked requirements: reference FR IDs from Group A
- Leave `Pencil Artifact:` paths as TBD — wireframes come in Phase 2

**Group D — Technical**
**Agent:** `requirements-engineer`
**Sections:** Non-Functional Requirements, Data Flow Diagrams, Entity Relationship Diagram, API Specifications, Constraints
**Output:** `plans/reports/srs-{date}-{slug}-group-d.md`
**Instructions to agent:**
- Read Group A output for FR references
- Write NFR table (performance, security, scalability, availability, etc.)
- Produce Mermaid data flow diagrams and ERD
- Document API specs (endpoints, methods, request/response schemas, error handling)
- List technical, regulatory, and operational constraints

#### Group E — Validation (runs after B, C, D complete)

**Agent:** `requirements-engineer`
**Sections:** Test Cases, Glossary, Traceability cross-references
**Output:** `plans/reports/srs-{date}-{slug}-group-e.md`
**Instructions to agent:**
- Read Groups A, B, C, D outputs
- Write test cases covering FRs, use cases, and screen interactions
- Produce glossary of domain terms
- Validate traceability: every FR links to a use case, screen, or test case

#### Assembly — Orchestrator merges groups

After all groups complete:
1. Merge Group A + B + C + D + E into a single SRS document following `srs-template.md` section order
2. Cross-link pass: resolve UC-TBD placeholders in Group C screens by matching Group B use cases to screens based on shared FR references and functional overlap
3. Resolve ID conflicts: each group owns its namespace (A: FR-xx, B: UC-xx, C: SCR-xx, D: NFR-xx, E: TC-xx). If duplicates exist within a namespace, renumber the later group's IDs and update all internal references
4. Add Related Templates section
5. Save final SRS to `plans/reports/srs-{date}-{slug}.md`
6. Delete group fragment files only after the merged SRS is saved and verified (file exists, non-empty, contains all expected section headers). Keep fragments if merge fails

**`{date}` format:** Use `YYMMDD` matching the project naming convention (e.g., `srs-260323-vouch-mobile.md`).

#### Subagent failure handling

If a group subagent fails or produces unusable output:
1. Retry once with the same inputs
2. If still failing, the orchestrator produces that group's sections inline
3. Note the fallback in the Assembly merge log

#### Execution pattern

```
Group A (requirements-engineer)
    │
    ├── Group B (requirements-engineer)  ─┐
    ├── Group C (requirements-engineer)  ─┼── all parallel
    └── Group D (requirements-engineer)  ─┘
                    │
              Group E (requirements-engineer)
                    │
              Assembly (orchestrator)
                    │
              Phase 2 (ui-ux-designer — wireframes)
```

### Phase 2 — Wireframe Generation (automatic for SRS)

When the deliverable is an **SRS** and contains **Screen Descriptions** (SCR-xx entries), generate Pencil wireframes using a dedicated subagent.

**Step 2.1 — Extract screen list**

Parse the completed SRS for all `SCR-xx` entries. Build a generation plan:

| Screen ID | Screen Name | Key Elements | Target File |
|-----------|-------------|-------------|-------------|
| SCR-01 | Login | email, password, social login, forgot password | `designs/{slug}/SCR-01-login.pen` |
| SCR-02 | Dashboard | stats cards, recent activity, nav sidebar | `designs/{slug}/SCR-02-dashboard.pen` |

**Step 2.2 — Ask user for wireframe preferences**

Use `AskUserQuestion`:
```
Question: "The SRS defines {N} screens. How should I generate wireframes?"
Options:
  - "Generate all wireframes automatically" — create .pen files for every screen
  - "Let me pick which screens" — user selects subset
  - "Skip wireframes" — no .pen files, just the SRS
```

**Step 2.3 — Delegate wireframe generation**

**Agent:** `ui-ux-designer`

Spawn a `ui-ux-designer` subagent for wireframe generation. Pass the following context:
- The completed SRS (or just the Screen Descriptions sections)
- The initiative slug for file naming
- The app type (web-app or mobile-app) for guideline selection
- The list of approved screen IDs from Step 2.2

**Instructions to wireframe agent:**
For each approved screen:
1. Read the Screen Detail section from the SRS (layout summary, regions, fields, actions, states)
2. Get design guidelines: `get_guidelines(topic="web-app")` (or `"mobile-app"` based on context)
3. Get style guide: `get_style_guide_tags` → `get_style_guide(tags=[...])`
4. Create `.pen` file: `open_document("new")` → `batch_design` with layout, fields, buttons, nav per the SRS spec
5. Validate: `get_screenshot` → visually verify layout matches SRS intent
6. Save to `designs/{initiative-slug}/SCR-xx-{screen-name}.pen`

**Token efficiency**: Generate screens sequentially within the subagent (one `.pen` at a time). Reuse the same style guide across all screens.

**Step 2.4 — Link wireframes back to SRS**

After wireframe agent completes, update the SRS document to fill in:
- `Pencil Artifact:` paths in each Screen Detail section
- `Wireframe / Mockup Reference` section with file paths and covered screen IDs

## Deliverables
- Requirements list with IDs
- Use case specifications for critical interactions
- Screen descriptions for UI-backed scope
- Pencil `.pen` wireframes auto-generated for SRS screens (unless user skips)
- Prioritized backlog or requirement set
- Traceability matrix
- Change log and open questions

## Templates
- Use [brd-template.md](../../templates/brd-template.md)
- Use [frd-template.md](../../templates/frd-template.md)
- Use [srs-template.md](../../templates/srs-template.md)
- Use [user-story-template.md](../../templates/user-story-template.md)
- Use [change-impact-template.md](../../templates/change-impact-template.md)

## Pencil Wireframes
- Use Pencil for low-fidelity screen wireframes referenced by the SRS
- Store `.pen` artifacts under `designs/[initiative-slug]/`
- Keep screen IDs aligned between the SRS and artifact filenames
- Reference the `.pen` path directly in each screen description

## Related Skills
- `ba-acceptance-criteria`
- `ba-user-stories`
- `ba-gap-analysis`
- `ba-compliance`

## Quality Check
- Every requirement has acceptance criteria
- Use cases cover primary and alternate flows for critical scope
- Screen descriptions capture fields, validations, and navigation where applicable
- SRS screens have corresponding `.pen` wireframes in `designs/` (unless user explicitly skipped)
- Each `.pen` filename matches its SRS screen ID (SCR-xx alignment)
- Wireframe screenshots visually match the SRS screen layout intent
- Each requirement has one interpretation
- Priorities are explicit and defensible
- SRS group fragments are merged and fragment files cleaned up
- Cross-references between FRs, UCs, SCRs, and TCs are consistent
