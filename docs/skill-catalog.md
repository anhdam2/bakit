# BA-kit Skill Catalog

## Purpose

This catalog explains when to use each BA-kit skill, what it produces, and which templates or agents typically support it.

## Skills

| Skill | When to Use | Related Templates | Related Agents | Typical Output |
| --- | --- | --- | --- | --- |
| `ba-kickoff` | Bootstrap a BA engagement from a raw file or pasted text | `intake-form-template.md` | All (routed per work plan) | Intake form, gap analysis, scoped work plan with skill chain |
| `ba-discovery` | Early-stage scoping or ambiguous problem spaces | `stakeholder-register-template.md`, `process-map-template.md`, `feasibility-template.md` | `stakeholder-analyst`, `ba-researcher` | Discovery report, scope framing, next-step plan |
| `ba-requirements` | Formal requirements capture and validation | `brd-template.md`, `frd-template.md`, `srs-template.md` | `requirements-engineer` | BRD, FRD, SRS, traceability view, Pencil-linked screen specs |
| `ba-user-stories` | Agile backlog shaping and story decomposition | `user-story-template.md` | `requirements-engineer` | Story map, stories, acceptance criteria |
| `ba-process-mapping` | Current-state and future-state workflow analysis | `process-map-template.md` | `process-mapper` | Mermaid swimlanes, bottlenecks, optimization options |
| `ba-stakeholder` | Stakeholder discovery and engagement planning | `stakeholder-register-template.md`, `raci-template.md`, `communication-plan-template.md` | `stakeholder-analyst` | Stakeholder register, RACI, engagement plan |
| `ba-gap-analysis` | Current-to-target gap and impact assessment | `gap-analysis-template.md`, `change-impact-template.md` | `process-mapper`, `requirements-engineer` | Gap matrix, root causes, roadmap |
| `ba-feasibility` | Evaluate viability before major investment | `feasibility-template.md` | `ba-researcher` | Go/no-go recommendation with rationale |
| `ba-data-modeling` | Clarify domain objects, flows, and data quality | `srs-template.md` | `requirements-engineer` | ERD, DFD, data dictionary |
| `ba-compliance` | Assess regulatory impact and control needs | `srs-template.md`, `change-impact-template.md` | `compliance-auditor` | Compliance map, obligations, gaps |
| `ba-workshop` | Plan or facilitate collaborative BA sessions | `communication-plan-template.md` | `stakeholder-analyst` | Agenda, facilitation plan, outputs log |
| `ba-acceptance-criteria` | Tighten requirement quality and testability | `user-story-template.md`, `frd-template.md` | `requirements-engineer` | AC set and review checklist |
| `ba-swot` | Strategic framing and option generation | `swot-template.md` | `ba-researcher` | SWOT matrix and strategy choices |
| `ba-cost-benefit` | Financial justification and comparison | `feasibility-template.md` | `ba-researcher` | ROI, payback, recommendation |
| `ba-communication` | Stakeholder updates, governance, reporting | `communication-plan-template.md` | `stakeholder-analyst`, `ba-documentation-manager` | Communication matrix, status report, executive summary |
| `ba-change-management` | Adoption planning and readiness analysis | `change-impact-template.md` | `stakeholder-analyst`, `ba-documentation-manager` | Change impact plan, readiness actions |

## Recommended Chains

### Kickoff from Raw Input

`ba-kickoff` -> `ba-discovery` -> `ba-stakeholder` -> `ba-requirements` -> `ba-process-mapping` -> `ba-compliance`

### Discovery to Formal Requirements

`ba-discovery` -> `ba-stakeholder` -> `ba-requirements` -> `ba-acceptance-criteria`

### Agile Product Framing

`ba-discovery` -> `ba-user-stories` -> `ba-acceptance-criteria` -> `ba-communication`

### Process Improvement Initiative

`ba-process-mapping` -> `ba-gap-analysis` -> `ba-feasibility` -> `ba-change-management`

### Regulated Change

`ba-requirements` -> `ba-compliance` -> `ba-acceptance-criteria` -> `ba-documentation-manager`

## Invocation Examples

```text
/ba-kickoff
/ba-discovery
/ba-requirements
/ba-process-mapping
/ba-compliance
```

## Expected Quality Bar

- outputs reference business goals
- stakeholders are named and classified
- acceptance criteria exist for requirement-level statements
- diagrams use Mermaid
- risks, assumptions, and open questions are visible
