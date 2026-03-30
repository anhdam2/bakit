# BA-kit

BA-kit is a business analysis toolkit for agentic coding environments. It packages a single end-to-end BA skill, focused agent roles, workflow rules, and reusable templates so discovery, requirements, and handoff work follow a consistent operating model in Claude Code and Codex.

## What It Includes

- 1 unified BA skill (`ba-start`) covering the full intake-to-deliverable lifecycle with resumable subcommands
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
- Node.js if you want to run `scripts/install-codex-ba-kit.sh`

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

Codex does not require `./install.sh` or installation into `~/.claude`. Open the repository with `AGENTS.md` present, then explicitly direct Codex to use the relevant BA playbook from `skills/`. The root `AGENTS.md` now carries the minimum non-negotiable BA defaults, but `skills/ba-start/SKILL.md` is still the required workflow source for non-trivial BA tasks.

If you are using the Codex-converted bundle, install it into the local Codex runtime with:

```bash
bash scripts/install-codex-ba-kit.sh
```

That script copies the converted assets from `codex/skills/**` and `codex/agents/**` into `~/.codex/skills` and `~/.codex/agents`, then appends any missing agent registrations into `~/.codex/config.toml` without duplicating existing entries.

See [docs/codex-setup.md](./docs/codex-setup.md) for prompt patterns and setup guidance.

Core defaults across Claude Code and Codex:
- BA deliverables are written in Vietnamese by default unless the user explicitly requests English.
- The dated artifact-set token uses `YYMMDD-HHmm` consistently across `plans/reports/*` and `plans/{date}-{slug}/plan.md`.
- When UI scope exists, wireframes default to Shadcn UI unless the user explicitly overrides it.

`plans/` is a local BA workspace, not shipped example content. Keep generated `plans/reports/*` artifacts and `plans/{date}-{slug}/plan.md` local to your engagement and out of version control.

## Quick Start

Full workflow:

```text
/ba-start
```

Resumable subcommands:

```text
/ba-start intake docs/raw/warehouse-rfp.pdf
/ba-start frd --slug warehouse-rfp
/ba-start stories --slug warehouse-rfp
/ba-start srs --slug warehouse-rfp
/ba-start wireframes --slug warehouse-rfp
/ba-start package --slug warehouse-rfp
/ba-start status --slug warehouse-rfp
```

Default `/ba-start` still runs the full lifecycle:
1. Parsing raw input into a structured intake form
2. Gap analysis and clarifying questions
3. Work plan generation
4. FRD production
5. User story generation
6. SRS production
7. Wireframe generation from use cases and screen contract
8. Final screen description production
9. Unified browser-editable HTML packaging for intake, FRD, user stories, and SRS

For rerun commands, resolution order is:
1. Explicit `--slug <slug>`
2. A single detected project in `plans/reports/`
3. Otherwise stop and ask the user to choose

If one slug has multiple dated artifact sets, `/ba-start` should stop and ask which dated set to use instead of silently taking the latest one.

## Skill

| Skill | Purpose |
| --- | --- |
| `ba-start` | Single BA entry point with full workflow plus `intake`, `frd`, `stories`, `srs`, `wireframes`, `package`, and `status` subcommands |

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

For UI-backed work, BA-kit now defaults to the Shadcn UI design system for wireframes and UI-oriented handoff unless you explicitly request another system.

BA-kit packages intake, FRD, user stories, and SRS into one shared HTML shell with consistent metadata, visual chrome, and in-browser editing controls. The SRS HTML remains the primary stakeholder handoff, while the other HTML artifacts provide aligned review copies for the same engagement.

`/ba-start status` reports regular artifacts as exists or missing with last-modified dates. Wireframes use explicit states: `completed`, `skipped`, `not-applicable`, or `missing`.

## Configuration

BA-kit uses [`.ck.json`](./.ck.json) to define project paths, plan naming, methodology defaults, and quality assertions. The default methodology is `hybrid`.

## Example Scenarios

### New Product Discovery

Use `/ba-start` with a raw requirements document to produce an intake form, FRD, user stories with AC, SRS with screen descriptions, and wireframes. Use `/ba-start status --slug <slug>` to inspect progress after an interrupted session.

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

## Compatibility And Disclaimer

BA-kit is an independent toolkit for use with Claude Code and Codex.

Claude, Claude Code, OpenAI, and Codex are trademarks or product names of their respective owners. Their use in this repository describes compatibility only and does not imply affiliation, endorsement, or sponsorship.

BA-kit provides workflow guidance, templates, and automation helpers only. It does not constitute legal, regulatory, compliance, or other professional advice. Users remain responsible for validating generated outputs before business, technical, contractual, or governance use.

## License

This project is licensed under the [MIT License](./LICENSE).
