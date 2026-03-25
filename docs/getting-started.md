# BA-kit Getting Started

## Purpose

This guide shows how to install BA-kit and use it in Claude Code and Codex.

## 1. Clone The Repository

```bash
git clone https://github.com/anhdam2/bakit.git
cd bakit
```

## 2. Choose Your Runtime

BA-kit supports two usage modes:
- **Claude Code**: install BA-kit assets into `~/.claude`
- **Codex**: open the repo and use the root `AGENTS.md`

## 3. Install For Claude Code

Run:

```bash
./install.sh
```

What this installs:
- skills to `~/.claude/skills/`
- agents to `~/.claude/agents/`
- rules to `~/.claude/rules/ba-kit/`
- templates to `~/.claude/templates/`

Then restart Claude Code if it is already open.

## 4. Use BA-kit In Claude Code

The single entry point is:

```text
/ba-start
```

This command handles the full BA lifecycle:
1. Parse raw input into an intake form
2. Gap analysis and clarifying questions
3. Work plan generation
4. FRD production
5. User story generation (stories + AC become input for SRS)
6. SRS production (parallel delegation, driven by user stories)
7. Wireframe generation for SRS screens
8. Quality review and packaging

### Claude Example

```text
/ba-start
Here is our requirements doc: docs/raw/warehouse-rfp.pdf
```

When prompted, provide the file path or paste your requirements text. The skill will:
1. Parse and normalize the input into a structured intake form
2. Identify gaps (missing stakeholders, unclear scope, no success criteria)
3. Ask 3-8 clarifying questions
4. Generate a scoped work plan
5. Produce FRD, user stories, SRS, and wireframes

## 5. Use BA-kit In Codex

Codex does not need `install.sh`.

Instead:
1. Open this repository in Codex
2. Make sure the root `AGENTS.md` is visible in the repo
3. Tell Codex to use `skills/ba-start/SKILL.md` as the playbook
4. Point Codex to the correct template under `templates/`

### Codex Example

```text
Use AGENTS.md and skills/ba-start/SKILL.md.
Parse the requirements in docs/raw/warehouse-rfp.pdf.
Produce an intake form, FRD, user stories, SRS, and wireframes.
Include use cases, screen descriptions, linked requirements, and test cases.
Reference Pencil artifacts under designs/customer-portal/ and map each SRS screen to its target frame.
```

See [codex-setup.md](./codex-setup.md) for more prompt patterns.

## 6. Add Pencil Wireframes For SRS Work

Use Pencil only for wireframes in BA-kit.

Store `.pen` files under:

```text
designs/[initiative-slug]/
```

Example:

```text
designs/customer-portal/auth-flow.pen
designs/customer-portal/dashboard-core.pen
designs/customer-portal/exports/auth-flow/SCR-01-login.png
designs/customer-portal/exports/dashboard-core/SCR-02-dashboard.png
```

Rules:
- a single `.pen` file may contain multiple frames
- keep screen IDs aligned between the SRS and Pencil frame names
- link each SRS screen to both the `.pen` artifact and the specific frame it uses
- use the `.pen` file as the wireframe source of truth
- keep the SRS focused on behavior, validation, states, navigation, and traceability

## 7. Deliverables

A full `/ba-start` engagement produces:

| Deliverable | Template | Location |
| --- | --- | --- |
| Intake form | `intake-form-template.md` | `plans/reports/intake-{slug}-{date}.md` |
| FRD | `frd-template.md` | `plans/reports/frd-{date}-{slug}.md` |
| SRS | `srs-template.md` | `plans/reports/srs-{date}-{slug}.md` |
| User stories | `user-story-template.md` | `plans/reports/user-stories-{date}-{slug}.md` |
| Wireframes | Pencil MCP | `designs/{slug}/{artifact-name}.pen` plus `designs/{slug}/exports/{artifact-name}/SCR-xx-{name}.png` |

## 8. Know Where To Look

- Runtime instructions for Codex: [AGENTS.md](../AGENTS.md)
- Claude-oriented project instructions: [CLAUDE.md](../CLAUDE.md)
- Codex-specific setup notes: [codex-setup.md](./codex-setup.md)
- Skill catalog: [skill-catalog.md](./skill-catalog.md)
- Methodology guide: [ba-methodology-guide.md](./ba-methodology-guide.md)
- Pencil naming convention: [designs/README.md](../designs/README.md)

## 9. Practical Tips

- Start with `/ba-start` and let the skill guide you through the lifecycle
- Always provide raw input (file or text) when starting an engagement
- For UI scope, provide the `.pen` artifact path and target frames explicitly, or let the skill generate and map them
- Ask for assumptions and open questions before asking for finalization
- Use Mermaid diagrams for process or data views
