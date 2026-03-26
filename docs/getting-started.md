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

The single entry point is still `/ba-start`, but it now supports resumable subcommands.

Full workflow:

```text
/ba-start
```

Step-level reruns:

```text
/ba-start intake docs/raw/warehouse-rfp.pdf
/ba-start frd --slug warehouse-rfp
/ba-start stories --slug warehouse-rfp
/ba-start srs --slug warehouse-rfp
/ba-start wireframes --slug warehouse-rfp
/ba-start package --slug warehouse-rfp
/ba-start status --slug warehouse-rfp
```

Default `/ba-start` handles the full BA lifecycle:
1. Parse raw input into an intake form
2. Gap analysis and clarifying questions
3. Work plan generation
4. FRD production
5. User story generation
6. SRS production
7. Wireframe generation from the use cases and screen contract
8. Final screen description production
9. HTML packaging for FRD and unified SRS deliverables

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
5. Produce FRD, user stories, use cases, Screen Contract Lite, wireframes, final screen descriptions, and browser-editable HTML output

For rerun commands:
- pass `--slug <slug>` when more than one project exists
- if one slug has multiple dated artifact sets, BA-kit should stop and ask which set to use
- use `/ba-start status --slug <slug>` to inspect completion before rerunning a downstream step

## 5. Use BA-kit In Codex

Codex does not need `install.sh`.

Instead:
1. Open this repository in Codex
2. Make sure the root `AGENTS.md` is visible in the repo
3. Tell Codex to use `skills/ba-start/SKILL.md` as the playbook
4. Point Codex to the correct template under `templates/`
5. If you have the Codex-converted bundle, run `bash scripts/install-codex-ba-kit.sh` once to copy the skill and agents into `~/.codex` and register Codex agents in `~/.codex/config.toml`

### Codex Example

```text
Use AGENTS.md and skills/ba-start/SKILL.md.
Parse the requirements in docs/raw/warehouse-rfp.pdf.
Include use cases, Screen Contract Lite, final screen descriptions, linked requirements, test cases, and wireframes.
Reference Pencil artifacts under designs/customer-portal/ and map each SRS screen to its target frame.
```

If the Codex conversion is installed, you can point Codex directly at the bundled skill:

```text
Use ~/.codex/skills/ba-start/SKILL.md and the registered BA agents under ~/.codex/agents.
Parse the requirements in docs/raw/warehouse-rfp.pdf.
Produce an intake form, FRD, user stories, use case specifications, Screen Contract Lite, wireframes, final screen descriptions, and a browser-editable HTML output.
```

For partial reruns in Codex, be explicit about the target slug and dated set when ambiguity exists. Example:

```text
Use AGENTS.md and skills/ba-start/SKILL.md.
Run only the wireframe rerun path for slug warehouse-rfp.
If multiple dated sets exist for that slug, stop and ask me which date to use.
Then report `/ba-start status` semantics with artifact dates and the wireframe state.
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
- use Shadcn UI as the default design system baseline unless you explicitly request another system
- keep the SRS focused on behavior, validation, states, navigation, and traceability
- treat the final HTML as the editable stakeholder copy: update text, swap images, and add or remove blocks directly in the browser without editing the source HTML

## 7. Deliverables

A full `/ba-start` engagement produces:

| Deliverable | Template | Location |
| --- | --- | --- |
| Intake form | `intake-form-template.md` | `plans/reports/intake-{slug}-{date}.md` |
| FRD | `frd-template.md` | `plans/reports/frd-{date}-{slug}.md` |
| FRD HTML | `scripts/md-to-html.py` | `plans/reports/frd-{date}-{slug}.html` with rendered Mermaid diagrams |
| SRS | `srs-template.md` | `plans/reports/srs-{date}-{slug}.md` |
| User stories | `user-story-template.md` | `plans/reports/user-stories-{date}-{slug}.md` |
| Wireframes | Pencil MCP | `designs/{slug}/{artifact-name}.pen` plus `designs/{slug}/exports/{artifact-name}/SCR-xx-{name}.png` |
| Wireframe state | BA-kit routing metadata | `plans/reports/wireframe-state-{date}-{slug}.md` |
| SRS HTML | `scripts/md-to-html.py` | `plans/reports/srs-{date}-{slug}.html` as the browser-editable stakeholder copy |

If you need a clean read-only stakeholder handoff, generate HTML with:

```bash
python scripts/md-to-html.py --no-editor plans/reports/srs-{date}-{slug}.md
```

## 8. Know Where To Look

- Runtime instructions for Codex: [AGENTS.md](../AGENTS.md)
- Claude-oriented project instructions: [CLAUDE.md](../CLAUDE.md)
- Codex-specific setup notes: [codex-setup.md](./codex-setup.md)
- Skill catalog: [skill-catalog.md](./skill-catalog.md)
- Methodology guide: [ba-methodology-guide.md](./ba-methodology-guide.md)
- Pencil naming convention: [designs/README.md](../designs/README.md)

## 9. Practical Tips

- Start with `/ba-start` and let the skill guide you through the lifecycle
- Use subcommands when a later step must be rerun without redoing intake and FRD work
- Always provide raw input (file or text) when starting an engagement
- For UI scope, provide the `.pen` artifact path and target frames explicitly, or let the skill generate and map them
- Use `--slug` for rerun commands whenever more than one project may exist
- Treat `/ba-start status` as the checkpoint view: it prints artifact dates plus wireframe state (`completed`, `skipped`, `not-applicable`, `missing`)
- Ask for assumptions and open questions before asking for finalization
- Use Mermaid diagrams for process or data views
