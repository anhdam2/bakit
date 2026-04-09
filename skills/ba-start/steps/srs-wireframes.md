# BA Start Step - SRS Wireframes

This step requires:

- `core/contract.yaml`
- `core/contract-behavior.md`

## Step 8.2 - Capture design decisions and persist runtime DESIGN.md

Before any AI agent generates wireframes, ask the user to make or approve the design decisions that define the project-specific runtime `DESIGN.md`.

Decision intake must cover:

- reference direction: existing brand guidance, a custom brief, or a named external inspiration
- visual tone and density
- color direction and contrast expectations
- typography direction
- component feel
- layout and responsive priority
- hard constraints and explicit anti-patterns

If `paths.design_doc` already exists, ask whether to:

- reuse the approved file as-is
- refresh it from new decisions
- stop

If no file exists, or the user asks to refresh it:

- synthesize `paths.design_doc` from the approved decisions using [../../../templates/design-md-template.md](../../../templates/design-md-template.md)
- keep `defaults.ui_baseline` as the fallback component baseline only when the approved design document does not specify a different direction
- stop before Step 9 if design decisions remain unresolved

## Group D - Technical

Sections:

- Non-functional requirements
- Data flow diagrams
- ERD
- API specifications
- Constraints

Output: `paths.srs_group` with `group=d`

Technical slice gate:

- produce Group D only when integrations, NFR exposure, data modelling, API handoff, or vendor/governance needs justify it

## Step 9 - Generate wireframes

Run the standalone wireframe workflow from [wireframes.md](./wireframes.md), but keep the same slug, date, and module.

Mode defaults inside the SRS pipeline:

- `lite`: skip wireframes unless the user explicitly asks for them
- `hybrid`: generate critical-screen wireframes first
- `formal`: generate the full approved screen set

## Step 10 - Produce final screen descriptions

After Step 9 resolves, expand final screen descriptions from:

- Use Case Specifications
- Screen Contract Lite
- `paths.wireframe_map` when wireframe state is `completed`
- supporting frame inventory

If wireframes are `skipped` or `not-applicable`, expand screen descriptions from use cases and Screen Contract Lite only, and keep Pencil references absent.

If wireframe state is `completed` but `paths.wireframe_map` is missing, stop and rerun `wireframes` before expanding final screen descriptions.

Output: `paths.srs_group` with `group=e`

Screen field table format:

| Tên trường (Field Name) | Loại trường (Field Type) | Mô tả (Description) |
| --- | --- | --- |
| [Field] | [Type] | **Display Rules:** [visibility, defaults, read-only conditions, formatting] |
| | | **Behaviour Rules:** [on-change actions, auto-fill, cascading, navigation triggers] |
| | | **Validation Rules:** [required, format, range, cross-field, error message triggers] |
| | | **Rule Codes:** [CR-DIS-01, CR-VAL-01, v.v.] |
| | | **Message Codes:** [MSG-ERR-01, MSG-SUC-01, v.v.] |
