---
name: ba-start
description: Single entry point for BA-kit. Accepts raw requirements (file or text), normalizes into an intake form, clarifies gaps, produces FRD, user stories, SRS, wireframes, and packages deliverables.
---

# BA Start

Use this skill to run an end-to-end business analysis engagement from raw input to packaged deliverables. This is the **only** skill in BA-kit — it orchestrates the full lifecycle.

## Inputs

- A file path to a requirements source (PDF, markdown, text, image, or Word), **or** pasted text directly
- Optional: known project name, requester, timeline constraints

## Workflow

### Step 1 — Accept Input

Ask the user to provide one of:
- A file path (PDF, MD, TXT, image, DOCX)
- Pasted text containing requirements or business context

**File reading approach:**
- **PDF**: Use `Read` tool (native PDF support)
- **Markdown / text**: Use `Read` tool directly
- **Images** (screenshots, whiteboard photos): Use `Read` tool (multimodal vision)
- **Word (.docx)**: Use `ai-multimodal` skill or ask the user to export as PDF/MD first

### Step 2 — Parse and Normalize

Read the source material and extract content into the [intake-form-template.md](../../templates/intake-form-template.md) structure:
- Project name, date, requester
- Business context (problem, goals, stakeholders mentioned)
- Raw requirements (extracted verbatim)
- Screens / UI mentioned
- Processes / workflows mentioned
- Constraints, assumptions, compliance needs
- Open questions identified during parsing

Save the completed intake form to `plans/reports/intake-{slug}-{date}.md`.

### Step 3 — Gap Analysis

Review the normalized intake against a BA completeness checklist:
- Are stakeholders identified with roles and influence?
- Is there a clear problem statement and measurable goal?
- Are scope boundaries defined (in-scope vs. out-of-scope)?
- Are success criteria or KPIs stated?
- Are compliance or regulatory obligations mentioned?
- Are UI screens described enough to wireframe?
- Are processes described enough to map?

Flag each gap explicitly.

### Step 4 — Ask Clarifying Questions

Present the identified gaps to the user as 3-8 targeted questions using `AskUserQuestion`. Focus on:
- Output language
- Missing stakeholders or decision makers
- Ambiguous scope boundaries
- Unstated success criteria
- Regulatory or compliance context
- Priority and sequencing preferences

Incorporate answers back into the intake form.

### Step 5 — Generate Work Plan

Based on the normalized intake, produce a scoped work plan covering:

**Deliverable selection:**

| Condition | Deliverable | Template |
| --- | --- | --- |
| Detailed functional spec needed | FRD | `frd-template.md` |
| Agile team needs stories | User stories | `user-story-template.md` |
| System spec with screens, use cases, or test cases | SRS | `srs-template.md` |
| UI screens mentioned | Wireframes | `designs/{slug}/` via Pencil MCP, grouped by flow/module with frame-level screen mapping |

**SRS default routing** — SRS is included by default alongside FRD when the intake contains **any** of:
- UI screens or screen descriptions
- System-level interactions (APIs, integrations, data flows)
- Mobile or web application scope
- Test case or acceptance testing expectations

**Agent delegation:**

| Agent | When |
| --- | --- |
| `requirements-engineer` | FRD, user stories, SRS production (parallel subagents for SRS) |
| `ui-ux-designer` | Pencil wireframe generation from SRS screens |
| `ba-documentation-manager` | Final packaging and quality review |
| `ba-researcher` | Domain research when external context is needed |

**Execution order:**
Intake → FRD → User Stories → SRS (parallel groups) → Wireframes → Quality Review

Save the work plan to `plans/{date}-{slug}/plan.md`.

### Step 6 — Produce FRD

Delegate to `requirements-engineer` agent. Produce the FRD using [frd-template.md](../../templates/frd-template.md):
- Functional overview
- User personas
- Feature list with MoSCoW priorities
- Workflows (Mermaid)
- Data requirements
- Business rules
- Integration points
- Acceptance criteria

Save to `plans/reports/frd-{date}-{slug}.md`.

