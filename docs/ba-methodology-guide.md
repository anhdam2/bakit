# BA-kit Methodology Guide

## Overview

BA-kit uses a hybrid business analysis approach. The toolkit can shift toward Agile or Traditional delivery, but the default posture is to use the lightest process that still preserves traceability, stakeholder alignment, and decision quality.

## BABOK Alignment

| BABOK Knowledge Area | BA-kit Support |
| --- | --- |
| Business Analysis Planning and Monitoring | Intake form, work plan generation |
| Elicitation and Collaboration | Gap analysis, clarifying questions |
| Requirements Life Cycle Management | FRD, user stories, SRS, traceability |
| Strategy Analysis | Gap analysis, domain research |
| Requirements Analysis and Design Definition | FRD, SRS (use cases, screens, NFRs), wireframes |
| Solution Evaluation | Test cases, quality review |

## Agile BA Mode

Use Agile mode when:
- delivery is iterative
- stakeholder feedback cycles are frequent
- documentation needs to stay lightweight

Preferred artifact set:
- intake form
- user stories with acceptance criteria
- lightweight FRD

## Traditional BA Mode

Use Traditional mode when:
- approvals are formal
- the project has vendors, procurement, or contract dependencies
- governance requires baseline documents

Preferred artifact set:
- intake form
- FRD
- SRS with full use cases, screens, NFRs, and test cases
- traceability matrix

## Hybrid BA Mode (Default)

Hybrid mode fits most teams:
- use structured intake and formal scoping where ambiguity is high
- produce FRD and SRS for formal traceability
- switch to user stories for delivery execution
- keep a traceability bridge between formal requirements and backlog items

## Common Scenarios

### Greenfield Product

Start with `/ba-start` and a raw requirements document. The skill produces intake, FRD, user stories with AC, SRS with screen descriptions, and wireframes.

### ERP Process Improvement

Start with `/ba-start` and process descriptions. Focus on the FRD workflows and SRS technical specs.

### Regulated Change

Start with `/ba-start` with regulatory context. The SRS captures compliance constraints, the FRD covers business rules, and user stories include acceptance criteria tied to regulations.

## Modeling Standards

- Use Mermaid for diagrams
- Prefer one diagram per decision question
- Keep labels business-readable
- Distinguish current-state from future-state explicitly

## Quality Rules

- SMART for requirements
- INVEST for user stories
- One owner for each approval gate
- Every recommendation links to a business outcome, risk reduction, or cost effect
