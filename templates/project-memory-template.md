# Bộ nhớ dự án (Project Memory) — Chế độ Compact/Summary

> **Vai trò (Role):** Đây là file bộ nhớ compact (tóm tắt) cho dự án đơn giản hoặc khi cây shard chưa được khởi tạo.
> Khi dự án phức tạp hơn, hãy tạo thư mục `project-memory/` và dùng `project-memory-index-template.md` để điều hướng shard.
> File này giữ nguyên vai trò backward-compatible: dự án chỉ có file này vẫn hoạt động đầy đủ.

**Dự án (Project):** [Tên dự án]
**Slug:** [initiative-slug]
**Ngày (Date):** [YYMMDD-HHmm]
**Chế độ (Mode):** compact
**Nguồn làm mới gần nhất (Last Refresh Source):** [intake | backbone | impact follow-up]
**Host runtime gần nhất (Last Runtime):** [claude-code | codex | antigravity | mixed]

## Mục đích sử dụng (Purpose)

- Đây là bộ nhớ nghiệp vụ theo dự án, tồn tại trên disk và độc lập với memory tạm thời của runtime.
- Dùng để giảm hallucination bằng cách tái sử dụng quyết định đã được chấp nhận, thuật ngữ chuẩn, và correction đã được xác nhận.
- Không thay thế `intake.md` hoặc `backbone.md`; chỉ lưu các điểm cần tái nạp ổn định giữa các lần chạy và giữa các runtime.
- Khi cần điều hướng nhiều shard/module, chuyển sang cây `project-memory/` với `index.md` làm navigator.

## Canonical Vocabulary

| Memory ID | Loại | Thuật ngữ / Cụm từ chuẩn | Diễn giải / Cách dùng | Nguồn chuẩn | Trạng thái |
| --- | --- | --- | --- | --- | --- |
| MEM-VOC-01 | Domain Term | [Thuật ngữ] | [Định nghĩa hoặc cách dùng được chấp nhận] | [Backbone / SRS / user confirmation] | [confirmed / provisional] |

## Approved Decisions

| Decision ID | Chủ đề | Quyết định đã chốt | Nguồn xác nhận | Ảnh hưởng artifact |
| --- | --- | --- | --- | --- |
| MEM-DEC-01 | [Scope / Actor / Navigation / Rule] | [Nội dung quyết định] | [User / Backbone / Impact run] | [backbone, stories, srs] |

## Accepted Assumptions

| Assumption ID | Giả định đã chấp nhận | Điều kiện hiệu lực | Nguồn xác nhận | Cần rà lại khi nào |
| --- | --- | --- | --- | --- |
| MEM-ASM-01 | [Giả định] | [Khi nào được phép dùng] | [User / Backbone] | [Trigger rà lại] |

## Rejected Assumptions And False Trails

| Reject ID | Điều không được suy diễn lại | Lý do bị loại | Nguồn xác nhận | Ghi chú |
| --- | --- | --- | --- | --- |
| MEM-REJ-01 | [Giả định sai / cách gọi sai / scope sai] | [Lý do] | [Impact / user correction] | [Ghi chú] |

## Accepted Corrections

| Correction ID | Phát biểu thay đổi / correction | Node hoặc artifact bị ảnh hưởng | Cách xử lý đã chấp nhận | Ngày |
| --- | --- | --- | --- | --- |
| MEM-COR-01 | [Correction] | [FR-01 / ACT-02 / SCR-03 / backbone] | [Rerun backbone rồi stories] | [YYYY-MM-DD] |

## Push-back Triggers

| Trigger ID | Dấu hiệu phải dừng và hỏi lại | Câu hỏi hoặc hành động bắt buộc |
| --- | --- | --- |
| MEM-PBK-01 | [Mâu thuẫn actor / scope / rule / terminology] | [Hỏi lại user hoặc route impact] |

## Runtime Handoff Notes

- Runtime memory nội bộ của Claude Code, Codex, hoặc Antigravity không phải nguồn chuẩn.
- Khi đổi runtime, phải đọc file này cùng `backbone.md` trước khi tiếp tục downstream work.
- Chỉ lưu facts, decisions, corrections, và anti-hallucination cues có thể tái sử dụng; không dump transcript dài.
