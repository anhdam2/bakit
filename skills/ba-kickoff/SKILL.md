---
name: ba-kickoff
description: Accepts a raw requirements file or pasted text, normalizes it into a structured intake form, identifies gaps, asks clarifying questions, and generates a scoped BA work plan.
---

# BA Kickoff

Use this skill when you have raw requirements input (a file or pasted text) and need to bootstrap a full BA engagement. This is the single entry point that routes work across discovery, stakeholders, requirements, wireframes, process maps, and compliance.

## Inputs

- A file path to a requirements source (PDF, markdown, text, image, or Word), **or** pasted text directly
- Optional: known project name, requester, timeline constraints

## Workflow

### Step 1 — Accept Input

Ask the BA to provide one of:
- A file path (PDF, MD, TXT, image, DOCX)
- Pasted text containing requirements or business context

**File reading approach:**
- **PDF**: Use `Read` tool (native PDF support)
- **Markdown / text**: Use `Read` tool directly
- **Images** (screenshots, whiteboard photos): Use `Read` tool (multimodal vision) or delegate to `ai-multimodal` skill for detailed extraction
- **Word (.docx)**: Use `ai-multimodal` skill or ask the BA to export as PDF/MD first

### Step 2 — Parse and Normalize

Read the source material and extract content into the [intake-form-template.md](../../templates/intake-form-template.md) structure:
- Project name, date, requester
- Business context (problem, goals, stakeholders mentioned)
- Raw requirements (extracted verbatim)
- Screens / UI mentioned
- Processes / workflows mentioned
- Constraints, assumptions, compliance needs
- Open questions identified during parsing
- Source file reference and parsing notes

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

Present the identified gaps to the BA as 3-8 targeted questions using `AskUserQuestion` or direct prompts. Focus on:
- Missing stakeholders or decision makers
- Ambiguous scope boundaries
- Unstated success criteria
- Regulatory or compliance context
- Priority and sequencing preferences

Incorporate the BA's answers back into the intake form.

### Step 5 — Generate Work Plan

Based on the normalized intake and BA answers, produce a scoped BA work plan covering:

**Document selection** — which artifacts to produce:

| Condition | Deliverable | Skill | Template |
| --- | --- | --- | --- |
| Formal governance or vendor contract | BRD | `ba-requirements` | `brd-template.md` |
| Detailed functional spec needed | FRD | `ba-requirements` | `frd-template.md` |
| System spec with screens and test cases | SRS | `ba-requirements` | `srs-template.md` |
| Agile team needs stories | User stories | `ba-user-stories` | `user-story-template.md` |
| Stakeholders need mapping | Stakeholder register + RACI | `ba-stakeholder` | `stakeholder-register-template.md`, `raci-template.md` |
| Processes need documentation | Process maps | `ba-process-mapping` | `process-map-template.md` |
| Regulatory exposure exists | Compliance map | `ba-compliance` | — |
| Gaps between current and target state | Gap analysis | `ba-gap-analysis` | `gap-analysis-template.md` |
| UI screens mentioned | Wireframes | Pencil MCP tools | `designs/{slug}/` |
| Strategic framing needed | SWOT | `ba-swot` | `swot-template.md` |
| Financial justification needed | Cost-benefit | `ba-cost-benefit` | `feasibility-template.md` |

**Skill chain** — recommended execution order, e.g.:
`ba-discovery` -> `ba-stakeholder` -> `ba-requirements` -> `ba-process-mapping` -> `ba-compliance`

**Agent delegation** — which agent roles to involve:

| Agent | When |
| --- | --- |
| `stakeholder-analyst` | Stakeholders need mapping or engagement planning |
| `requirements-engineer` | Formal requirements capture |
| `process-mapper` | Process flows need modeling |
| `ba-researcher` | Domain research or market context needed |
| `compliance-auditor` | Regulatory or governance checks required |
| `ba-documentation-manager` | Final packaging and quality review |

**Effort estimate** — light / medium / heavy per deliverable.

### Step 6 — Save Outputs

- Intake form: `plans/reports/intake-{slug}-{date}.md`
- Work plan: `plans/{date}-{slug}/plan.md`

## Deliverables

- Normalized intake form (from template)
- Gap analysis summary
- Scoped BA work plan with skill chain, agent routing, and deliverable list

## Templates

- Use [intake-form-template.md](../../templates/intake-form-template.md)

## Related Skills

- `ba-discovery`
- `ba-stakeholder`
- `ba-requirements`
- `ba-user-stories`
- `ba-process-mapping`
- `ba-compliance`
- `ba-gap-analysis`
- `ba-feasibility`
- `ba-cost-benefit`
- `ba-swot`

## Quality Check

- Intake form has no blank required sections
- Every gap is either resolved or listed as an open question
- Work plan names specific skills, templates, and agents
- Skill chain order respects dependencies (discovery before requirements, requirements before compliance)
- Deliverable list matches the complexity and governance needs of the initiative
