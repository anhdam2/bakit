# BA Start Step - Wireframes

This step requires:

- `core/contract.yaml`
- `core/contract-behavior.md`

## Scope

Run Step 9 only. This path is read-only on upstream BA artifacts and may regenerate only the runtime `DESIGN.md`, the wireframe constraint pack, the wireframe handoff checklist, and the wireframe state marker.

## Prerequisites

- Resolve slug, date, and module using the shared contract.
- If `paths.wireframe_input` is missing and fallback source 2 or 3 is needed, require the exact `paths.backbone` so the portal snapshot can be rebuilt without guessing.
- Resolve the wireframe source in this order:
  1. `paths.wireframe_input`
  2. exact pair of `paths.srs_group` with `group=b` and `group=c`
  3. `paths.srs` only when Use Case Specifications, Screen Contract Plus, and Screen Inventory are already assembled there
- If source 2 or 3 is used, build or refresh `paths.wireframe_input` before preparing the manual wireframe handoff.
- If none of the sources exist, print all expected paths and stop.

## Outputs

- `paths.design_doc`
- `paths.wireframe_map`
- `paths.wireframe_state`

## Step 9.1 - Resolve wireframe input pack

Use `paths.wireframe_input` as the primary wireframe constraint source.

If the pack is missing but fallback sources exist:

- assemble the pack first from exact use case excerpts, Screen Contract Plus, Screen Inventory, and the exact portal snapshot from `paths.backbone`
- save it before continuing

Parse the input pack to build the handoff plan:

- group related screens by flow, module, or journey so the user can design them coherently
- treat modal, dialog, and drawer overlays with flow impact as primary screens
- derive required supporting frames from documented states, validation rules, list behavior, and feedback surfaces
- verify each screen group has a portal snapshot, menu schema snapshot, and active-menu expectations before planning the artifact
- carry forward the runtime design target `paths.design_doc`

## Step 9.2 - Ask for or refresh runtime DESIGN.md

Before the manual wireframe handoff is finalized:

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
- portal navigation schema
- active/selected menu rule
- breadcrumb / back behavior
- hidden/contextual navigation exceptions
- explicit anti-patterns

After the user answers:

- persist or refresh `paths.design_doc`
- stop if the user declines to approve a design direction

## Step 9.3 - Wireframe handoff preference

If Step 9 runs as part of the full lifecycle or SRS pipeline and the user did not explicitly ask to skip or manually choose screens, default to:

- `lite`: skip unless a screen is explicitly marked critical
- `hybrid`: prepare critical-screen wireframe constraints automatically
- `formal`: prepare the full approved screen set automatically

If the user skips:

- persist `paths.wireframe_state` with `State: skipped`
- stop without changing upstream artifacts

If the scope has no UI-backed screens:

- persist the marker with `State: not-applicable`
- stop

If wireframe handoff is expected but the pack cannot be completed:

- persist the marker with `State: missing`
- stop and report the failure

## Step 9.4 - Build manual wireframe handoff pack and checklist

For each approved screen group:

1. Read the linked use case excerpts, Screen Contract Plus entries, portal snapshots, and Screen Inventory rows from the wireframe input pack.
2. Read `paths.design_doc`.
3. Verify that the intended manual wireframe constraints match the same portal ownership, menu schema, active/highlight behavior, actions, flow steps, required states, and approved design decisions.
4. Stop if the screen group lacks either a portal snapshot or an approved navigation schema in `DESIGN.md`; do not infer missing menu structure.
5. Expand or refresh `paths.wireframe_input` so it contains the full constraint set the user needs to design manually or with an external tool, including menu matching checklist, active-state evidence requirements, and navigation exceptions.
6. Persist `paths.wireframe_map` as a manual handoff checklist:
   - which primary screens must be drawn
   - which supporting states must exist
   - which portal and navigation schema each screen must follow
   - which screens must show active-menu evidence and which screens are allowed to hide global navigation with an explicit reason
   - where the user should attach or reference the result in the final document
   - any non-negotiable labels, actions, validation cues, and navigation regions that must remain visible in the mockup
7. State explicitly in both artifacts that BA-kit does not generate the wireframe itself in this flow. The user is expected to design it manually and manually insert the final mockup reference into the final document.

After the handoff pack is complete:

- persist `paths.wireframe_map`
- persist `paths.wireframe_state` with `State: completed`
