# BA Start Step - Wireframes

This step requires:

- `core/contract.yaml`
- `core/contract-behavior.md`

## Scope

Run Step 9 only. This path is read-only on upstream BA artifacts and may regenerate only runtime design outputs, the project `DESIGN.md`, wireframe map, wireframe state, and design cache files under `paths.design_root`.

## Prerequisites

- Resolve slug, date, and module using the shared contract.
- Resolve the wireframe source in this order:
  1. `paths.wireframe_input`
  2. exact pair of `paths.srs_group` with `group=b` and `group=c`
  3. `paths.srs` only when Use Case Specifications, Screen Contract Lite, and Screen Inventory are already assembled there
- If source 2 or 3 is used, build or refresh `paths.wireframe_input` before generating wireframes.
- If none of the sources exist, print all expected paths and stop.

## Outputs

- `paths.design_doc`
- `paths.pen_artifact`
- `paths.png_export`
- `paths.wireframe_map`
- `paths.wireframe_state`
- `paths.stitch_state`
- `paths.design_snapshot`

## Step 9.1 - Resolve wireframe input pack

Use `paths.wireframe_input` as the primary wireframe generation source.

If the pack is missing but fallback sources exist:

- assemble the pack first from exact use case excerpts, Screen Contract Lite, and Screen Inventory
- save it before continuing

Parse the input pack to build the generation plan:

- group related screens into one or more Pencil artifacts by flow, module, or journey
- treat modal, dialog, and drawer overlays with flow impact as primary screens
- derive required supporting frames from documented states, validation rules, list behavior, and feedback surfaces
- carry forward the runtime design target `paths.design_doc`

## Step 9.2 - Ask for or refresh runtime DESIGN.md

Before wireframe generation starts:

- check whether `paths.design_doc` already exists
- if it exists, ask whether to reuse it or refresh it from new decisions
- if it does not exist, ask the user to make the design decisions needed to create it

Minimum decision set:

- reference direction or inspiration source
- visual tone
- color direction
- typography direction
- component feel
- layout/responsive priority
- explicit anti-patterns

After the user answers:

- persist or refresh `paths.design_doc`
- generate or refresh `paths.design_snapshot` with `ba-kit design-snapshot --slug <slug>`
- stop if the user declines to approve a design direction

## Step 9.3 - Wireframe preference

If Step 9 runs as part of the full lifecycle or SRS pipeline and the user did not explicitly ask to skip or manually choose screens, default to:

- `lite`: skip unless a screen is explicitly marked critical
- `hybrid`: generate critical-screen wireframes automatically
- `formal`: generate all approved wireframes automatically

If the user skips:

- persist `paths.wireframe_state` with `State: skipped`
- stop without changing upstream artifacts

If the scope has no UI-backed screens:

- persist the marker with `State: not-applicable`
- stop

If wireframes are expected but generation fails before completion:

- persist the marker with `State: missing`
- stop and report the failure

## Step 9.4 - Generate Pencil wireframes and mapping

For each approved screen group:

1. Read the linked use case excerpts, Screen Contract Lite entries, and Screen Inventory rows from the wireframe input pack.
2. Read `paths.design_doc` and prefer the compact cache at `paths.design_snapshot` when it exists.
3. Verify that the wireframe intent matches the same actions, flow steps, required states, and approved design decisions.
4. Batch 2-4 screens per generation call by flow or navigation adjacency. Do not batch an entire project in one call.
5. Use `defaults.ui_baseline` only when the design document does not override it.
6. Create or update one `.pen` artifact per approved screen group.
7. Create one frame per primary screen and one frame per required supporting state or view.
8. Validate screenshots against the use cases, Screen Contract Lite, and approved design document.
9. Record screen-to-artifact-to-frame mapping for every generated artifact.
10. Save each artifact to `paths.pen_artifact`.

When a Stitch-backed run is used:

- initialize the cache with `ba-kit stitch-state init --slug <slug>`
- persist screen-level status after each batch with `ba-kit stitch-state upsert ...`
- use `ba-kit stitch-state show --slug <slug>` to inspect current cache state instead of re-querying the full remote project when local state is sufficient

## Step 9.5 - Export wireframes to PNG

Export each relevant primary frame to `paths.png_export`.

After successful export:

- persist `paths.wireframe_map`
- persist `paths.wireframe_state` with `State: completed`
- update `paths.stitch_state` when a Stitch-backed run was used
