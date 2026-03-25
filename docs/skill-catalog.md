# BA-kit Skill Catalog

## Purpose

This catalog explains the single BA-kit skill, what it produces, and which agents support it.

## Skill

| Skill | When to Use | Related Templates | Related Agents | Typical Output |
| --- | --- | --- | --- | --- |
| `ba-start` | End-to-end BA engagement from raw input to packaged deliverables | `intake-form-template.md`, `frd-template.md`, `user-story-template.md`, `srs-template.md` | `requirements-engineer`, `ui-ux-designer`, `ba-documentation-manager`, `ba-researcher` | Intake form, FRD, user stories, SRS, wireframes, quality review |

## Workflow

`/ba-start` handles the entire lifecycle:

1. Accept raw input (file or text)
2. Parse and normalize into intake form
3. Gap analysis and clarifying questions
4. Work plan generation
5. FRD production
6. User story generation (stories + AC feed into SRS and downstream)
7. SRS production (parallel delegation across 5 groups, driven by user stories)
8. Wireframe generation for SRS screens, grouped into `.pen` artifacts with frame-level mapping
9. Quality review and packaging

## Invocation

```text
/ba-start
```

## Agent Delegation

| Agent | Role in Workflow |
| --- | --- |
| `requirements-engineer` | FRD, user stories, SRS groups A-E |
| `ui-ux-designer` | Pencil wireframe generation from SRS screens |
| `ba-documentation-manager` | Quality review, consistency, packaging |
| `ba-researcher` | Domain research when external context is needed |

## Expected Quality Bar

- Outputs reference business goals
- Every requirement has acceptance criteria
- Use cases cover primary and alternate flows
- Screen descriptions use field tables with Display/Behaviour/Validation rules
- Every SRS requirement, use case, and screen traces to user stories
- Diagrams use Mermaid
- Risks, assumptions, and open questions are visible
