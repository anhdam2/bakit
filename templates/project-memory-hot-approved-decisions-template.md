# Quyết định đã chốt (Approved Decisions) — Hot Shard

> **Vai trò (Role):** Global decisions shard. Đọc trước mọi command để tránh đảo ngược quyết định đã chốt.
> Đây là shard hot — luôn được nạp cùng với `canonical-vocabulary.md` và `pushback-triggers.md`.

**Dự án (Project):** [Tên dự án]
**Slug:** [initiative-slug]
**Cập nhật lần cuối (Last Updated):** [YYYY-MM-DD]
**Nguồn làm mới (Refresh Source):** [intake | backbone | impact follow-up]

## Bảng quyết định (Decision Table)

| Decision ID | Chủ đề | Quyết định đã chốt | Nguồn xác nhận | Ảnh hưởng artifact | Ngày chốt |
| --- | --- | --- | --- | --- | --- |
| MEM-DEC-01 | [Scope / Actor / Navigation / Rule / Architecture] | [Nội dung quyết định rõ ràng] | [User / Backbone / Impact run] | [backbone, stories, srs] | [YYYY-MM-DD] |

## Giả định đã chấp nhận (Accepted Assumptions)

| Assumption ID | Giả định đã chấp nhận | Điều kiện hiệu lực | Nguồn xác nhận | Cần rà lại khi nào |
| --- | --- | --- | --- | --- |
| MEM-ASM-01 | [Giả định] | [Khi nào được phép dùng] | [User / Backbone] | [Trigger rà lại] |

## Giả định bị từ chối (Rejected Assumptions)

| Reject ID | Điều không được suy diễn lại | Lý do bị loại | Nguồn xác nhận |
| --- | --- | --- | --- |
| MEM-REJ-01 | [Giả định sai / cách gọi sai / scope sai] | [Lý do] | [Impact / user correction] |

## Correction đã chấp nhận (Accepted Corrections)

| Correction ID | Phát biểu correction | Node bị ảnh hưởng | Cách xử lý đã chấp nhận | Ngày |
| --- | --- | --- | --- | --- |
| MEM-COR-01 | [Correction] | [FR-01 / ACT-02 / SCR-03 / backbone] | [Rerun backbone rồi stories] | [YYYY-MM-DD] |

## Ghi chú sử dụng (Usage Notes)

- Khi thêm quyết định mới, tăng ID theo thứ tự `MEM-DEC-NN`.
- Quyết định đã chốt KHÔNG được đảo ngược ngầm — phải qua `impact` trước.
- Khi quyết định bị thay thế hoàn toàn, chuyển mục cũ sang `cold/` và ghi lý do.
