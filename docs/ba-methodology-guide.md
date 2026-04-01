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

## Input Source Hierarchy

BA-kit treats input sources by decision authority, not by document detail.

| Input Type | Typical Examples | Primary Use In BA-kit | Decision Authority |
| --- | --- | --- | --- |
| Primary requirement sources | business brief, BRD/PRD, workshop notes, stakeholder decisions, process maps, policy documents, user flows | define scope, business goals, actors, business rules, success metrics | highest |
| Supporting technical sources | API docs, OpenAPI/Swagger, sample payloads, database schemas, event/webhook contracts | validate feasibility, clarify integration behavior, surface constraints and error cases | secondary |

Rule of thumb:
- primary requirement sources decide what problem is being solved
- supporting technical sources clarify how the solution can integrate or what constraints already exist
- BA-kit should not let an API doc silently become the scope source when business requirement artifacts exist

## Using API Docs Alongside Requirements

When an API doc is present, BA-kit should treat it as a supporting artifact that sharpens handoff quality without replacing discovery.

| BA-kit Artifact | Primary Inputs | How API Docs Contribute | What API Docs Must Not Do |
| --- | --- | --- | --- |
| Intake | requirement doc, stakeholder notes, process context | expose missing actors, missing field definitions, unclear dependencies, and technical risks | define project scope by themselves |
| Requirements backbone | intake + clarified scope | confirm existing capabilities, integration boundaries, candidate FR/NFR constraints, and delivery risks | override business goals, priorities, or in/out-of-scope decisions |
| FRD | backbone | enrich workflows, data requirements, business-rule constraints, integration points, error handling, and performance expectations | turn the FRD into an endpoint inventory with no business flow |
| User stories | backbone | sharpen acceptance criteria around validation, responses, and failure handling | replace user outcomes with API tasks |
| SRS | backbone + user stories, plus FRD when required | specify request/response behavior, field rules, system responses, NFRs, and API-linked screen behavior | become the sole source of truth for user interaction or scope |

Expected product behavior when requirements and API docs coexist:
- build the backbone from business context first
- use the API doc to validate feasibility and integration details
- flag mismatches explicitly when requirement intent and API contract disagree
- keep assumptions and open questions visible when the API contract leaves business behavior ambiguous

## Common Scenarios

### Greenfield Product

Start with `/ba-start` and a raw requirements document. The skill produces intake, FRD, user stories with AC, SRS with screen descriptions, and wireframes.

### Business Requirements Plus API Documentation

Start with `/ba-start` using the requirement source as the primary input and include the API doc as supporting context. BA-kit should:
- derive scope, goals, and actors from the requirement source
- use the API doc to tighten integration points, field mapping, error handling, and NFR assumptions
- keep unresolved gaps visible instead of pretending the API doc fully answers business behavior

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
