# Software Requirements Specification

**Project:** [Project name]
**Version:** [v1.0]
**Owner:** [BA/technical owner]
**Date:** [YYYY-MM-DD]

## Purpose and Scope
State the software scope, boundaries, and intended readers.

## Overall Description
- Product perspective:
- User classes:
- Operating environment:
- Assumptions and dependencies:

## Functional Requirements
| ID | Requirement | Priority | Source | Acceptance Criteria |
| --- | --- | --- | --- | --- |
| FR-01 | [Requirement] | [Must/Should/Could] | [Source] | [AC] |

## Use Case Specifications
Document the main system interactions in actor-goal format. One row per use case, then expand critical use cases below.

| Use Case ID | Use Case Name | Primary Actor | Trigger | Precondition | Postcondition |
| --- | --- | --- | --- | --- | --- |
| UC-01 | [Use case] | [Actor] | [Trigger] | [Precondition] | [Postcondition] |

### Detailed Use Case
**Use Case ID:** [UC-01]
**Goal:** [What the actor achieves]
**Primary Actor:** [Actor]
**Supporting Actors/Systems:** [Optional]
**Preconditions:** [What must already be true]
**Postconditions:** [What is true after completion]
**Linked User Stories:** [US-001, US-002]

| Step | Actor Action | System Response |
| --- | --- | --- |
| 1 | [Actor action] | [System response] |

**Alternate Flows**
- [Variation or exception]

**Business Rules**
- [Rule reference]

**Linked Screen:** [SCR-01 — Screen Name]

**Acceptance Notes**
- [What must be validated]

> **Consistency rule:** Actor actions in this use case must match the corresponding screen's User Actions. System responses must match the screen's field Behaviour Rules. If the use case says "system validates email format", the linked screen's email field must have a matching Validation Rule.

## Screen Descriptions
Capture screen-level behavior, navigation, fields, and validation expectations for any UI-backed scope.

| Screen ID | Screen Name | Purpose | Primary User | Entry Point | Exit/Next Step |
| --- | --- | --- | --- | --- | --- |
| SCR-01 | [Screen] | [Purpose] | [User] | [How user arrives] | [Where user goes next] |

### Screen Detail
**Screen ID:** [SCR-01]
**Pencil Artifact:** `designs/[initiative-slug]/[artifact-name].pen`
**Pencil Frame:** [SCR-01 - Screen Name]
**Artifact Scope:** [Single screen / multi-screen flow / module pack]
**Layout Summary:** [Key regions, panels, or sections]
**Navigation Rules:** [Menu, breadcrumbs, modal, back/next behavior]
**Linked Use Cases:** [UC-01, UC-02]
**Linked User Stories:** [US-001, US-002]

> **Consistency rule:** This screen must implement the exact interactions described in its linked use cases. Field names, action labels, and flow sequences must match between UC steps and screen fields/actions. The referenced Pencil frame inside the artifact must reflect this screen's field table and layout.

## Wireframe / Mockup Reference
- Pencil file: `designs/[initiative-slug]/[artifact-name].pen`
- Target frame: [SCR-01 - Screen Name]
- Exported image: `designs/[initiative-slug]/exports/[artifact-name]/SCR-01-[screen-name].png`
- Covered screen IDs in artifact: [SCR-01, SCR-02]
- Last updated: [YYYY-MM-DD]

> A single `.pen` artifact may contain multiple frames. Each SRS screen must point to the exact frame that represents it.

> In the final HTML export, the PNG image below is embedded inline automatically.

![SCR-01 Wireframe](designs/[initiative-slug]/exports/[artifact-name]/SCR-01-[screen-name].png)

## Wireframe Intent
Explain what the wireframe is optimizing for, such as data entry speed, guided completion, review-before-submit, or dashboard scanning.

## Screen Regions
| Region | Purpose | Contents |
| --- | --- | --- |
| Header | [Purpose] | [Title, breadcrumb, status] |
| Main Content | [Purpose] | [Form, table, detail panel] |
| Action Area | [Purpose] | [Primary and secondary actions] |

## Low-Fidelity Wireframe
Use the referenced frame inside the Pencil `.pen` artifact as the primary wireframe. Add a lightweight text sketch here only when it improves clarity for reviewers who are reading the markdown alone.

```text
+--------------------------------------------------+
| Header: Title / Breadcrumb / Status              |
+----------------------+---------------------------+
| Left Panel           | Main Content              |
| Navigation / Filters | Form fields / table       |
|                      |                           |
|                      | [Primary CTA] [Cancel]    |
+----------------------+---------------------------+
| Footer / Help / Audit Info                       |
+--------------------------------------------------+
```

| Field Name | Field Type | Description |
| --- | --- | --- |
| [Field name] | [Text / Dropdown / Date Picker / Checkbox / Button / Table / etc.] | **Display:** [Display rules — visibility, default value, read-only conditions, formatting] |
| | | **Behaviour:** [Behaviour rules — on-change actions, auto-fill, cascading, navigation triggers] |
| | | **Validation:** [Validation rules — required, format, range, cross-field, error messages] |

**User Actions**
- [Primary action and its behavior]
- [Secondary action and its behavior]

**States**
- Loading: [Expected UI state]
- Empty: [Expected UI state]
- Success: [Expected UI state]
- Error: [Expected UI state]
- Disabled/Read-only: [Expected UI state]

**Permission and Visibility Rules**
- [Which roles can view or act on which controls]

**Linked User Stories / Use Cases / Requirements**
- User stories: [US-001, US-002]
- Use cases: [UC-01, UC-02]
- Requirements: [FR-01, FR-02, BR-01]

## Non-Functional Requirements
| ID | Category | Requirement | Target |
| --- | --- | --- | --- |
| NFR-01 | Performance | [Requirement] | [Target] |

## Data Flow Diagrams
```mermaid
flowchart LR
  U[User] --> S[System]
  S --> D[(Data Store)]
  D --> S
```

## Entity Relationship Diagram
```mermaid
erDiagram
  ENTITY_ONE ||--o{ ENTITY_TWO : relates_to
  ENTITY_ONE {
    string id
    string name
  }
```

## API Specifications
- Endpoint:
- Method:
- Request schema:
- Response schema:
- Error handling:

## Constraints
- Technical constraints:
- Regulatory constraints:
- Operational constraints:

## Test Cases
| ID | Scenario | Expected Result | Priority |
| --- | --- | --- | --- |
| TC-01 | [Scenario] | [Expected result] | [Priority] |

## Glossary
| Term | Definition |
| --- | --- |
| [Term] | [Definition] |

## Related Templates
- [FRD Template](./frd-template.md)
- [User Story Template](./user-story-template.md)
- [Intake Form Template](./intake-form-template.md)