**Export FRD to HTML** (for rendered Mermaid workflows):
```
python scripts/md-to-html.py plans/reports/frd-{date}-{slug}.md
```
Output: `plans/reports/frd-{date}-{slug}.html`

### Step 7 — Produce User Stories

Generate Agile user stories from the FRD feature list using [user-story-template.md](../../templates/user-story-template.md):
- Epic and feature breakdown
- User stories with acceptance criteria (Given/When/Then)
- INVEST validation
- Story-to-screen alignment when UI exists

**User stories with their acceptance criteria become primary input for SRS, wireframes, and downstream artifacts.** Every SRS functional requirement, use case, and screen description should trace back to one or more user stories.

Save to `plans/reports/user-stories-{date}-{slug}.md`.

### Step 8 — Produce SRS (Parallel Delegation)

SRS is the largest artifact. Split across subagent groups with dependency ordering.

**Prerequisite:** Intake form, FRD output, and **user stories with AC** must be provided as context to all subagents. User stories drive the scope — every FR, UC, and SCR should map to user stories.

**Sub-agent context management:**
- Each sub-agent has a 200K token context window. To avoid overflow:
  - Pass only **relevant sections** of upstream artifacts, not full documents
  - Group A receives: intake summary (not raw source), FRD features + business rules, user stories
  - Group B receives: Group A FR table + user stories (not full FRD)
  - Group C receives: Group A FR table + Group B use cases + user stories (not full FRD)
  - Group D receives: Group A FR table + FRD technical sections only
  - Group E receives: FR IDs + UC IDs + SCR IDs (reference lists, not full content)
- When a group produces more than **15 use cases or 10 screens**, split into sub-groups (e.g., Group B1 for UC-01 to UC-08, Group B2 for UC-09 to UC-15)
- Assembly agent merges all fragments — it needs full content but only reads final outputs, not intermediate context

#### Group A — Core (runs first, blocks all others)

**Agent:** `requirements-engineer`
**Sections:** Purpose and Scope, Overall Description, Functional Requirements table
**Input:** Intake form, FRD, user stories
**Output:** `plans/reports/srs-{date}-{slug}-group-a.md`

#### Groups B, D — run in parallel after Group A

**Group B — Behavioral**
**Agent:** `requirements-engineer`
**Sections:** Use Case Specifications (summary + detailed use cases with alternate flows)
**Input:** Group A output, user stories
**Output:** `plans/reports/srs-{date}-{slug}-group-b.md`
**Consistency:** Each UC must link to user stories (US-xxx) and screens (SCR-xx). UC actor actions must use the same terminology as user story descriptions and FRD features.

#### Group C — Screens (after Group B, for UC-Screen alignment)
**Agent:** `requirements-engineer`
**Sections:** Screen Descriptions (summary + screen details with layout, regions, field table, actions, states, permissions)
**Input:** Group A output, user stories, **Group B output (use cases)**
**Output:** `plans/reports/srs-{date}-{slug}-group-c.md`
**Consistency:** Each screen must link to its use cases (UC-xx) and user stories (US-xxx). Screen fields and actions must implement the exact interactions described in linked use cases — same field names, same action labels, same flow sequence.

**Screen field table format:**

| Field Name | Field Type | Description |
| --- | --- | --- |
| [Field] | [Type] | Display: [...] / Behaviour: [...] / Validation: [...] |

The Description column contains up to three rule categories as needed:
- **Display Rules**: visibility, defaults, read-only conditions, formatting
- **Behaviour Rules**: on-change actions, auto-fill, cascading, navigation triggers
- **Validation Rules**: required, format, range, cross-field, error messages

**Group D — Technical**
**Agent:** `requirements-engineer`
**Sections:** Non-Functional Requirements, Data Flow Diagrams, ERD, API Specs, Constraints
**Input:** Group A output, FRD
**Output:** `plans/reports/srs-{date}-{slug}-group-d.md`

#### Group E — Validation (after B, C, D)

**Agent:** `requirements-engineer`
**Sections:** Test Cases, Glossary, Traceability cross-references
**Output:** `plans/reports/srs-{date}-{slug}-group-e.md`

#### Assembly

