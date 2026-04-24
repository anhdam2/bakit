# Chỉ mục bộ nhớ dự án (Project Memory Index)

> **Vai trò (Role):** Navigator giới hạn — chỉ định tuyến đến shard/module đúng. KHÔNG chứa nội dung chi tiết.
> Chi tiết nằm trong các shard hot/warm/cold, không nằm ở đây.

**Dự án (Project):** [Tên dự án]
**Slug:** [initiative-slug]
**Ngày (Date):** [YYMMDD-HHmm]
**Chế độ (Mode):** shard
**Cập nhật lần cuối (Last Updated):** [YYYY-MM-DD]
**Runtime cập nhật (Updated By Runtime):** [claude-code | codex | antigravity]

## Trạng thái kích hoạt (Activation State)

| Shard | Đường dẫn | Trạng thái | Cập nhật gần nhất |
| --- | --- | --- | --- |
| Canonical Vocabulary | `hot/canonical-vocabulary.md` | [active \| stale \| empty] | [YYYY-MM-DD] |
| Approved Decisions | `hot/approved-decisions.md` | [active \| stale \| empty] | [YYYY-MM-DD] |
| Push-back Triggers | `hot/pushback-triggers.md` | [active \| stale \| empty] | [YYYY-MM-DD] |
| Memory Log | `log.md` | [active \| not-initialized] | [YYYY-MM-DD] |

## Module Shard (Warm)

| Module Slug | Đường dẫn | Trạng thái | Ghi chú |
| --- | --- | --- | --- |
| [module-slug] | `warm/modules/[module-slug].md` | [active \| stale \| empty] | [Ghi chú ngắn] |

## Cold Archive

| Chủ đề lưu trữ | Đường dẫn | Lý do lưu trữ |
| --- | --- | --- |
| [Chủ đề] | `cold/[filename].md` | [Thông tin đã bị thay thế / không còn hiệu lực] |

## Hướng dẫn đọc (Read Guide)

- Đọc hot shards trước khi bắt đầu bất kỳ command nào.
- Đọc warm module shard tương ứng khi làm việc với module cụ thể.
- Đọc `log.md` CHỈ KHI cần lịch sử gần đây hoặc audit context.
- KHÔNG đọc cold shards trừ khi có lý do escalation rõ ràng.
- File compact `project-memory.md` (nếu vẫn tồn tại) là fallback tương thích ngược.

## Owner Metadata

| Layer | Primary Owner | Role |
| --- | --- | --- |
| Global (hot/) | [Lead BA Name / TBD] | Lead BA |
| Module: {module_slug} | [Module BA Name / TBD] | Module BA |

## Shard Health

| Shard | Last Refreshed | Status |
| --- | --- | --- |
| hot/canonical-vocabulary.md | [YYYY-MM-DD] | [current / stale] |
| hot/approved-decisions.md | [YYYY-MM-DD] | [current / stale] |
| hot/pushback-triggers.md | [YYYY-MM-DD] | [current / stale] |
| warm/modules/{module_slug}.md | [YYYY-MM-DD] | [current / stale] |
