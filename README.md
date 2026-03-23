# BA-kit

BA-kit is a business analysis toolkit for agentic coding environments. It packages BA-specific skills, agent roles, workflow rules, and reusable templates so discovery, requirements, and handoff work follow a consistent operating model in Claude Code and Codex.

## What It Includes

- 16 BA skills for discovery, requirements, process modeling, compliance, workshops, and strategy
- 6 BA agent roles for structured delegation
- 5 workflow and quality rule files
- 13 reusable document templates
- project instructions and configuration for BA engagements

Start here for practical setup and usage: [docs/getting-started.md](./docs/getting-started.md)

## Prerequisites

- Claude Code CLI
- Codex with repo-level `AGENTS.md` support
- A local Claude workspace with access to `~/.claude/`
- Bash-compatible shell for running `install.sh`

## Installation

### Claude Code Installation

1. Clone or copy this repository locally.
2. Run:

```bash
./install.sh
```

3. Restart Claude Code if it is already running.

The installer copies:
- each BA skill directory under `skills/` to `~/.claude/skills/`
- `agents/` to `~/.claude/agents/`
- `rules/` to `~/.claude/rules/ba-kit/`
- `templates/` to `~/.claude/templates/`

## Use With Codex

BA-kit supports Codex through the root [AGENTS.md](./AGENTS.md) file and repo-local playbooks:
- Codex should read [AGENTS.md](./AGENTS.md) for persistent repository instructions
- `skills/` acts as BA reference playbooks
- `rules/` and `templates/` provide workflow and artifact structure
- `designs/` stores Pencil `.pen` files for SRS screen wireframes

Codex does not require `./install.sh` or installation into `~/.claude`. Open the repository with `AGENTS.md` present, then explicitly direct Codex to use the relevant BA playbook from `skills/`.

See [docs/codex-setup.md](./docs/codex-setup.md) for prompt patterns and setup guidance.

## Quick Start

To bootstrap a BA engagement from a raw requirements file:

```text
/ba-kickoff
```

Or use the flagship discovery skill first:

```text
/ba-discovery
```

Typical follow-on flows:
- discovery to requirements: `/ba-discovery` -> `/ba-requirements`
- Agile delivery: `/ba-user-stories` -> `/ba-acceptance-criteria`
- process redesign: `/ba-process-mapping` -> `/ba-gap-analysis`
- regulated change: `/ba-compliance` -> `/ba-change-management`

## Skill Catalog

| Skill | Purpose |
| --- | --- |
| `ba-kickoff` | Parse raw requirements input and generate a scoped BA work plan |
| `ba-discovery` | Run a structured discovery engagement from scoping through recommendations |
| `ba-requirements` | Produce and validate BRD, FRD, SRS, and traceability outputs |
| `ba-user-stories` | Write Agile stories, acceptance criteria, and story maps |
| `ba-process-mapping` | Document AS-IS and TO-BE processes in Mermaid |
| `ba-stakeholder` | Build stakeholder analysis, RACI, and engagement plans |
| `ba-gap-analysis` | Identify gaps, impacts, priorities, and solution responses |
| `ba-feasibility` | Assess technical, operational, economic, schedule, and risk feasibility |
| `ba-data-modeling` | Produce ERD, DFD, data dictionary, and data governance outputs |
| `ba-compliance` | Map requirements to regulations and audit obligations |
| `ba-workshop` | Plan and run requirements or discovery workshops |
| `ba-acceptance-criteria` | Create clear, testable acceptance criteria |
| `ba-swot` | Run SWOT analysis and derive strategic options |
| `ba-cost-benefit` | Estimate costs, benefits, ROI, and payback |
| `ba-communication` | Produce communication plans, status reports, and executive summaries |
| `ba-change-management` | Assess change impact, readiness, training, and adoption |

Detailed usage guidance lives in [docs/skill-catalog.md](./docs/skill-catalog.md).

## Agent Roles

| Agent | Focus |
| --- | --- |
| `requirements-engineer` | Requirements elicitation, structuring, validation |
| `stakeholder-analyst` | Stakeholder mapping, communication, RACI |
| `process-mapper` | BPMN, swimlanes, process optimization |
| `ba-researcher` | Domain, market, and solution research |
| `compliance-auditor` | Regulatory and governance review |
| `ba-documentation-manager` | Deliverable quality, consistency, and packaging |

## Template Library

Templates live in `./templates/` and cover:
- BRD, FRD, SRS
- user stories
- RACI and stakeholder register
- process maps and gap analysis
- feasibility, SWOT, and cost/benefit adjacent planning
- communication and change impact plans

Wireframe artifacts for SRS screen sections should live under `./designs/` as Pencil `.pen` files. See [designs/README.md](./designs/README.md) for the naming convention.

## Configuration

BA-kit uses [`.ck.json`](./.ck.json) to define project paths, plan naming, methodology defaults, and quality assertions. The default methodology is `hybrid`.

## Example Scenarios

### New Product Discovery

Use `ba-discovery` to scope the initiative, identify stakeholders, capture pain points, and recommend the next artifact set.

### ERP Process Improvement

Use `ba-process-mapping`, `ba-gap-analysis`, and `ba-change-management` to document current-state operations and drive a controlled transition plan.

### Regulated Workflow Change

Use `ba-requirements`, `ba-compliance`, and `ba-acceptance-criteria` to maintain traceability from regulation to requirement to validation.

## Contributing

Keep additions aligned with BA-kit principles:
- practical over theoretical
- reusable templates over ad hoc prose
- traceability over ambiguity
- Mermaid for diagrams

When adding a skill, also update the skill catalog and any affected templates or rules. See [CONTRIBUTING.md](./CONTRIBUTING.md) for contribution expectations and validation steps.

## License

This project is licensed under the [MIT License](./LICENSE).
