# Bản đồ wireframe (Wireframe Map)

## Thông tin bộ artifact (Artifact Set Information)

- Slug: [initiative-slug]
- Date: [YYMMDD-HHmm]
- Source input pack: `plans/reports/drafts/wireframe-input-{date}-{slug}.md`
- State marker: `plans/reports/drafts/wireframe-state-{date}-{slug}.md`

## Artifact Summary

| Artifact Name | Pencil File | Export Folder | Included Primary Screens | Included Supporting Frames |
| --- | --- | --- | --- | --- |
| [artifact-name] | `designs/{slug}/[artifact-name].pen` | `designs/{slug}/exports/[artifact-name]/` | [SCR-01, SCR-02] | [SCR-01-EMPTY, SCR-01-ERROR] |

## Screen To Frame Mapping

| Screen ID | Screen Name | Classification | Pencil Artifact | Pencil Frame | Export PNG | Supporting Frames | Notes |
| --- | --- | --- | --- | --- | --- | --- | --- |
| SCR-01 | [Screen] | Primary screen | `designs/{slug}/[artifact-name].pen` | `SCR-01 - [Screen Name]` | `designs/{slug}/exports/[artifact-name]/SCR-01-[screen-name].png` | [SCR-01-EMPTY, SCR-01-ERROR] | [Mapping notes] |

## Supporting Frame Inventory

| Frame ID | Parent Screen | Classification | Pencil Artifact | Pencil Frame | Reason |
| --- | --- | --- | --- | --- | --- |
| SCR-01-EMPTY | SCR-01 | Supporting state | `designs/{slug}/[artifact-name].pen` | `SCR-01-EMPTY - [State Name]` | [Why this state exists] |

## Coverage Checks

- Every primary screen in the input pack has a Pencil frame
- Every required supporting state inferred during wireframing is listed
- Every exported PNG path matches the actual artifact/frame naming
- Frame names preserve screen IDs for SRS linkback
