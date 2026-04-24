# Bộ nhớ Module (Module Memory Shard) — Warm Tier

> **Vai trò (Role):** Module shard schema. Chứa bộ nhớ cụ thể cho một module, thuộc warm tier.
> Đọc shard này khi làm việc với module tương ứng — không đọc mặc định cho tất cả command.

**Dự án (Project):** [Tên dự án]
**Slug:** [initiative-slug]
**Module Slug:** [module-slug]
**Owner:** [requirements-engineer | ui-ux-designer | ba-documentation-manager]
**Trạng thái module (Module Status):** [in-progress | completed | on-hold | blocked]
**Cập nhật lần cuối (Last Updated):** [YYYY-MM-DD]

## Tóm tắt phạm vi module (Module Scope Summary)

[Mô tả ngắn gọn phạm vi và mục tiêu của module này — tối đa 3–5 dòng]

## Quyết định chính của module (Key Module Decisions)

| Decision ID | Quyết định | Nguồn xác nhận | Ảnh hưởng artifact |
| --- | --- | --- | --- |
| MOD-DEC-01 | [Quyết định cụ thể cho module này] | [User / Backbone / Impact run] | [frd, stories, srs] |

## Phụ thuộc chéo module (Cross-Module Dependencies)

| Module phụ thuộc | Loại phụ thuộc | Artifact cụ thể | Trạng thái |
| --- | --- | --- | --- |
| [module-slug-khác] | [data-contract \| shared-actor \| shared-rule \| integration] | [FR-XX / SCR-XX / ACT-XX] | [resolved \| pending \| blocked] |

## Liên kết truy vết (Trace Links)

| Artifact | Đường dẫn | Trạng thái |
| --- | --- | --- |
| FRD | `03_modules/[module-slug]/frd.md` | [exists \| missing] |
| User Stories | `03_modules/[module-slug]/user-stories.md` | [exists \| missing] |
| SRS | `03_modules/[module-slug]/srs.md` | [exists \| missing] |
| Wireframe Input | `03_modules/[module-slug]/wireframe-input.md` | [exists \| missing \| not-applicable] |

## Vấn đề mở (Open Issues)

| Issue ID | Mô tả | Blocking | Cần hành động |
| --- | --- | --- | --- |
| MOD-ISS-01 | [Vấn đề chưa giải quyết] | [yes \| no] | [Route impact \| Hỏi user \| Escalate] |

## Ownership

- **Module slug:** [{module_slug}]
- **Module BA:** [Tên BA phụ trách module / TBD]
- **Lead BA:** [Tên Lead BA]
- **Last reviewed:** [YYYY-MM-DD]
- **Cross-module dependencies:** [none / list]

## Promotion Trace

| Record ID | Promoted At | Approved By | Source Artifact |
| --- | --- | --- | --- |
| FB-YYMMDD-01 | [YYYY-MM-DD] | [approver] | [path] |
