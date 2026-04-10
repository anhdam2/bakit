# BA Start Step - SRS Core

This step requires:

- `core/contract.yaml`
- `core/contract-behavior.md`

## Step 8 - Produce SRS core, use cases, and Screen Contract Plus

SRS is the largest artifact. Produce only the slices justified by the selected mode and artifact gates, then prepare the manual wireframe handoff pack before final screen descriptions when UI-backed scope needs design constraints.

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

### Group C - Screen Contract Plus

Sections:

- Screen Contract Plus
- Screen Inventory

Output: `paths.srs_group` with `group=c`

Consistency rules:

- each primary screen links to its use cases and user stories
- Screen Contract Plus must define:
  - screen IDs and classification
  - `Portal ID`
  - `Access Role / Actor`
  - `Nav Schema ID`
  - `Expected Active Menu Item`
  - `Navigation Region Visible`
  - `Breadcrumb / Back Behavior`
  - `Global vs Local Navigation`
  - entry and exit conditions
  - key actions
  - required states
- every screen in the same `Portal ID` must reuse the same `Nav Schema ID` unless an exception is declared explicitly
- `Expected Active Menu Item` must map to an item defined in the portal navigation schema snapshot
- overlay screens inherit the parent portal unless an explicit cross-portal transition is documented
- if a modal, drawer, or dialog hides global navigation, `Navigation Region Visible` must be `No` and the exception reason must be stated
- modal, dialog, drawer, and overlay screens with their own interaction logic are primary screens

## Step 8.1 - Build wireframe constraint pack

After Group B and Group C are complete, assemble a persisted wireframe constraint artifact before any manual design work starts.

Source inputs:

- `paths.srs_group` with `group=b`
- `paths.srs_group` with `group=c`
- relevant portal snapshot from `paths.backbone`
- relevant FRD and user-story excerpts needed for traceability

Save to `paths.wireframe_input`.

The wireframe constraint pack must contain:

- artifact set information and app type
- target runtime design document path
- exact use case excerpts needed for each primary screen
- Screen Contract Plus
- Screen Inventory
- portal snapshot for each screen group
- navigation schema snapshot or explicit missing-design gap that blocks Step 9
- menu matching checklist and active-menu evidence requirements
- navigation exceptions for overlays, deep links, wizard steps, and hidden-nav states
- full manual-design constraints: navigation, required states, validation cues, supporting states, and non-negotiable labels or actions
- approved runtime design decision snapshot or explicit gaps that still require user choice
- proposed artifact grouping and handoff plan
- stop conditions for missing context or overloaded screen sets
