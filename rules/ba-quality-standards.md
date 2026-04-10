# BA Quality Standards

All BA-kit artifacts must satisfy these standards before they are considered complete.

Related rules:
- [BA Workflow](./ba-workflow.md)

## Requirements
- Every requirement has a clear source, business rationale, and owner.
- Every requirement has acceptance criteria or validation guidance.
- Every requirement is unambiguous, testable, and prioritized.
- Requirements use one intent per statement and no bundled behaviors.

## Stories and Acceptance Criteria
- User stories follow the `As a / I want / so that` structure when Agile is used.
- Acceptance criteria are specific enough to verify without interpretation.
- Boundary conditions and failure cases are captured where relevant.

## Traceability
- Business goals map to requirements.
- Requirements map to downstream artifacts, controls, or test cases.
- Cross-references are explicit and easy to follow.

## Cross-Artifact Consistency
- Use cases, screen descriptions, wireframe constraints, and any user-supplied wireframes must describe the **same** behavior using **identical** terminology.
- Every detailed Use Case in the SRS must include a Process Flow (BPMN 2.0 with swimlanes) or Sequence Diagram (using Mermaid).
- When wireframe support is requested, an approved project `DESIGN.md` must exist and the resulting manual handoff pack must follow it consistently.
- Screen Contract Plus must be sufficient to prepare wireframe constraints before final screen descriptions are written.
- The backbone must lock a system-level `Portal Matrix` whenever UI-backed scope exists.
- `DESIGN.md` must define a `Navigation Schema` for every portal that appears in module-level screen specs.
- UC actor actions must match screen User Actions — same wording, same sequence.
- UC system responses must match screen field Behaviour Rules.
- UC alternate flows must be reflected in screen Error/States.
- `Portal ID`, `Nav Schema ID`, and `Expected Active Menu Item` must remain consistent between Screen Contract Plus, wireframe artifacts, final screen descriptions, and any user-supplied mockup.
- Screens in the same portal must reuse the same navigation schema unless an explicit exception is documented.
- If global navigation is visible on a screen, the active/highlighted menu state must be documented as both behavior and visual evidence.
- Modal, dialog, drawer, and overlay screens with distinct interaction logic must be modeled as primary screens with their own detailed screen sections.
- Supporting wireframe frames must reflect the parent screen's defined states and feedback rules, including empty, error, and message variants when applicable.
- Field names must be identical across UC steps, screen field tables, and wireframe constraint labels or user-supplied mockup labels.
- Screen field descriptions must separate `Display Rules`, `Behaviour Rules`, and `Validation Rules`.
- `Display Rules` should capture how the field appears, including label, placeholder, visibility, defaults, formatting, and read-only state when relevant.
- `Behaviour Rules` should capture what happens when the user interacts with the field, including navigation targets, modal openings, and dependent-field behavior.
- `Validation Rules` should capture validation logic, error surface (`inline`, `toast`, `banner`, etc.), and the exact message text or `Message Code`.
- Reusable cross-screen rules should be centralized in a `Common Rules` section and referenced by `Rule Code` from screen descriptions instead of being duplicated verbatim.
- Reusable UI and validation messages should be centralized in a `Message List` section and referenced by `Message Code` from screen descriptions instead of being duplicated verbatim.
- `Rule Code` should use the format `CR-{TYPE}-{NN}` where `TYPE` is one of `DIS`, `BEH`, `VAL`, or `MIX`.
- `Message Code` should use the format `MSG-{TYPE}-{NN}` where `TYPE` is one of `ERR`, `WRN`, `SUC`, or `INF`.
- `NN` should be a 2-digit sequence that remains unique within the SRS and stable when the same shared rule or message is reused.
- Each SRS screen must reference the correct manual wireframe status and attachment location when a mockup is supplied.
- Inventory-only supporting screens must still be listed in the SRS screen inventory and kept aligned with the wireframe handoff checklist.
- User story acceptance criteria must be covered by UC postconditions and screen Validation Rules.
- FRD features must be fully traceable through user stories into SRS requirements.
- Final screen descriptions must be derived from and remain consistent with the pre-wireframe screen spec, the wireframe constraint pack, and the upstream use cases.
- Final screen descriptions may enrich layout and interaction detail, but they must not redefine portal ownership, navigation schema, or active/highlight behavior that was already locked upstream.
- Any user-supplied wireframe styling, density, and component treatment must remain consistent with the approved `designs/{slug}/DESIGN.md`.
- When inconsistency is found, the upstream artifact (user story > use case > screen > wireframe) is the source of truth.

## Cross-Module Consistency (Teamwork Rules)
- **Information Architecture (IA) & UX Baseline Conflict:** Để ngăn chặn xung đột logical khi nhiều BA chuẩn bị wireframe handoff ở các module khác nhau, danh sách Portals, Global Navigation (Menu) và phong cách UX định hướng bắt buộc phải được "khoá" (locked) ở bước chạy cấp hệ thống (System-Level) bên trong `02_backbone/feature-map.md` và file `designs/{slug}/DESIGN.md` tập trung.
- Mọi nhánh thư mục feature (ví dụ `03_modules/payment`) KHÔNG ĐƯỢC tự ý định nghĩa thêm Global Menu hay thay đổi phong cách UX. Mọi yêu cầu thay đổi UX/Menu phải được PR ngược về file `02_backbone` hoặc `DESIGN.md` để cả team review.
- When working on a module feature branch (e.g., `03_modules/auth`), do not redefine global actors, feature maps, or system-level rules. Reference them strictly from `02_backbone`.
- `Rule Codes` (`CR-***`) and `Message Codes` (`MSG-***`) must be unique across all modules. If redefining a shared rule, escalate to the `02_backbone` or manage naming boundaries carefully to avoid collisions when modules are compiled together.
- Pull Requests should be checked for overlap or contradiction with other active modules, especially around Shared Screens or Integrations.

## Quality Checks
- SMART: specific, measurable, achievable, relevant, time-bound.
- INVEST for user stories where applicable.
- No contradictions across scope, process, and documentation.
- No orphaned requirements without a business justification.

## Review Checklist
- Is the artifact complete for its intended purpose?
- Is the language clear and jargon controlled?
- Are dependencies and assumptions visible?
- Are risks, edge cases, and constraints stated?
- Are the links to related artifacts current?
