# Trang cộng tác BA (Collab Home)

> Dashboard cộng tác cho BA non-tech. File này giúp hiểu ai đang làm module nào và trạng thái review. Git branch/commit/PR là implementation detail, không phải workflow chính cho BA.

**Dự án:** [Tên dự án]
**Slug:** [initiative-slug]
**Phiên bản artifact:** [YYMMDD-HHmm]
**Lead BA:** [Tên / TBD]
**Cập nhật lần cuối:** [YYYY-MM-DD HH:mm]

## 1. Trạng Thái Cộng Tác

| Module | Module BA | Trạng thái BA | Review | Blocker / Phụ thuộc | Bước tiếp theo |
| --- | --- | --- | --- | --- | --- |
| [module-slug] | [Tên / TBD] | [unassigned / assigned / in-progress / ready-for-review / changes-requested / approved / integrated / blocked] | [none / local-packet / draft-pr / review-requested / changes-requested / approved / merged / conflict] | [none / mô tả] | [next action] |

## 2. Quy Tắc Cho BA

- BA chỉ cần nói intent nghiệp vụ: nhận module, gửi review, cập nhật feedback, kiểm tra conflict, tổng hợp module đã duyệt.
- Agent phải map intent sang workflow an toàn và hiển thị kế hoạch ngắn trước khi có side effect bên ngoài.
- Không commit, push, tạo PR, merge, hoặc request reviewer nếu user chưa approve rõ.
- Nếu thay đổi chạm scope, actor, rule, navigation, hoặc module khác, route `impact` trước.

## 3. Vùng Sở Hữu

| Layer | Owner | Được sửa bởi | Ghi chú |
| --- | --- | --- | --- |
| Global scope / backbone / DESIGN.md | Lead BA | Lead BA | Module BA phải escalate nếu muốn đổi |
| Module artifacts | Module BA | Module BA được assign | Chỉ trong `03_modules/{module}` |
| Cross-module decision | Lead BA | Lead BA sau impact | Không tự sửa từ module branch |

## 4. Prompt Nhanh

```text
Tôi nhận module [module]
Kiểm tra module [module] trước khi gửi review
Tôi làm xong module [module], gửi Lead BA review
Cập nhật module [module] theo feedback
Lead BA review các module đang chờ duyệt
Tổng hợp các module đã approve
```

## 5. GitHub Mapping Nội Bộ

| BA thấy | Agent/GitHub hiểu |
| --- | --- |
| assigned / in-progress | working branch or local workspace |
| ready-for-review | review packet, optional draft PR |
| changes-requested | reviewer feedback pending |
| approved | review passed, ready to integrate |
| integrated | merged or assembled into compiled output |
| conflict | Git conflict or BA scope conflict needs resolution |
