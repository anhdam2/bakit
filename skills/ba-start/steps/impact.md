# BA Start Step - Impact

This step requires:

- `core/contract.yaml`
- `core/contract-behavior.md`

## Scope

Run the change-impact triage path only. Do not mutate artifacts.

## Prerequisites

- Resolve slug, date, and module scope through the shared contract.
- Require a change input as either:
  - a direct file path free argument, or
  - pasted change text in the conversation
- Require `paths.intake`.
- If intake is missing, print the exact missing path and stop.
- Read `paths.backbone` when it exists.
- Read module-scoped downstream artifacts only when they exist and are relevant to the suspected impact:
  - `paths.frd`
  - `paths.stories`
  - `paths.srs`
  - `paths.wireframe_input`
  - `paths.wireframe_map`
  - `paths.wireframe_state`
  - `paths.plan` when it adds gate context

## Decision Rules

Treat the current source of truth in this order:

1. `backbone`
2. otherwise `intake`

Classify the change into one or more of these buckets:

- `wording-only`
- `clarification-only`
- `backbone-change`
- `scope-lock-change`
- `ui-impact`

Impact anchors:

- intake: business problem, goals, out-of-scope, success metrics
- backbone: scope lock summary, feature map, FR/NFR backbone, actors, story map, UI coverage, artifact gates
- FRD: feature wording, workflows, business rules, integration points
- user stories: story intent and acceptance criteria
- SRS: use cases, Screen Contract Lite, validation rules, screen inventory, final screen descriptions
- wireframe artifacts: screen-to-frame mapping, runtime `DESIGN.md` assumptions, wireframe state

## Routing Rules

- If the change touches goals, out-of-scope, success metrics, or scope decisions, route to `intake` first.
- If the change touches feature scope, FR/NFR intent, actors, or acceptance-criteria intent, route to `backbone` first.
- If the change stays within existing backbone intent but changes story wording or testable acceptance detail, route to `stories`.
- If the change stays within existing backbone and story intent but changes use case flow, validation behavior, error states, or screen behavior, route to `srs`.
- If the change affects screen inventory, state variants, navigation, overlays, or field interactions that wireframes must show, mark `ui-impact` and include `wireframes` after the required upstream rerun.
- Never recommend `package` as the first remediation step after a real requirement change.

## Output

Print:

- project and date set
- detected current step
- change type
- source of truth to update
- current source of truth used for analysis
- affected artifacts
- unaffected artifacts
- recommended path
- exact commands
- only the focused questions that are truly required
