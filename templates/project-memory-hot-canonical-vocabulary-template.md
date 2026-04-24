# Từ vựng chuẩn dự án (Canonical Vocabulary) — Hot Shard

> **Vai trò (Role):** Global vocabulary shard. Đọc trước mọi command để tránh drift thuật ngữ.
> Đây là shard hot — luôn được nạp cùng với `approved-decisions.md` và `pushback-triggers.md`.

**Dự án (Project):** [Tên dự án]
**Slug:** [initiative-slug]
**Cập nhật lần cuối (Last Updated):** [YYYY-MM-DD]
**Nguồn làm mới (Refresh Source):** [intake | backbone | impact follow-up]

## Bảng từ vựng (Vocabulary Table)

| Memory ID | Loại | Thuật ngữ / Cụm từ chuẩn | Định nghĩa / Cách dùng được chấp nhận | Nguồn chuẩn | Trạng thái |
| --- | --- | --- | --- | --- | --- |
| MEM-VOC-01 | Domain Term | [Thuật ngữ] | [Định nghĩa hoặc cách dùng được chấp nhận] | [Backbone / SRS / user confirmation] | [confirmed \| provisional] |
| MEM-VOC-02 | Actor Name | [Tên actor] | [Mô tả role và phạm vi action] | [Backbone] | [confirmed] |
| MEM-VOC-03 | System Name | [Tên hệ thống / tích hợp] | [Tên chính thức và cách viết tắt được phép] | [Intake / user confirmation] | [confirmed] |

## Thuật ngữ bị từ chối (Rejected Terms)

| Thuật ngữ sai | Thuật ngữ đúng thay thế | Lý do từ chối |
| --- | --- | --- |
| [Cách gọi sai / viết tắt sai] | [MEM-VOC-XX] | [Mâu thuẫn với backbone / user correction] |

## Ghi chú sử dụng (Usage Notes)

- Khi thêm thuật ngữ mới, tăng ID theo thứ tự `MEM-VOC-NN`.
- Thuật ngữ `provisional` cần được xác nhận trước khi emit SRS hoặc FRD.
- Khi thuật ngữ bị thay thế hoàn toàn, chuyển mục cũ sang `cold/` và ghi lý do.
