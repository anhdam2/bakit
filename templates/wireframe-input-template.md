# Gói đầu vào wireframe (Wireframe Input Pack)

## Thông tin bộ artifact (Artifact Set Information)

- Slug: [initiative-slug]
- Date: [YYMMDD-HHmm]
- App type: [web-app | mobile-app]
- Source FRD: `plans/reports/final/frd-{date}-{slug}.md`
- Source user stories: `plans/reports/final/user-stories-{date}-{slug}.md`
- Source use cases: `plans/reports/drafts/srs-{date}-{slug}-group-b.md`
- Source screen contract: `plans/reports/drafts/srs-{date}-{slug}-group-c.md`

## Quy tắc tạo wireframe (Wireframe Generation Rules)

- Design system mặc định: Shadcn UI
- Mọi modal, drawer, dialog, wizard step, hoặc overlay có ảnh hưởng luồng phải được coi là primary screen
- Supporting states phải được suy ra từ states, validation rules, table/list behavior, và feedback surfaces
- Không tự phát minh hành vi khi use case hoặc Screen Contract Lite chưa đủ

## Use Case Excerpts

### [UC-xx] [Use Case Name]

- Linked screens: [SCR-xx, SCR-yy]
- Actor actions:
  - [...]
- System responses:
  - [...]
- Alternate flows:
  - [...]
- Linked user stories:
  - [...]

## Screen Contract Lite

| Screen ID | Screen Name | Classification | Parent Screen | Linked Use Cases | Entry / Exit | Key Actions | Required States | Documentation Level |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| SCR-01 | [Screen] | Primary screen | [N/A] | [UC-01] | [Entry / Exit] | [Submit, Cancel] | [Loading, Error, Success] | Detailed |

## Screen Inventory

| Screen/Frame ID | Screen Name | Classification | Parent Screen | Purpose | Documentation Level |
| --- | --- | --- | --- | --- | --- |
| SCR-01 | [Screen] | Primary screen | [N/A] | [Purpose] | Detailed |
| SCR-01-EMPTY | [Empty State] | Supporting state | [SCR-01] | [Purpose] | Inventory-only |

## Proposed Artifact Groups

| Artifact Name | Included Primary Screens | Expected Supporting Frames | Notes |
| --- | --- | --- | --- |
| [artifact-name] | [SCR-01, SCR-02] | [SCR-01-EMPTY, SCR-01-ERROR] | [Flow/module rationale] |

## Stop Conditions

- Stop if linked use case excerpts are missing for any primary screen
- Stop if Screen Contract Lite is incomplete for a primary screen
- Stop if assigned screen set is too large to keep frame mapping and state coverage consistent
