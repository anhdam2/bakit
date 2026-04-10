# BA Start Step - SRS Wireframes

This step requires:

- `core/contract.yaml`
- `core/contract-behavior.md`

## Step 8.2 - Capture design decisions and persist runtime DESIGN.md

Before BA-kit prepares a wireframe handoff pack, ask the user to make or approve the design decisions that define the project-specific runtime `DESIGN.md`.

Decision intake must cover:

- reference direction: existing brand guidance, a custom brief, or a named external inspiration
- visual tone and density
- color direction and contrast expectations
- typography direction
- component feel
- layout and responsive priority
- portal navigation schema per portal
- active/selected menu rule
- breadcrumb / back behavior
- hidden or contextual navigation exceptions
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

## Step 9 - Prepare manual wireframe handoff

Run the standalone wireframe workflow from [wireframes.md](./wireframes.md), but keep the same slug, date, and module.

Mode defaults inside the SRS pipeline:

- `lite`: skip wireframe handoff unless the user explicitly asks for it
- `hybrid`: prepare critical-screen wireframe constraints first
- `formal`: prepare the full approved screen set for manual wireframe handoff

## Step 10 - Produce final screen descriptions

After Step 9 resolves, expand final screen descriptions from:

- Use Case Specifications
- Screen Contract Plus
- `paths.wireframe_input` when the manual wireframe constraint pack exists
- `paths.wireframe_map` when the manual handoff checklist exists
- supporting frame inventory

If wireframes are `skipped` or `not-applicable`, expand screen descriptions from use cases and Screen Contract Plus only.

Do not block final screen descriptions on the user having already drawn or attached a mockup. Manual wireframe insertion into the final document is an out-of-band user action.

Group E rules:

- enrich the final screen descriptions from the pre-wireframe screen spec; do not redefine portal ownership
- do not change `Nav Schema ID`, `Expected Active Menu Item`, or active/highlight behavior in Group E
- if IA or menu behavior must change, route the change back through `impact` instead of silently rewriting Group E

Output: `paths.srs_group` with `group=e`

Screen field table format:

| Tên trường (Field Name) | Loại trường (Field Type) | Mô tả (Description) |
| --- | --- | --- |
| [Field] | [Type] | **Display Rules:** [visibility, defaults, read-only conditions, formatting] |
| | | **Behaviour Rules:** [on-change actions, auto-fill, cascading, navigation triggers] |
| | | **Validation Rules:** [required, format, range, cross-field, error message triggers] |
| | | **Rule Codes:** [CR-DIS-01, CR-VAL-01, v.v.] |
| | | **Message Codes:** [MSG-ERR-01, MSG-SUC-01, v.v.] |