After all groups complete:
1. Merge groups into a single SRS following `srs-template.md` section order
2. **Cross-artifact consistency check:**
   - Every UC step maps to a screen field or action (and vice versa)
   - UC actor actions use the same wording as screen User Actions
   - UC system responses match screen field Behaviour Rules
   - UC alternate flows are reflected in screen Error/States
   - Field names are identical between UC steps, screen field tables, and wireframe labels
   - User story AC conditions are covered by UC postconditions and screen Validation Rules
3. Cross-link pass: resolve UC-TBD placeholders in screens
4. Resolve ID conflicts across namespaces (FR, UC, SCR, NFR, TC)
5. Verify every SCR and UC traces back to user stories
6. Save to `plans/reports/srs-{date}-{slug}.md`
7. Delete group fragments only after merged SRS is verified

**Execution pattern:**
```
Group A
    ├── Group B ─┐
    └── Group D ─┼── parallel
                 │
    Group C (needs B for UC-SCR alignment)
          │
    Group E
          │
    Assembly (cross-artifact consistency check)
          │
    Wireframes (Step 9)
```

**Failure handling:** If a group subagent fails, retry once. If still failing, the orchestrator produces that group inline.

### Step 9 — Generate Wireframes (automatic for SRS with screens)

When SRS contains Screen Descriptions (SCR-xx entries), generate Pencil wireframes.

**Step 9.1 — Extract screen list**

Parse the SRS for all SCR-xx entries and build a generation plan.
Group related screens into one or more Pencil artifacts by flow, module, or journey.

**Step 9.2 — Ask user for wireframe preferences**

```
"The SRS defines {N} screens. How should I generate wireframes?"
- "Generate all wireframes automatically"
- "Let me pick which screens"
- "Skip wireframes"
```

**Step 9.3 — Delegate to ui-ux-designer agent**

For each approved screen group:
1. Read the Screen Detail from the SRS (field table, actions, states, linked UCs)
2. Verify wireframe will match: same fields, same labels, same action buttons as screen description
3. Get design guidelines: `get_guidelines(topic="web-app")` or `"mobile-app"`
4. Get style guide: `get_style_guide_tags` then `get_style_guide(tags=[...])`
5. Create or update one `.pen` artifact per approved screen group via Pencil MCP tools
6. Create one frame per screen or state/view inside that artifact; name each frame with the screen ID prefix, e.g. `SCR-01 - Login`
7. Validate with `get_screenshot` — check frame field names and action labels match the SRS screen description
8. Save artifact to `designs/{slug}/{artifact-name}.pen`

**Sub-agent batching for wireframes:** When the project has more than 5 screens, batch screen groups across multiple `ui-ux-designer` agents (about 3-5 screens per agent) to avoid context overflow. Each agent receives only its assigned screens' SRS details — not the full SRS. Style guide and guidelines are fetched once and passed as context to all agents.

**Step 9.4 — Export wireframes to PNG**

Export each relevant frame node to PNG for embedding in the final SRS document:
```
mcp__pencil__export_nodes(filePath="designs/{slug}/{artifact-name}.pen", nodeIds=[frameNodeId], outputDir="designs/{slug}/exports/{artifact-name}/", format="png")
```
Rename or map the exported files so each SRS screen points to a stable screen-level image path such as `designs/{slug}/exports/{artifact-name}/SCR-01-login.png`.

**Step 9.5 — Link wireframes back to SRS**

Update the SRS to fill in `Pencil Artifact:`, `Pencil Frame:`, and the Wireframe Reference section for each screen.

### Step 10 — Quality Review

Delegate to `ba-documentation-manager` agent:
- Verify all deliverables follow their templates
- Check cross-references between FRD, user stories, and SRS
- Verify user story traceability: every SRS FR, UC, and SCR maps to at least one user story
- **Cross-artifact consistency audit:**
  - UC actor actions match screen User Actions (same wording)
  - UC system responses match screen Behaviour Rules
  - Field names are identical across UC steps, screen field tables, and wireframes
  - User story AC conditions are covered by UC postconditions and screen Validation Rules
  - FRD features are fully covered by user stories and SRS requirements
- Validate naming conventions and file structure
- Flag broken links or missing sections
- Produce a delivery summary

