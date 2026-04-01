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
It also refreshes the shared `ba-kit` update command in `~/.local/bin/ba-kit` and records the source repo for future one-command updates.

Prerequisite:
- `node` must be available because the installer uses a small Node.js registration step.

After installation, update BA-kit with:

```bash
ba-kit doctor
ba-kit update
ba-kit status --slug warehouse-rfp
```

`ba-kit doctor` and `ba-kit status` also surface update availability when the registered upstream branch is ahead of the local install.

Or ask Codex to run:

```text
/ba-kit-update
/ba-notion srs --slug warehouse-rfp --page https://www.notion.so/... --mode overwrite
```

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
16. For `srs`, resolve the exact backbone and user-stories artifacts first and pull the FRD only when it exists or is required instead of scanning every report in `plans/reports/final/` and `plans/reports/drafts/`.
17. For `frd` and `stories`, resolve the exact backbone prerequisite first and begin authoring from that file instead of scanning every report in `plans/reports/final/`.
18. If only legacy report names like `002-intake-form.md` exist, stop and migrate or rerun them explicitly; do not infer the current slug/date from legacy filenames.
19. If context truncation happens after the target workflow was already confirmed, recover from the resolved command and exact artifacts on disk instead of asking the user to restate the original task.
20. Once the user explicitly approves a mutating rerun step, keep that step locked for the current run and do not fall back to generic "what do you want me to do with this document?" prompts.
21. For non-trivial delegated work, create a dedicated tracker under `plans/{date}-{slug}/delegation/` and pass its path into the worker packet.
22. Treat a delegated slice as likely stalled when its tracker has no heartbeat for more than 10 minutes and the target artifact has not advanced.

## Prompt Patterns

### Full BA Engagement

```text
Use AGENTS.md and skills/ba-start/SKILL.md.
Parse the requirements in docs/raw/warehouse-rfp.pdf.
Default to `hybrid` mode for a solo IT BA.
Build the requirements backbone first, then emit FRD, user stories, use case specifications, Screen Contract Lite, wireframes, final screen descriptions, and FRD/SRS HTML only when each artifact is justified.
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
Keep the package scope narrow: regenerate final FRD and SRS HTML when those markdown artifacts exist, unless I explicitly ask for a broader HTML repack.
```

### Status Check

```text
Use AGENTS.md and skills/ba-start/SKILL.md.
Run the equivalent of `/ba-start status --slug warehouse-rfp`.
Print artifact names, exists or missing status, last-modified dates, the persisted backbone, the explicit wireframe state, and any persisted wireframe input/map artifacts when present.
Also print any delegation trackers under `plans/{date}-{slug}/delegation/`, including `running`, `blocked`, `needs-repartition`, or likely stalled slices.
```

### Publish To Notion

```text
Use AGENTS.md and skills/ba-notion/SKILL.md.
Publish the exact `srs` artifact for slug warehouse-rfp to Notion.
If I provided a page URL, update that page.
If I provided only a parent page, create a new child page.
Choose `overwrite`, `append`, or `fill-gaps` based on my request.
Do not silently choose a slug or dated set by mtime.
```

### Codex Conversion

```text
Use the installed ba-start skill from ~/.codex/skills/ba-start/SKILL.md.
Use the registered Codex BA agents from ~/.codex/agents when the skill delegates work.
Parse the requirements in docs/raw/warehouse-rfp.pdf.
Produce an intake form, requirements backbone, gated FRD/stories/SRS artifacts, wireframes when justified, final screen descriptions, and the FRD/SRS HTML deliverables required by the selected mode.
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

The generated HTML set uses one shared BA-kit document shell. Open the packaged artifacts in a browser to update text, replace images, and add or remove blocks without editing the source HTML manually. SRS HTML remains the primary stakeholder handoff, while FRD HTML provides the aligned functional review copy. The `package` step should stay narrow by default: validate any existing packaged HTML artifacts, then regenerate FRD and SRS HTML only when those markdown artifacts exist.

Wireframe images are constrained to a fit-to-document viewport by default so large screen exports remain readable inside the document, and clicking or double-clicking a wireframe opens a larger preview. Mermaid diagrams are bootstrapped explicitly after `DOMContentLoaded` so browser-opened stakeholder copies render them more reliably.

`/ba-start status` should report wireframes using the explicit state marker: `completed`, `skipped`, `not-applicable`, or `missing`, plus the persisted wireframe input pack and wireframe map when they exist. It should also surface delegated slice trackers and flag likely stalls from stale heartbeats.

## Good Outcomes

You are set up correctly when Codex can:
- follow `AGENTS.md` without extra repo explanation
- read the BA playbook from `skills/ba-start/SKILL.md`
- draft a structured artifact from `templates/`
- reference Pencil wireframes from `designs/` at both artifact and frame level
