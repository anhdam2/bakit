# BA-kit

BA-kit is a business analysis toolkit for agentic coding environments. It packages a single end-to-end BA skill, focused agent roles, workflow rules, and reusable templates so discovery, requirements, and handoff work follow a consistent operating model in Claude Code and Codex.

## What It Includes

- 1 unified BA skill (`ba-start`) covering the full intake-to-deliverable lifecycle
- 4 agent roles for structured delegation
- 2 workflow and quality rule files
- 4 reusable document templates
- Project instructions and configuration for BA engagements

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
- the BA skill directory under `skills/` to `~/.claude/skills/`
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

To run a full BA engagement from raw requirements:

```text
/ba-start
```

This single command handles:
1. Parsing raw input into a structured intake form
2. Gap analysis and clarifying questions
3. Work plan generation
4. FRD production
5. SRS production (parallel delegation)
6. User story generation
7. Wireframe generation for SRS screens
8. Quality review and packaging

## Skill

| Skill | Purpose |
| --- | --- |
| `ba-start` | End-to-end BA engagement: intake, FRD, user stories, SRS, wireframes, and quality review |

## Agent Roles

| Agent | Focus |
| --- | --- |
| `requirements-engineer` | Requirements elicitation, structuring, validation |
| `ui-ux-designer` | Pencil wireframe generation from SRS screens |
| `ba-documentation-manager` | Deliverable quality, consistency, and packaging |
| `ba-researcher` | Domain, market, and solution research |

## Template Library

Templates live in `./templates/` and cover:
- SRS (software requirements specification)
- FRD (functional requirements document)
- User stories
- Intake form

Wireframe artifacts for SRS screen sections live under `./designs/` as Pencil `.pen` files. See [designs/README.md](./designs/README.md) for the naming convention.

## Configuration

BA-kit uses [`.ck.json`](./.ck.json) to define project paths, plan naming, methodology defaults, and quality assertions. The default methodology is `hybrid`.

## Example Scenarios

### New Product Discovery

Use `/ba-start` with a raw requirements document to produce an intake form, FRD, user stories with AC, SRS with screen descriptions, and wireframes.

### ERP Process Improvement

Use `/ba-start` with process descriptions as input. The skill produces FRD with workflows, user stories for the delivery team, and SRS with technical specs.

### Regulated Workflow Change

Use `/ba-start` with regulatory context. The SRS captures compliance constraints, the FRD covers business rules, and user stories include acceptance criteria tied to regulations.

## Contributing

Keep additions aligned with BA-kit principles:
- practical over theoretical
- reusable templates over ad hoc prose
- traceability over ambiguity
- Mermaid for diagrams

When changing the skill, also update templates or rules if the workflow contract changes. See [CONTRIBUTING.md](./CONTRIBUTING.md) for contribution expectations and validation steps.

## License

This project is licensed under the [MIT License](./LICENSE).
