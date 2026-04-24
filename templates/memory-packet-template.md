# Gói ngữ cảnh giới hạn (Bounded Context Packet)

> **CẢNH BÁO CHO WORKER (Worker Warning):**
> Đọc file này và các đoạn trích dẫn bên dưới MÀ THÔI.
> KHÔNG đọc toàn bộ cây `project-memory/`, `backbone.md`, hoặc SRS đầy đủ trừ khi được chỉ định rõ.
> Scope viết (write scope) của bạn được giới hạn nghiêm ngặt trong phần "Phạm vi viết" bên dưới.

**Dự án (Project):** [Tên dự án]
**Slug:** [initiative-slug]
**Packet ID:** [PKT-NN]
**Tạo bởi (Created By):** [orchestrator | lead-agent]
**Ngày tạo (Created):** [YYYY-MM-DD]
**Trạng thái (Status):** [queued | running | completed | needs-repartition | blocked | failed]

## Mục tiêu (Objective)

[Mô tả rõ ràng mục tiêu của packet này trong 2–4 câu. Không mô tả ambiguous.]

## Artifact đích (Target Artifact)

**Đường dẫn đích (Target Path):** `plans/{slug}-{date}/[path-to-artifact]`
**Loại hành động (Action Type):** [create | append | update-section | review-only]
**Section đích (Target Section):** [Tên section cụ thể, nếu chỉ cập nhật một phần]

## Phạm vi viết (Write Scope — Exact Files Allowed)

Worker chỉ được phép viết vào các file sau:

- `plans/{slug}-{date}/[file-1]`
- `plans/{slug}-{date}/[file-2]`

Không được tạo file ngoài danh sách trên.

## Trace IDs liên quan (Relevant Trace IDs)

| ID | Loại | Mô tả ngắn |
| --- | --- | --- |
| [FR-01] | Functional Requirement | [Mô tả] |
| [ACT-02] | Actor | [Tên và role] |
| [SCR-03] | Screen | [Tên màn hình] |

## Đoạn trích upstream (Upstream Excerpts)

> Chỉ chèn các đoạn trích tối thiểu cần thiết để hoàn thành mục tiêu.
> KHÔNG paste toàn bộ backbone hoặc SRS vào đây.

### Từ backbone.md

```
[Paste đoạn trích chính xác từ backbone — chỉ phần liên quan]
```

### Từ [artifact-khác] (nếu cần)

```
[Paste đoạn trích chính xác — chỉ phần liên quan]
```

## Đầu ra mong đợi (Expected Output)

- [Section hoặc bảng cụ thể cần tạo/cập nhật]
- [Tiêu chí hoàn thành rõ ràng]
- Nếu thiếu context hoặc scope quá lớn: trả về `NEEDS_REPARTITION` với mô tả section nào bị quá tải và input tối thiểu cần thiết.

## Nhật ký thực thi (Execution Log)

| Thời điểm | Sự kiện | Ghi chú |
| --- | --- | --- |
| [YYYY-MM-DD HH:MM] | queued | Packet được tạo bởi orchestrator |
| [YYYY-MM-DD HH:MM] | running | Worker bắt đầu |
| [YYYY-MM-DD HH:MM] | [completed \| needs-repartition \| failed] | [Kết quả] |

## Antigravity Runtime Note

Khi Antigravity runtime không hỗ trợ các trường nâng cao trong packet này:
- Chỉ sử dụng các trường bắt buộc (Objective, Write Scope, Trace IDs, Upstream Excerpts).
- Các trường tùy chọn (`Optional Runtime Hints`) có thể bỏ qua.
- Không mở rộng contract packet cho đến khi parity được xác nhận.
