# Using BA-kit With Codex

## Purpose

BA-kit can work with Codex as a repo-native BA operating guide. The root [AGENTS.md](../AGENTS.md) gives Codex persistent instructions, while the `skills/`, `rules/`, and `templates/` folders provide detailed task guidance.

## What Codex Uses

- [AGENTS.md](../AGENTS.md) as the persistent repo instruction file
- `skills/` as reference playbooks for BA task types
- `rules/` as BA quality and workflow constraints
- `templates/` as deliverable structures
- `designs/` for Pencil wireframe artifacts referenced by SRS screen sections

## Codex Conversion Install

If you have the Codex-converted bundle for `ba-start`, install it from the repository root with:

```bash
bash scripts/install-codex-ba-kit.sh
```

The installer expects the converted source tree under:

- `codex/skills/**`
- `codex/agents/**`

It copies those files into:

- `~/.codex/skills`
- `~/.codex/agents`

It also appends any missing Codex agent registrations into `~/.codex/config.toml` in an idempotent way, so rerunning the script is safe.

Prerequisite:
- `node` must be available because the installer uses a small Node.js registration step.

## Recommended Codex Workflow

1. Start with the business outcome or artifact you need.
2. Tell Codex to use the BA playbook.
3. Point it at the target template.
4. If UI is involved, point it at the relevant Pencil `.pen` artifacts and frame mappings in `designs/`.
5. Use `/ba-start` for full workflow runs and the matching subcommand for reruns.
6. For rerun commands, pass `--slug <slug>` when more than one project may exist.
7. If one slug has multiple dated artifact sets, Codex should stop and ask which date to use instead of silently taking the latest set.
8. Ask for assumptions, open questions, and a draft output.
9. If you installed the Codex conversion, ask Codex to use `ba-start` from `~/.codex/skills/ba-start/SKILL.md` and the registered BA agents from `~/.codex/agents`.
10. Unless you explicitly override it, BA-kit should use Shadcn UI as the default design system for wireframes and UI handoff.
11. Unless you explicitly override it, BA deliverables should be written in Vietnamese.
12. Treat the dated artifact-set token as `YYMMDD-HHmm` across both report filenames and `plans/{date}-{slug}/plan.md`.
13. When delegating, pass only narrow artifact slices and exact excerpts, not full upstream documents.
14. If a delegated worker reports missing context or `NEEDS_REPARTITION`, split the scope and rerun only that slice.
15. For non-trivial delegation, use the packet structure from `templates/sub-agent-handoff-template.md` or the equivalent snippet embedded in `ba-start`.

## Prompt Patterns

### Full BA Engagement

```text
Use AGENTS.md and skills/ba-start/SKILL.md.
Parse the requirements in docs/raw/warehouse-rfp.pdf.
Produce an intake form, FRD, user stories, use case specifications, Screen Contract Lite, wireframes, final screen descriptions, and a browser-editable HTML SRS.
```

### Step-Level Rerun

```text
Use AGENTS.md and skills/ba-start/SKILL.md.
Run the equivalent of `/ba-start wireframes --slug warehouse-rfp`.
Use the existing Screen Contract Lite artifacts only.
If more than one dated set exists for `warehouse-rfp`, stop and ask me which date to use.
Do not regenerate intake, FRD, or user stories.
```

### Package Only

```text
Use AGENTS.md and skills/ba-start/SKILL.md.
Run the equivalent of `/ba-start package --slug warehouse-rfp`.
If the wireframe state is `missing`, stop and tell me to rerun `wireframes`.
If the wireframe state is `completed`, `skipped`, or `not-applicable`, continue to HTML packaging.
```

### Status Check

```text
Use AGENTS.md and skills/ba-start/SKILL.md.
Run the equivalent of `/ba-start status --slug warehouse-rfp`.
Print artifact names, exists or missing status, last-modified dates, and the explicit wireframe state.
```

### Codex Conversion

```text
Use the installed ba-start skill from ~/.codex/skills/ba-start/SKILL.md.
Use the registered Codex BA agents from ~/.codex/agents when the skill delegates work.
Parse the requirements in docs/raw/warehouse-rfp.pdf.
Produce an intake form, FRD, user stories, use case specifications, Screen Contract Lite, wireframes, final screen descriptions, and a browser-editable HTML SRS.
```

### Formal Requirements Only

```text
Use AGENTS.md and skills/ba-start/SKILL.md.
Draft an SRS from templates/srs-template.md.
Include use cases, screen descriptions, and linked requirements.
Reference Pencil artifacts under designs/[initiative-slug]/ and identify the target frame for each screen.
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
The root `AGENTS.md` carries the short non-negotiable defaults, but it does not replace the detailed routing and prerequisite logic in `skills/ba-start/SKILL.md`.
For delegated BA work, resolve the workflow once in the orchestrator, then pass only the minimal handoff packet to each registered agent instead of replaying the entire playbook and merged artifact set every time.

## Pencil For Codex

Use Pencil only for wireframes in SRS-backed work:
- store `.pen` files under `designs/`
- allow one `.pen` file to contain multiple frames
- reference both the artifact path and the target frame directly from the SRS
- keep screen IDs aligned across the SRS and Pencil frame names

## HTML Deliverable

The generated HTML is the editable stakeholder deliverable. Open it in a browser to update text, replace images, and add or remove blocks without editing the source HTML manually.

`/ba-start status` should report wireframes using the explicit state marker: `completed`, `skipped`, `not-applicable`, or `missing`.

## Good Outcomes

You are set up correctly when Codex can:
- follow `AGENTS.md` without extra repo explanation
- read the BA playbook from `skills/ba-start/SKILL.md`
- draft a structured artifact from `templates/`
- reference Pencil wireframes from `designs/` at both artifact and frame level
