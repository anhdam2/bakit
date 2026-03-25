# BA Quality Standards

All BA-kit artifacts must satisfy these standards before they are considered complete.

Related rules:
- [BA Workflow](./ba-workflow.md)

## Requirements
- Every requirement has a clear source, business rationale, and owner.
- Every requirement has acceptance criteria or validation guidance.
- Every requirement is unambiguous, testable, and prioritized.
- Requirements use one intent per statement and no bundled behaviors.

## Stories and Acceptance Criteria
- User stories follow the `As a / I want / so that` structure when Agile is used.
- Acceptance criteria are specific enough to verify without interpretation.
- Boundary conditions and failure cases are captured where relevant.

## Traceability
- Business goals map to requirements.
- Requirements map to downstream artifacts, controls, or test cases.
- Cross-references are explicit and easy to follow.

## Cross-Artifact Consistency
- Use cases, screen descriptions, and wireframes must describe the **same** behavior using **identical** terminology.
- UC actor actions must match screen User Actions — same wording, same sequence.
- UC system responses must match screen field Behaviour Rules.
- UC alternate flows must be reflected in screen Error/States.
- Field names must be identical across UC steps, screen field tables, and wireframe labels.
- Each SRS screen must reference the correct Pencil artifact and the exact frame representing that screen.
- User story acceptance criteria must be covered by UC postconditions and screen Validation Rules.
- FRD features must be fully traceable through user stories into SRS requirements.
- When inconsistency is found, the upstream artifact (user story > use case > screen > wireframe) is the source of truth.

## Quality Checks
- SMART: specific, measurable, achievable, relevant, time-bound.
- INVEST for user stories where applicable.
- No contradictions across scope, process, and documentation.
- No orphaned requirements without a business justification.

## Review Checklist
- Is the artifact complete for its intended purpose?
- Is the language clear and jargon controlled?
- Are dependencies and assumptions visible?
- Are risks, edge cases, and constraints stated?
- Are the links to related artifacts current?
