# Trang module BA (Module Home)

> Dashboard riêng cho một Module BA. File này nói rõ phạm vi được sửa, checklist trước review, và cách gửi Lead BA mà không cần hiểu Git trước.

**Dự án:** [Tên dự án]
**Slug:** [initiative-slug]
**Module:** [module-slug]
**Module BA:** [Tên / TBD]
**Lead BA:** [Tên / TBD]
**Trạng thái BA:** [unassigned | assigned | in-progress | ready-for-review | changes-requested | approved | integrated | blocked]
**Review:** [none | local-packet | draft-pr | review-requested | changes-requested | approved | merged | conflict]
**Cập nhật lần cuối:** [YYYY-MM-DD HH:mm]

## 1. Phạm Vi Được Sửa

| Được sửa | Không được sửa nếu chưa escalate |
| --- | --- |
| `03_modules/{module_slug}/frd.md` | `02_backbone/backbone.md` |
| `03_modules/{module_slug}/user-stories.md` | `designs/{slug}/DESIGN.md` |
| `03_modules/{module_slug}/srs.md` | module khác trong `03_modules/` |
| `03_modules/{module_slug}/wireframe-input.md` | hot/global memory shards |
| `03_modules/{module_slug}/wireframe-map.md` | compiled output khi chưa assemble |

## 2. Checklist Trước Khi Gửi Review

- Artifact nằm đúng module scope.
- Không tự đổi actor, portal, global menu, UX direction, hoặc shared rule.
- Requirement có acceptance criteria hoặc validation guidance.
- Rule code `CR-*` và message code `MSG-*` không trùng với module khác theo thông tin hiện có.
- Nếu có thay đổi requirement/scope/rule: đã chạy impact hoặc ghi rõ cần impact.
- Cross-module dependency đã được ghi bên dưới.

## 3. Phụ Thuộc / Rủi Ro Chéo Module

| Item | Module liên quan | Trace ID | Trạng thái | Cần Lead BA quyết định |
| --- | --- | --- | --- | --- |
| [dependency] | [module] | [FR/UC/SCR/CR/MSG] | [none / pending / blocked / resolved] | [yes / no] |

## 4. Review Notes

| Lần review | Người review | Kết quả | Việc cần làm |
| --- | --- | --- | --- |
| [YYYY-MM-DD] | [Lead BA] | [approved / changes-requested] | [notes] |

## 5. Prompt Nhanh

```text
Kiểm tra module này trước khi gửi review
Tôi làm xong module này, tạo review packet
Cập nhật module này theo feedback
Module này có conflict với module khác không?
```
