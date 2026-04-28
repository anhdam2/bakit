# BA Start Step - Intake

This step requires:

- `core/contract.yaml`
- `core/contract-behavior.md`

## Memory Read Scope

- **Must read:** `core/contract.yaml`, `core/contract-behavior.md`
- **May read:** `paths.project_memory` (compact summary only, when exists)
- **Must NOT read:** memory shards (`hot/`, `warm/`, `cold/`), `log.md`, `paths.memory_index`

## Scope

Run Steps 1-4 only.

## Prerequisites

- Requires raw input as a file path or pasted text.
- If no input argument is provided, prompt the user for either a file path or pasted text.
- `--slug <slug>` may override the derived project slug.

## Step 1 - Accept input

Ask the user to provide one of:

- A file path (PDF, MD, TXT, image, DOCX)
- Pasted text containing requirements or business context

File reading approach:

- PDF: prefer `ba-kit source-extract <file>` first, then read the cached summary and only the relevant chunks
- Markdown or text: read directly
- Images: use multimodal reading
- Word (`.docx`): use multimodal extraction or ask the user to export to PDF or Markdown first

If a staged source cache already exists under `plans/_source-cache/{source_hash}`, reuse it instead of re-reading the raw source.

## Step 2 - Parse and normalize

Read the source material and extract content into [../../../templates/intake-form-template.md](../../../templates/intake-form-template.md):

- Project name, date, requester
- Business context (problem, goals, stakeholders mentioned)
- Raw requirements (extracted verbatim)
- Screens or UI mentioned
- Processes or workflows mentioned
- Constraints, assumptions, compliance needs
- Open questions identified during parsing

When a staged source cache exists:

- read `summary.md` first
- open only the relevant chunk files for the current normalization pass
- avoid dumping the entire raw source into context when normalized excerpts are enough

Save to `paths.intake`.

## Step 3 - Gap analysis

Review the normalized intake against a BA completeness checklist:

- Are stakeholders identified with roles and influence?
- Is there a clear problem statement and measurable goal?
- Are scope boundaries defined (in-scope vs out-of-scope)?
- Are success criteria or KPIs stated?
- Are compliance or regulatory obligations mentioned?
- Are UI screens described enough to prepare a wireframe constraint pack?
- Are processes described enough to map?

Flag each gap explicitly.

## Step 4 - Ask clarifying questions and lock scope

Present the identified gaps to the user as 3-8 targeted questions. Focus on:

- Output language
- Missing stakeholders or decision makers
- Ambiguous scope boundaries
- Unstated success criteria
- Regulatory or compliance context
- Priority and sequencing preferences
- Engagement mode preference only when the user already knows it; otherwise default to `defaults.mode`

Incorporate the answers back into the intake form.

## Step 4.1 - Generate work plan

Produce a scoped work plan and save it to `paths.plan`.

Also create or refresh `paths.project_home` using [../../../templates/project-home-template.md](../../../templates/project-home-template.md).

Project Home rules:

- write it in Vietnamese unless the user explicitly requested English
- translate technical command names into BA-facing labels
- show the current lifecycle state, the recommended next step, and decisions the user must make
- include runtime-specific quick prompts for Claude Code, Codex, and Antigravity
- do not treat Project Home as source of truth; it is a navigation dashboard over the contract artifacts

Deliverable selection:

- Always after scope lock: requirements backbone
- Detailed functional spec needed: FRD
- Agile team needs stories: user stories
- System spec with screens, use cases, or test cases: SRS
- UI screens mentioned: prepare `DESIGN.md` plus module-level wireframe handoff artifacts

Mode defaults:

- `lite`: intake + backbone + user stories by default; emit more only on explicit request
- `hybrid`: intake + backbone + user stories, plus targeted FRD/SRS slices when risk or handoff needs justify them
- `formal`: full artifact suite
