# Using BA-kit With Codex

## Purpose

BA-kit can work with Codex as a repo-native BA operating guide. The root [AGENTS.md](../AGENTS.md) gives Codex persistent instructions, while the `skills/`, `rules/`, and `templates/` folders provide detailed task guidance.

## What Codex Uses

- [AGENTS.md](../AGENTS.md) as the persistent repo instruction file
- `skills/` as reference playbooks for BA task types
- `rules/` as BA quality and workflow constraints
- `templates/` as deliverable structures
- `designs/` for project-specific runtime `DESIGN.md` files used to constrain manual wireframe handoff

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
- `~/.codex/templates`
- `~/.codex/ba-kit`

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
/ba-do dang lam do SRS thi them yeu cau nay
/ba-impact --slug warehouse-rfp Khong co nhom admin user
/ba-next --slug warehouse-rfp
/ba-collab Toi nhan module auth-flow
/ba-notion srs --slug warehouse-rfp --page https://www.notion.so/... --mode overwrite
```

## Recommended Codex Workflow

1. Start with the business outcome or artifact you need, not command names.
2. For freeform BA requests, use `ba-do` as the router first.
3. Tell Codex to read `PROJECT-HOME.md` when present, then use the BA playbook for the resolved step.
4. If UI is involved, point it at the relevant project `DESIGN.md` and the module `wireframe-input.md` / `wireframe-map.md` artifacts.
5. For collaboration, use `ba-collab` for module claims, review packets, conflict checks, and approval-gated GitHub handoff.
6. Use `/ba-start` for full workflow runs and the matching explicit subcommand for reruns.
7. For rerun commands, pass `--slug <slug>` when more than one project may exist.
8. If one slug has multiple dated artifact sets, Codex should stop and ask which date to use instead of silently taking the latest set.
9. When a requirement or rule changes during `frd`, `stories`, `srs`, `wireframes`, or `package`, route through `/ba-start impact --slug <slug>` before mutating downstream artifacts unless the edit is clearly wording-only.
10. If the user describes a change in natural language without naming a subcommand, infer the equivalent of `impact` when the project set already exists.
11. If the user sends only a short correction statement such as `Không có nhóm admin user`, treat it as change evidence for `impact`, not as permission to edit artifacts directly.
12. Ask for assumptions, open questions, and a draft output.
13. If you installed the Codex conversion, ask Codex to use `ba-do` from `~/.codex/skills/ba-do/SKILL.md` for freeform routing, `ba-start` from `~/.codex/skills/ba-start/SKILL.md` for explicit lifecycle execution, and the registered BA agents from `~/.codex/agents`.
14. Unless you explicitly override it, BA-kit should use Shadcn UI as the default component baseline for wireframe constraints and UI handoff.
15. Before Step 9 is run, BA-kit should ask for or confirm the design decisions needed to persist the project runtime artifact `designs/{slug}/DESIGN.md`, then use that file as the system design document.
16. Unless you explicitly override it, BA deliverables should be written in Vietnamese.
17. Treat the dated artifact-set token as `YYMMDD-HHmm` across both report filenames and `plans/{date}-{slug}/plan.md`.
18. When delegating, pass only narrow artifact slices and exact excerpts, not full upstream documents.
19. If a delegated worker reports missing context or `NEEDS_REPARTITION`, split the scope and rerun only that slice.
20. For non-trivial delegation, use the packet structure from `templates/sub-agent-handoff-template.md` or the equivalent snippet embedded in `ba-start`.
21. For `srs`, resolve the exact backbone and user-stories artifacts first and pull the FRD only when it exists or is required instead of scanning every report in `plans/reports/final/` and `plans/reports/drafts/`.
22. For `frd` and `stories`, resolve the exact backbone prerequisite first and begin authoring from that file instead of scanning every report in `plans/reports/final/`.
23. If only legacy report names like `002-intake-form.md` exist, stop and migrate or rerun them explicitly; do not infer the current slug/date from legacy filenames.
24. If context truncation happens after the target workflow was already confirmed, recover from the resolved command and exact artifacts on disk instead of asking the user to restate the task.
25. Once the user explicitly approves a mutating rerun step, keep that step locked for the current run and do not fall back to generic "what do you want me to do with this document?" prompts.
25. For non-trivial delegated work, create a dedicated tracker under `plans/{date}-{slug}/delegation/` and pass its path into the worker packet.
26. Treat a delegated slice as likely stalled when its tracker has no heartbeat for more than 10 minutes and the target artifact has not advanced.

Global command helpers after Codex install:
- `ba-do` — preferred freeform router for BA requests
- `ba-impact` — run change-impact triage without mutating artifacts
- `ba-next` — inspect the current artifact set and recommend the next BA command

## Prompt Patterns

### Full BA Engagement

```text
Use the installed `ba-do` skill from ~/.codex/skills/ba-do/SKILL.md.
Route this BA request to the correct BA-kit command and then follow that workflow:
"Parse the requirements in docs/raw/warehouse-rfp.pdf.
Default to `hybrid` mode for a solo IT BA.
Build the requirements backbone first, then emit FRD, user stories, use case specifications, Screen Contract Plus, manual wireframe handoff artifacts, final screen descriptions, and FRD/SRS HTML only when each artifact is justified.
If wireframe support is needed, ask me for design decisions and persist `designs/{slug}/DESIGN.md` before Step 9."
```

### Step-Level Rerun

```text
Use AGENTS.md and skills/ba-start/SKILL.md.
Run the equivalent of `/ba-start wireframes --slug warehouse-rfp`.
Use the existing Screen Contract Plus artifacts only.
Reuse the existing `designs/{slug}/DESIGN.md` if it is approved, otherwise ask to refresh it before preparing the manual wireframe handoff pack.
If more than one dated set exists for `warehouse-rfp`, stop and ask me which date to use.
Do not regenerate intake, FRD, or user stories.
```

### Change Impact Triage

```text
Use AGENTS.md and skills/ba-start/SKILL.md.
I am midway through the SRS for slug warehouse-rfp and this new requirement arrived:
"Every export must require explicit permission, write an audit log, and display a success or failure banner."
Run the equivalent of `/ba-start impact --slug warehouse-rfp`.
Resolve the exact dated set instead of choosing by mtime.
Tell me the current source of truth, the affected artifacts, the unaffected artifacts, and the exact commands I should run next.
If the change is only wording-only, say so explicitly and keep the rerun path narrow.
```

### BA Router

```text
Use the installed `ba-do` skill from ~/.codex/skills/ba-do/SKILL.md.
Route this BA request to the right BA-kit command:
"Dang lam do SRS thi them yeu cau moi ve audit log."
```

### BA-Friendly Resume

```text
Use AGENTS.md.
Read PROJECT-HOME.md for slug warehouse-rfp if it exists.
Tell me the next step in BA-friendly Vietnamese first.
Then show the internal BA-kit command equivalent and run it only if safe.
```

### BA Collaboration

```text
Use AGENTS.md and skills/ba-collab/SKILL.md.
I claim module auth-flow.
Create or update the collaboration artifacts, but do not commit, push, create PR, or merge without my explicit approval.
```

### BA Next

```text
Use the installed `ba-next` skill from ~/.codex/skills/ba-next/SKILL.md.
Inspect the current BA artifact set and tell me the next exact command to run.
Do not mutate any artifact.
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
Produce an intake form, requirements backbone, gated FRD/stories/SRS artifacts, project runtime `DESIGN.md`, manual wireframe handoff artifacts when justified, final screen descriptions, and the FRD/SRS HTML deliverables required by the selected mode.
```

### Formal Requirements Only

```text
Use AGENTS.md and skills/ba-start/SKILL.md.
Draft an SRS from templates/srs-template.md.
Include use cases, screen descriptions, and linked requirements.
Make room for user-supplied wireframe references under each screen section instead of assuming BA-kit-generated mockups.
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

