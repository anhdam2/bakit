# Using BA-kit With Codex

## Purpose

BA-kit can work with Codex as a repo-native BA operating guide. The root [AGENTS.md](../AGENTS.md) gives Codex persistent instructions, while the `skills/`, `rules/`, and `templates/` folders provide detailed task guidance.

## What Codex Uses

- [AGENTS.md](../AGENTS.md) as the persistent repo instruction file
- `skills/` as reference playbooks for BA task types
- `rules/` as BA quality and workflow constraints
- `templates/` as deliverable structures
- `designs/` for Pencil wireframe artifacts referenced by SRS screen sections

## Recommended Codex Workflow

1. Start with the business outcome or artifact you need.
2. Tell Codex to use the BA playbook.
3. Point it at the target template.
4. If UI is involved, point it at the relevant Pencil `.pen` files in `designs/`.
5. Ask for assumptions, open questions, and a draft output.

## Prompt Patterns

### Full BA Engagement

```text
Use AGENTS.md and skills/ba-start/SKILL.md.
Parse the requirements in docs/raw/warehouse-rfp.pdf.
Produce an intake form, FRD, SRS, and user stories.
```

### Formal Requirements Only

```text
Use AGENTS.md and skills/ba-start/SKILL.md.
Draft an SRS from templates/srs-template.md.
Include use cases, screen descriptions, and linked requirements.
Reference Pencil files under designs/[initiative-slug]/.
```

### Agile Story Breakdown

```text
Use AGENTS.md and skills/ba-start/SKILL.md.
Break this feature into epics, features, and stories.
Use templates/user-story-template.md.
Keep acceptance criteria testable and align any UI stories to the SRS screens.
```

## Important Constraint

The `skills/` directory is written in Claude-style skill format. Codex should treat those files as instruction content to read and apply, not as an automatic native skill system.

That means prompts should explicitly tell Codex which playbook to consult when the task is non-trivial.

## Pencil For Codex

Use Pencil only for wireframes in SRS-backed work:
- store `.pen` files under `designs/`
- reference them directly from the SRS
- keep screen IDs aligned across the SRS and Pencil files

## Good Outcomes

You are set up correctly when Codex can:
- follow `AGENTS.md` without extra repo explanation
- read the BA playbook from `skills/ba-start/SKILL.md`
- draft a structured artifact from `templates/`
- reference Pencil wireframes from `designs/`
