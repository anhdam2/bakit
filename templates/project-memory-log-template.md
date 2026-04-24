# Nhật ký bộ nhớ dự án (Project Memory Log)

> **CẢNH BÁO (WARNING):** File này là nhật ký thời gian tuyến tính, chỉ ghi thêm (append-only).
> Đây KHÔNG phải nguồn sự thật. `backbone.md` và hot shards luôn là nguồn ưu tiên hơn.
> KHÔNG đọc file này trong command thông thường — chỉ đọc khi cần lịch sử gần đây hoặc audit context.

**Dự án (Project):** [Tên dự án]
**Slug:** [initiative-slug]

## Cách ghi nhật ký (Log Entry Format)

Mỗi mục nhật ký phải theo cấu trúc dưới đây. Chỉ ghi thêm vào cuối file, không sửa mục cũ.

---

### [YYYY-MM-DD] — [Loại sự kiện]

**Nguồn artifact (Source Artifact):** [backbone | intake | impact | stories | srs | user-correction]
**Loại sự kiện (Event Type):** [correction | assumption-update | scope-change | decision-override | terminology-update]
**Runtime:** [claude-code | codex | antigravity]

**Tóm tắt (Summary):**
[Mô tả ngắn gọn điều đã thay đổi hoặc được ghi nhận]

**Node bị ảnh hưởng (Affected Nodes):** [FR-01 / ACT-02 / SCR-03 / MEM-DEC-01 / ...]

**Hành động đã thực hiện (Action Taken):** [Rerun backbone | Update hot shard | Flag for review | No mutation]

---

## Nhật ký (Log Entries)

<!-- Ghi thêm mục mới bên dưới theo định dạng trên -->
