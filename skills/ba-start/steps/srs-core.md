# BA Start Step - SRS Core

This step requires:

- `core/contract.yaml`
- `core/contract-behavior.md`

## Step 8 - Produce SRS core, use cases, and Screen Contract Lite

SRS is the largest artifact. Produce only the slices justified by the selected mode and artifact gates, then keep wireframes ahead of final screen descriptions.

SRS preflight execution rules:

- Start from the exact prerequisite set only.
- Trust the accepted scope. If the user has already confirmed that SRS authoring should proceed, continue from the resolved backbone and user stories instead of reopening discovery.
- Pull in extra analysis artifacts only when the exact SRS slice needs them.
- In `lite` mode, do not run SRS unless the user explicitly asks for it.
- In `hybrid` mode, default to selective SRS coverage: complex flows, risky validations, integrations, and screens that materially affect delivery or handoff.
- In `formal` mode, emit the full SRS set.

Provide the relevant upstream context to the SRS production owner:

- matching intake summary
- backbone features, gates, and risks
- user stories with acceptance criteria
- FRD features and business rules only when FRD exists or the current mode requires it

### Group A - Core

Sections:

- Purpose and Scope
- Overall Description
- Functional Requirements table

Output: `paths.srs_group` with `group=a`

### Group B - Behavioral

Sections:

- Use Case Specifications

Output: `paths.srs_group` with `group=b`

Consistency rules:

- each use case links to user stories and screens
- actor actions use the same terminology as the user stories and FRD

### Group C - Screen Contract Lite

Sections:

- Screen Contract Lite
- Screen Inventory

Output: `paths.srs_group` with `group=c`

Consistency rules:

- each primary screen links to its use cases and user stories
- Screen Contract Lite must define screen IDs, entry and exit conditions, key actions, and required states
- modal, dialog, drawer, and overlay screens with their own interaction logic are primary screens

## Step 8.1 - Build wireframe input pack

After Group B and Group C are complete, assemble a persisted wireframe input artifact before any design work starts.

Source inputs:

- `paths.srs_group` with `group=b`
- `paths.srs_group` with `group=c`
- relevant FRD and user-story excerpts needed for traceability

Save to `paths.wireframe_input`.

The wireframe input pack must contain:

- artifact set information and app type
- target runtime design document path
- exact use case excerpts needed for each primary screen
- Screen Contract Lite
- Screen Inventory
- approved runtime design decision snapshot or explicit gaps that still require user choice
- proposed artifact grouping plan
- stop conditions for missing context or overloaded screen sets
