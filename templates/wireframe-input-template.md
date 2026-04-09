# Gói đầu vào wireframe (Wireframe Input Pack)

## Thông tin bộ artifact (Artifact Set Information)

- Slug: [initiative-slug]
- Date: [YYMMDD-HHmm]
- Module: [module-slug]
- App type: [web-app | mobile-app]
- System design document: `designs/{slug}/DESIGN.md`
- Source FRD: `plans/{slug}-{date}/03_modules/{module_slug}/frd.md`
- Source user stories: `plans/{slug}-{date}/03_modules/{module_slug}/user-stories.md`
- Source use cases: `plans/{slug}-{date}/03_modules/{module_slug}/srs-group-b.md`
- Source screen contract: `plans/{slug}-{date}/03_modules/{module_slug}/srs-group-c.md`

## Quy tắc tạo wireframe (Wireframe Generation Rules)

- Design system mặc định nếu `DESIGN.md` chưa ghi khác: Shadcn UI
- Phải đọc `designs/{slug}/DESIGN.md` như system document trước khi tạo wireframe
- Mọi modal, drawer, dialog, wizard step, hoặc overlay có ảnh hưởng luồng phải được coi là primary screen
- Supporting states phải được suy ra từ states, validation rules, table/list behavior, và feedback surfaces
- Không tự phát minh hành vi khi use case hoặc Screen Contract Lite chưa đủ
- Bắt buộc áp dụng cấu trúc Information Architecture (Portals, Navigation, Sitemap) đã định nghĩa trong `DESIGN.md` để đảm bảo hệ thống menu nhất quán trên toàn bộ các frame.
- Nếu `DESIGN.md` chưa tồn tại hoặc chưa được người dùng chốt, phải dừng trước khi tạo wireframe

## Tóm tắt quyết định thiết kế đã chốt (Approved Design Decisions Snapshot)

- Reference direction: [Nguồn tham chiếu hoặc phong cách tự định nghĩa]
- Visual tone: [Ví dụ: enterprise, operational, premium, playful]
- Color direction: [Tóm tắt]
- Typography direction: [Tóm tắt]
- Component feel: [Tóm tắt]
- Responsive priority: [Desktop-first | Mobile-first | Balanced]
- Portals & Navigation: [Ví dụ: Admin Portal (Sidebar), Customer App (Bottom tabs)]
- Key Sitemap: [Ví dụ: Dashboard, Users, Settings, Profile]
- Hard constraints / anti-patterns: [Tóm tắt]

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
- Stop if the project `DESIGN.md` is missing, stale, or still awaiting user approval
- Stop if assigned screen set is too large to keep frame mapping and state coverage consistent