### Step 11 — Package Deliverables

**Step 11.1 — Generate SRS HTML with embedded wireframes**

Convert the merged SRS markdown to HTML with wireframe images embedded inline:
```
python scripts/md-to-html.py plans/reports/srs-{date}-{slug}.md
```

This script:
- Embeds explicitly referenced wireframe PNGs as base64 images
- Generates a styled HTML document with table of contents
- Supports page breaks for PDF printing (browser Print → Save as PDF)

Output: `plans/reports/srs-{date}-{slug}.html`

**Step 11.2 — Final output structure**

```
plans/
  reports/
    intake-{slug}-{date}.md
    frd-{date}-{slug}.md              # Source markdown
    frd-{date}-{slug}.html            # With rendered Mermaid diagrams
    user-stories-{date}-{slug}.md
    srs-{date}-{slug}.md              # Source markdown
    srs-{date}-{slug}.html            # With embedded wireframes + diagrams
  {date}-{slug}/
    plan.md
designs/
  {slug}/
    auth-flow.pen                     # Editable wireframe source with multiple frames
    checkout.pen                      # Another artifact if scope is large
    exports/
      auth-flow/
        SCR-01-login.png              # Exported frame image for embedding
        SCR-02-otp.png
      checkout/
        SCR-05-review-order.png
```

The `.html` files are the **primary deliverables** for stakeholders. The `.md` files remain as editable sources for future revisions.

## Deliverables

- Normalized intake form
- Gap analysis summary
- Scoped BA work plan
- FRD (functional requirements document) — HTML with rendered Mermaid diagrams
- User stories with acceptance criteria
- SRS (software requirements specification) with use cases, screens, NFRs, test cases
- SRS as HTML with embedded wireframe images and rendered diagrams (primary stakeholder deliverable)
- Pencil wireframes for SRS screens (`.pen` artifacts + frame-level `.png` exports)
- Quality review summary

## Templates

- [intake-form-template.md](../../templates/intake-form-template.md)
- [frd-template.md](../../templates/frd-template.md)
- [user-story-template.md](../../templates/user-story-template.md)
- [srs-template.md](../../templates/srs-template.md)

## Agent Delegation

| Agent | Role |
| --- | --- |
| `requirements-engineer` | FRD, user stories, SRS groups A-E |
| `ui-ux-designer` | Pencil wireframe generation |
| `ba-documentation-manager` | Quality review and packaging |
| `ba-researcher` | Domain research when needed |

## Quality Check

- Intake form has no blank required sections
- Every gap is resolved or listed as an open question
- FRD covers all features with priorities and acceptance criteria
- User stories follow INVEST and have Given/When/Then acceptance criteria
- SRS covers functional requirements, use cases, screens, NFRs, and test cases
- Every FR, UC, and SCR links to at least one user story
- Screen field tables use the Display/Behaviour/Validation description format
- **Cross-artifact consistency:** UC steps, screen fields/actions, and wireframe labels use identical terminology
- **UC-Screen alignment:** every UC actor action has a matching screen User Action; every UC system response has a matching screen Behaviour Rule
- **Wireframe fidelity:** wireframes match their SRS screen descriptions field-by-field
- SRS screens have linked `.pen` artifacts and frame references (unless user skipped)
- Screen IDs are aligned between SRS and Pencil frame names
- Cross-references between FRD, user stories, and SRS are consistent

## Token Efficiency

- **Pass minimal context to sub-agents.** Each agent receives only the sections it needs — never the full set of upstream documents.
- **Cache reusable artifacts.** Style guide and design guidelines are fetched once per project and passed to all wireframe agents as context.
- **Read templates once.** The orchestrator reads template files and passes the relevant template section to each sub-agent — agents do not re-read templates.
- **Chunk large groups.** When a group would produce more than 15 use cases or 10 screens, split into sub-groups to prevent context overflow.
- **Assembly reads only outputs.** The merge agent reads final group outputs, not intermediate context or full upstream docs.
- **Wireframe agents get screen slices.** Each wireframe agent receives only its assigned 3-5 screen descriptions, not the full SRS.
