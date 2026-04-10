# Xương sống yêu cầu (Requirements Backbone)

**Dự án (Project):** [Tên dự án]
**Slug:** [initiative-slug]
**Ngày (Date):** [YYMMDD-HHmm]
**Chế độ triển khai (Engagement Mode):** [lite | hybrid | formal]
**Chủ sở hữu (Owner):** [BA owner]

## Tóm tắt quyết định phạm vi (Scope Lock Summary)

- Vấn đề kinh doanh:
- Kết quả mong muốn:
- Ngoài phạm vi:
- Các quyết định đã chốt:

## Mục tiêu kinh doanh và chỉ số thành công (Business Goals and Success Metrics)

| Goal ID | Mục tiêu | Chỉ số / Kết quả đo lường | Chủ sở hữu |
| --- | --- | --- | --- |
| BG-01 | [Mục tiêu] | [KPI / Outcome] | [Owner] |

## Nhóm người dùng và tác nhân (Users and Actors)

| Actor ID | Vai trò | Mục tiêu chính | Ghi chú |
| --- | --- | --- | --- |
| ACT-01 | [Vai trò] | [Mục tiêu] | [Ghi chú] |

## Ma trận portal và sở hữu điều hướng (Portal Matrix)

Chốt ở cấp hệ thống trước khi viết screen spec theo module. Đây là nguồn chuẩn để module chỉ snapshot lại, không tự định nghĩa lại menu toàn cục.

| Portal ID | Portal Name | Target Actor / Access Scope | Owned Screen Families / Route Groups | Default Entry Context |
| --- | --- | --- | --- | --- |
| PORTAL-CSR | [CSR Portal] | [CSR / customer support / scoped access] | [Dashboard, Tickets, Customer Detail] | [Đăng nhập xong vào Dashboard] |

## Bản đồ tính năng và phạm vi (Feature Map and Scope)

| Feature ID | Tính năng / Capability | Mô tả | Ưu tiên | In Scope | Ghi chú |
| --- | --- | --- | --- | --- | --- |
| F-01 | [Tính năng] | [Mô tả] | [Must / Should / Could] | [Yes / No] | [Ghi chú] |

## Backbone yêu cầu chức năng (Functional Backbone)

| FR ID | Yêu cầu | Giá trị kinh doanh | Nguồn | Tiêu chí chấp nhận tóm tắt |
| --- | --- | --- | --- | --- |
| FR-01 | [Yêu cầu] | [Giá trị] | [Nguồn] | [AC tóm tắt] |

## Backbone yêu cầu phi chức năng (Non-Functional Backbone)

| NFR ID | Danh mục | Yêu cầu | Trigger / Gate |
| --- | --- | --- | --- |
| NFR-01 | [Performance / Security / Availability] | [Yêu cầu] | [Khi nào cần đặc tả chi tiết] |

## Story Map sơ bộ (Preliminary Story Map)

| Epic | Capability | Story / Outcome | Ưu tiên | Ghi chú |
| --- | --- | --- | --- | --- |
| [Epic] | [Capability] | [Story / Outcome] | [Must / Should / Could] | [Ghi chú] |

## UI và màn hình cần tài liệu (UI and Screen Coverage)

| Screen ID | Portal ID | Màn hình / Luồng | Mức độ phức tạp | Cần wireframe | Ghi chú |
| --- | --- | --- | --- | --- | --- |
| SCR-01 | [PORTAL-CSR] | [Màn hình] | [Low / Medium / High] | [Yes / No / Critical-only] | [Ghi chú] |

## Hướng thiết kế UI cần chốt trước wireframe (UI Design Direction Before Wireframes)

- Có cần `designs/{slug}/DESIGN.md`: [Yes / No]
- Hướng tham chiếu ban đầu: [Tham chiếu DESIGN.md / brand / custom brief]
- Quyết định người dùng cần chốt trước Step 9: [Màu sắc, typography, density, component feel, responsive priority, navigation schema theo portal, active-menu rule, breadcrumb/back behavior, anti-patterns]

## Gating quyết định artifact (Artifact Emission Gates)

- FRD: [Required / Optional] + lý do
- User stories: [Required / Optional] + lý do
- SRS: [Required / Optional] + lý do
- Wireframes: [Required / Optional] + lý do
- Package HTML: [Required / Optional] + lý do

## Assumptions, Risks, Open Questions

### Assumptions

- 

### Risks

- 

### Open Questions

1. 

## Next Step

- [Bước tiếp theo được khuyến nghị theo mode]
