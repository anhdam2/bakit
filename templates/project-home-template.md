# Trang điều phối dự án BA (Project Home)

> File này là dashboard thân thiện cho BA non-tech. Nó không thay thế `intake.md`, `backbone.md`, `project-memory.md`, hoặc artifact module. Agent phải dùng file này để định hướng người dùng, nhưng vẫn đọc source-of-truth đúng theo contract trước khi mutate artifact.

**Dự án:** [Tên dự án]
**Slug:** [initiative-slug]
**Phiên bản artifact:** [YYMMDD-HHmm]
**Chế độ:** [lite | hybrid | formal]
**Cập nhật lần cuối:** [YYYY-MM-DD HH:mm]
**Runtime gần nhất:** [claude-code | codex | antigravity | mixed]

## 1. Tôi Đang Ở Đâu?

| Hạng mục | Trạng thái | Ý nghĩa cho BA |
| --- | --- | --- |
| Tiếp nhận yêu cầu | [Todo / Doing / Done] | Đã gom và chuẩn hóa thông tin đầu vào chưa |
| Khung yêu cầu đã chốt | [Todo / Doing / Done] | Đã có source of truth để sinh tài liệu chưa |
| User stories | [Not needed / Todo / Doing / Done] | Có cần bàn giao cho team Agile không |
| FRD | [Not needed / Todo / Doing / Done] | Có cần tài liệu yêu cầu chức năng chi tiết không |
| SRS | [Not needed / Todo / Doing / Done] | Có cần đặc tả hệ thống/use case/screen không |
| Handoff UI | [Not needed / Todo / Doing / Done] | Có cần gói constraint để user tự vẽ mockup không |
| Gói bàn giao HTML | [Not needed / Todo / Done] | Có bản stakeholder review trong browser chưa |

## 2. Bước Tiếp Theo Được Khuyến Nghị

**Nên làm tiếp:** [Mô tả bằng ngôn ngữ BA]

**Lý do:** [Gắn với mục tiêu, rủi ro, hoặc artifact còn thiếu]

**Agent sẽ chạy nội bộ:** `[ba-start/ba-next/ba-impact command equivalent]`

**Nếu bạn không chắc, hãy hỏi agent:** `Tôi nên làm bước nào tiếp theo cho dự án này?`

## 3. Việc Cần User Chốt

| Câu hỏi / Quyết định | Vì sao cần chốt | Nếu chưa chốt thì ảnh hưởng |
| --- | --- | --- |
| [Decision] | [Reason] | [Impact] |

## 4. Bản Đồ Artifact Dễ Hiểu

| Tên BA nhìn thấy | File kỹ thuật | Khi nào dùng |
| --- | --- | --- |
| Trang điều phối dự án | `PROJECT-HOME.md` | Xem trạng thái, bước tiếp theo, câu hỏi cần chốt |
| Phiếu tiếp nhận yêu cầu | `01_intake/intake.md` | Lưu input đã chuẩn hóa và gap |
| Kế hoạch xử lý | `01_intake/plan.md` | Chọn artifact nào cần sinh |
| Khung yêu cầu đã chốt | `02_backbone/backbone.md` | Source of truth sau scope lock |
| Bộ nhớ dự án | `02_backbone/project-memory.md` | Thuật ngữ, quyết định, giả định đã chốt |
| Tài liệu module | `03_modules/{module}/...` | FRD, stories, SRS, UI handoff theo phân hệ |
| Trang cộng tác | `COLLAB-HOME.md` | Ai làm module nào, review status, blocker |
| Bản bàn giao HTML | `04_compiled/*.html` | Stakeholder review/edit trong browser |

## 5. Prompt Nhanh Theo Runtime

### Claude Code

```text
/ba-do Tôi muốn tiếp tục dự án [slug]. Hãy đọc PROJECT-HOME.md và cho tôi bước tiếp theo.
```

### Codex

```text
Use AGENTS.md. Read PROJECT-HOME.md for the BA-facing state, then use the BA-kit contract to run the next safe step for slug [slug].
```

### Antigravity

```text
Đọc PROJECT-HOME.md của dự án [slug], cho tôi biết bước BA tiếp theo và chạy workflow an toàn tương ứng.
```

## 6. Từ Điển Tên Gọi Thân Thiện

| BA nói | Agent hiểu |
| --- | --- |
| Tạo dự án mới / phân tích tài liệu mới | `intake` hoặc full lifecycle |
| Tiếp tục dự án | `ba-next` rồi step được khuyến nghị |
| Khung yêu cầu đã chốt | `backbone` |
| Đánh giá thay đổi | `impact` |
| Chuẩn bị handoff UI | `wireframes` |
| Xuất gói bàn giao | `package` |
| Kiểm tra trạng thái | `status` |
| Nhận module / gửi review / tạo PR | `ba-collab` |

## 7. Lưu Ý An Toàn

- Nếu yêu cầu thay đổi trong lúc đang viết FRD/SRS/UI, agent phải đánh giá ảnh hưởng trước khi sửa.
- Nếu có nhiều phiên bản artifact hoặc nhiều module, agent phải hỏi lại thay vì tự chọn.
- File này là dashboard. Khi có mâu thuẫn, source of truth vẫn là `backbone.md`, sau đó là `intake.md`.
