# BA Start Step - Backbone

This step requires:

- `core/contract.yaml`
- `core/contract-behavior.md`

## Scope

Run Step 5 only.

## Prerequisites

- Resolve slug and date using the shared contract.
- Require `paths.intake`.
- If intake is missing, print the exact missing path and stop.
- Run a narrow backbone preflight:
  - read only `paths.intake` and `paths.plan` when it exists
  - do not scan other folders once slug and date are resolved

## Output

- `paths.backbone`

## Step 5 - Build the requirements backbone

Create the persisted source-of-truth artifact using [../../../templates/requirements-backbone-template.md](../../../templates/requirements-backbone-template.md).

The backbone must contain:

- scope lock summary
- selected engagement mode (`lite`, `hybrid`, or `formal`)
- business goals and success metrics
- actors and feature map
- FR/NFR draft inventory
- preliminary story map
- UI/screen coverage assessment
- artifact emission gates
- assumptions, risks, and open questions

Backbone rules:

- treat the backbone as the primary authoring source after intake
- do not draft FRD, stories, or SRS directly from raw intake once the backbone exists
- keep the artifact concise and decision-oriented
