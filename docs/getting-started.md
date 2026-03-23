# BA-kit Getting Started

## Purpose

This guide shows how to install BA-kit and use it step by step in:
- Claude Code
- Codex
- SRS workflows that reference Pencil wireframes

## 1. Clone The Repository

```bash
git clone https://github.com/anhdam2/bakit.git
cd bakit
```

## 2. Choose Your Runtime

BA-kit supports two usage modes:
- `Claude Code`: install BA-kit assets into `~/.claude`
- `Codex`: open the repo and use the root `AGENTS.md`

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

The simplest entry point is:

```text
/ba-discovery
```

Typical progression:
- discovery: `/ba-discovery`
- stakeholder analysis: `/ba-stakeholder`
- formal requirements: `/ba-requirements`
- Agile delivery: `/ba-user-stories`
- validation: `/ba-acceptance-criteria`

### Claude Example

```text
/ba-requirements
Create an SRS for a customer self-service portal.
Include use cases, screen descriptions, and acceptance criteria.
Reference any Pencil wireframes under designs/customer-portal/.
```

## 5. Kickoff From A File

If you already have a requirements document (PDF, markdown, image, or pasted text), use the kickoff skill to bootstrap the entire BA engagement:

```text
/ba-kickoff
```

When prompted, provide the file path or paste your requirements text. The skill will:
1. Parse and normalize the input into a structured intake form
2. Identify gaps (missing stakeholders, unclear scope, no success criteria)
3. Ask 3-8 clarifying questions
4. Generate a scoped work plan with recommended skills, templates, and agents

### Claude Example

```text
/ba-kickoff
Here is our requirements doc: docs/raw/warehouse-rfp.pdf
```

### Codex Example

```text
Use AGENTS.md and skills/ba-kickoff/SKILL.md.
Parse the requirements in docs/raw/warehouse-rfp.pdf.
Produce an intake form and a scoped BA work plan.
```

The work plan output tells you exactly which skills to run next and in what order.

## 6. Use BA-kit In Codex

Codex does not need `install.sh`.

Instead:
1. Open this repository in Codex
2. Make sure the root `AGENTS.md` is visible in the repo
3. Explicitly tell Codex which BA playbook to use from `skills/`
4. Point Codex to the correct template under `templates/`

### Codex Example

```text
Use AGENTS.md and skills/ba-requirements/SKILL.md.
Draft an SRS from templates/srs-template.md.
Include use cases, screen descriptions, linked requirements, and test cases.
Reference Pencil files under designs/customer-portal/.
```

### Codex Discovery Example

```text
Use AGENTS.md and skills/ba-discovery/SKILL.md.
Create a discovery summary for a warehouse inventory platform.
Focus on stakeholders, current-state pain points, risks, and recommended next steps.
Use templates where relevant.
```

## 7. Add Pencil Wireframes For SRS Work

Use Pencil only for wireframes in BA-kit.

Store `.pen` files under:

```text
designs/[initiative-slug]/
```

Example:

```text
designs/customer-portal/SCR-01-login.pen
designs/customer-portal/SCR-02-dashboard.pen
designs/customer-portal/auth-flow.pen
```

Rules:
- keep screen IDs aligned between the SRS and the Pencil filenames
- use the `.pen` file as the wireframe source of truth
- keep the SRS focused on behavior, validation, states, navigation, and traceability

## 8. Create A Typical BA Deliverable

### Option A: Discovery Package

Use:
- `skills/ba-discovery/SKILL.md`
- `templates/stakeholder-register-template.md`
- `templates/process-map-template.md`

Expected outputs:
- stakeholder list
- current-state process summary
- pain points
- next-step recommendation

### Option B: Full Requirements Package

Use:
- `skills/ba-requirements/SKILL.md`
- `templates/brd-template.md`
- `templates/frd-template.md`
- `templates/srs-template.md`

Expected outputs:
- prioritized requirements
- use case specifications
- screen descriptions
- linked acceptance criteria
- traceability notes

### Option C: Agile Story Package

Use:
- `skills/ba-user-stories/SKILL.md`
- `templates/user-story-template.md`

Expected outputs:
- epic and feature breakdown
- user stories
- acceptance criteria
- story-to-screen alignment notes when UI exists

## 9. Know Where To Look

- runtime instructions for Codex: [AGENTS.md](../AGENTS.md)
- Claude-oriented project instructions: [CLAUDE.md](../CLAUDE.md)
- Codex-specific setup notes: [codex-setup.md](./codex-setup.md)
- skill catalog: [skill-catalog.md](./skill-catalog.md)
- Pencil naming convention: [designs/README.md](../designs/README.md)

## 10. Practical Tips

- Start with one artifact, not the whole BA lifecycle at once
- Always tell the agent which playbook and template to use
- For UI scope, provide the `.pen` path explicitly
- Ask for assumptions and open questions before asking for finalization
- Use Mermaid diagrams for process or data views

## 11. Example End-To-End Prompt

```text
Use AGENTS.md and skills/ba-requirements/SKILL.md.
Create an SRS for a customer self-service portal from templates/srs-template.md.
Include:
- functional and non-functional requirements
- use case specifications
- screen descriptions
- linked use cases and requirements
- test cases

Reference these Pencil artifacts:
- designs/customer-portal/SCR-01-login.pen
- designs/customer-portal/SCR-02-dashboard.pen

Call out assumptions, missing inputs, and open questions at the end.
```
