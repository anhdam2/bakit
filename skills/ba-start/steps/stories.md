# BA Start Step - Stories

This step requires:

- `core/contract.yaml`
- `core/contract-behavior.md`

## Scope

Run Step 7 only.

## Prerequisites

- Resolve slug, date, and module using the shared contract.
- Require `paths.backbone`.
- If backbone is missing, print the exact missing path and stop.
- Run a narrow stories preflight:
  - read only `paths.backbone`
  - read `paths.plan` only when it adds needed scope context
  - read `paths.frd` only when it already exists and adds needed vocabulary or workflow structure
  - do not scan unrelated module folders once slug, date, and module are resolved

## Output

- `paths.stories`

## Step 7 - Produce user stories

Generate Agile user stories from the backbone feature map and FR draft using [../../../templates/user-story-template.md](../../../templates/user-story-template.md):

- Epic and feature breakdown
- User stories with acceptance criteria (Given/When/Then)
- INVEST validation
- Story-to-screen alignment when UI exists

Execution rules:

- Start from the exact backbone artifact only, plus the exact plan path when genuinely needed.
- Pull the FRD only when it already exists or the current mode requires it.
- If the user already confirmed that story generation should proceed, continue from the resolved backbone instead of reopening discovery.

Save to `paths.stories`.