## Wireframe Handoff For Codex

Use the default BA-kit flow for manual wireframe handoff in SRS-backed work:
- persist or reuse `designs/{slug}/DESIGN.md` before preparing wireframe handoff artifacts
- build or refresh `wireframe-input.md` and `wireframe-map.md`
- keep screen IDs aligned across the SRS and the handoff artifacts
- let the user create the actual wireframe externally and manually attach the result into the SRS

## HTML Deliverable

The generated HTML set uses one shared BA-kit document shell. Open the packaged artifacts in a browser to update text, replace images, and add or remove blocks without editing the source HTML manually. SRS HTML remains the primary stakeholder handoff, while FRD HTML provides the aligned functional review copy. The `package` step should stay narrow by default: validate any existing packaged HTML artifacts, then regenerate FRD and SRS HTML only when those markdown artifacts exist.

If the user manually inserts wireframe images or links into the markdown source, the packaged HTML preserves those references. Mermaid diagrams are bootstrapped explicitly after `DOMContentLoaded` so browser-opened stakeholder copies render them more reliably.

`/ba-start status` should report wireframe handoff using the explicit state marker: `completed`, `skipped`, `not-applicable`, or `missing`, plus the persisted wireframe input pack and wireframe map when they exist. It should also surface delegated slice trackers and flag likely stalls from stale heartbeats.

## Good Outcomes

You are set up correctly when Codex can:
- follow `AGENTS.md` without extra repo explanation
- use `PROJECT-HOME.md` as a BA-facing resume dashboard without treating it as source of truth
- use `COLLAB-HOME.md`, `MODULE-HOME.md`, and review packets for BA collaboration without exposing Git first
- read the BA playbook from `skills/ba-start/SKILL.md`
- draft a structured artifact from `templates/`
- reference manual wireframe handoff artifacts and user-supplied mockups consistently from the SRS
