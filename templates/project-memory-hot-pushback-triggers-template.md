# Trigger dừng và hỏi lại (Push-back Triggers) — Hot Shard

> **Vai trò (Role):** Fail-closed triggers shard. Đọc trước mọi command để biết khi nào PHẢI dừng và hỏi lại.
> Đây là shard hot — luôn được nạp cùng với `canonical-vocabulary.md` và `approved-decisions.md`.

**Dự án (Project):** [Tên dự án]
**Slug:** [initiative-slug]
**Cập nhật lần cuối (Last Updated):** [YYYY-MM-DD]
**Nguồn làm mới (Refresh Source):** [intake | backbone | impact follow-up]

## Bảng trigger (Trigger Table)

| Trigger ID | Dấu hiệu phải dừng (Signal) | Hành động bắt buộc (Required Action) | Ngữ cảnh áp dụng |
| --- | --- | --- | --- |
| MEM-PBK-01 | [Mâu thuẫn actor / scope / rule / terminology] | [Hỏi lại user hoặc route đến `impact`] | [Mọi command] |
| MEM-PBK-02 | [Thay đổi có thể chạm nhiều lớp source-of-truth] | [Route đến `impact` — KHÔNG mutate trực tiếp] | [Correction statements] |
| MEM-PBK-03 | [Fact bắt buộc bị thiếu cho bước tiếp theo] | [Đánh dấu là open question — KHÔNG đoán] | [backbone, srs, frd] |
| MEM-PBK-04 | [Module, slug, hoặc date không xác định rõ] | [Dừng và hỏi — KHÔNG chọn theo mtime] | [Mọi command] |

## Nguyên tắc fail-closed (Fail-Closed Principles)

- Khi có trigger, phải dừng và hỏi lại — KHÔNG điền vào bằng prose hợp lý.
- Nếu fact bắt buộc bị thiếu, đánh dấu là giả định hoặc open question thay vì trình bày như đã xác định.
- Nếu artifact downstream cần đoán một quyết định upstream, dừng và route về bước sở hữu quyết định đó.
- Trigger mới phát hiện trong quá trình thực thi phải được ghi thêm vào shard này trong lần rerun được phê duyệt.

## Ghi chú sử dụng (Usage Notes)

- Khi thêm trigger mới, tăng ID theo thứ tự `MEM-PBK-NN`.
- Trigger bị vô hiệu hóa (do scope thay đổi) phải được ghi chú rõ lý do, không xóa ngầm.
