# Bản đồ handoff wireframe thủ công (Manual Wireframe Handoff Map)

## Thông tin bộ artifact (Artifact Set Information)

- Slug: [initiative-slug]
- Date: [YYMMDD-HHmm]
- Module: [module-slug]
- Source DESIGN.md: `designs/{slug}/DESIGN.md`
- Source input pack: `plans/{slug}-{date}/03_modules/{module_slug}/wireframe-input.md`
- State marker: `plans/{slug}-{date}/03_modules/{module_slug}/wireframe-state.md`

## Artifact Summary

| Artifact Name | Design Scope | Portal ID | Nav Schema ID | Included Primary Screens | Included Supporting Screens | Expected Manual Output |
| --- | --- | --- | --- | --- | --- | --- |
| [artifact-name] | [Flow / module / journey] | [PORTAL-CSR] | [NAV-CSR-01] | [SCR-01, SCR-02] | [SCR-01-EMPTY, SCR-01-ERROR] | [Image / Figma link / PDF / external AI mockup] |

## Screen To Final Document Mapping

| Screen ID | Screen Name | Classification | Portal ID | Nav Schema ID | Expected Active Menu Item | Final SRS Section | Expected Manual Reference | Active-State Evidence | Supporting Screens | Notes |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| SCR-01 | [Screen] | Primary screen | [PORTAL-CSR] | [NAV-CSR-01] | [Tickets] | [`srs.md` -> Screen Detail SCR-01] | [Paste image / add external link / attach file path] | [Highlight item `Tickets`] | [SCR-01-EMPTY, SCR-01-ERROR] | [Mapping notes] |

## Supporting Screen Inventory

| Screen ID | Parent Screen | Classification | Expected Manual Representation | Reason |
| --- | --- | --- | --- | --- |
| SCR-01-EMPTY | SCR-01 | Supporting state | [Separate frame / annotated note / embedded variant] | [Why this state exists] |

## Navigation Exceptions

| Screen ID | Exception Type | Reason | Expected Manual Representation |
| --- | --- | --- | --- |
| SCR-02 | [Modal / Deep link / Wizard step] | [Ẩn global nav để tập trung xác nhận] | [Frame riêng không có menu, có close/back rõ ràng] |

## User Action Checklist

| Screen ID | User Must Do | Status |
| --- | --- | --- |
| SCR-01 | [Design wireframe and manually attach it into the final SRS section] | [Todo / Done] |

## Coverage Checks

- Every primary screen in the input pack has a manual handoff row
- Every required supporting state inferred during preparation is documented
- Every primary screen has a clear `Portal ID`
- Every screen group carries a portal and navigation-schema snapshot
- Every screen with visible global navigation has explicit active-state evidence
- Every hidden-navigation exception is documented with a reason
- Every final SRS screen section has a clear place for user-supplied wireframe evidence
- Screen IDs remain stable between the SRS and the manual wireframe handoff pack
- Any user-supplied mockup must remain aligned with the approved `DESIGN.md`
