# BA-kit Project Overview

## Summary

BA-kit is a reusable toolkit that equips Claude Code and Codex for professional business analysis work. It standardizes the full BA lifecycle from raw input to packaged deliverables through a single unified skill, focused agent roles, reusable templates, and workflow rules.

## Problem Statement

Agent coding environments are usually optimized for software implementation. Business analysis work needs different defaults:
- structured elicitation and intake normalization
- formal and Agile requirement artifacts (FRD, user stories, SRS)
- traceability from business goals to test cases
- reusable templates for recurring deliverables
- wireframe generation for UI-backed scope

BA-kit closes that gap with a BA-first operating model.

## Objectives

- Make BA workflows repeatable across projects
- Reduce time spent rebuilding templates and checklists
- Improve consistency of requirement quality and acceptance criteria
- Support Agile, Traditional, and Hybrid delivery styles
- Keep deliverables easy to hand off to product, engineering, and operations teams

## Core Components

| Component | Purpose |
| --- | --- |
| `skills/ba-start/` | Single unified BA skill covering intake through packaging |
| `agents/` | 4 specialized delegation roles for parallel execution |
| `rules/` | Workflow and quality standards |
| `templates/` | 4 ready-to-fill BA deliverable structures |
| `designs/` | Pencil wireframe artifacts for SRS screens |
| `AGENTS.md` | Persistent Codex repository instructions |
| `CLAUDE.md` | Claude Code project instructions |

## Product Scope

### In Scope

- Intake normalization and gap analysis
- Requirements engineering (FRD, SRS)
- User story generation
- Wireframe generation for SRS screens
- Quality review and packaging
- Template-driven documentation

### Out of Scope

- Full project management automation
- Domain-specific regulatory logic beyond starter guidance
- Code generation for implementation teams
- Diagram rendering beyond Mermaid syntax

## Target Users

- Business analysts
- Product managers doing BA work
- Consulting teams running discovery engagements
- Solution analysts supporting implementation squads

## Success Metrics

- Users can start with `/ba-start` and receive a complete BA workflow
- Every requirement has acceptance criteria
- Installation takes less than five minutes
- Codex can use the repo immediately through `AGENTS.md`

## Design Decisions

1. BA-kit uses a single unified skill instead of 16 separate skills.
2. Four focused agent roles handle delegation without overlap.
3. Templates are first-class assets because BA deliverables are repeatable.
4. Mermaid is the standard diagram syntax for portability in markdown.
5. Hybrid methodology is the default.
6. SRS is included by default when UI screens or system interactions are present.

## Acceptance Criteria

- Project structure exists and installs cleanly
- Skill, agents, rules, and templates are internally consistent
- Cross-references between files are valid
- Core BA outputs can be generated from templates without rework
