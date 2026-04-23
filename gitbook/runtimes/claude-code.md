# Dùng với Claude Code

## Cài đặt

Từ root của repository:

```bash
./install.sh
```

Script sẽ copy skill, rule, template và shared workflow vào runtime của Claude Code.

## Cách vận hành trong Claude Code

Claude Code là runtime có mức tương thích cao nhất với BA-kit vì hỗ trợ slash command style và đọc trực tiếp các instruction đã cài trong `~/.claude`.

Sau khi cài, BA-kit có 2 entry point chính:

- `ba-do` cho yêu cầu BA tự nhiên
- `ba-start` cho lifecycle step rõ ràng

## Entry points chính

```text
/ba-do <mô tả BA task>
/ba-start
/ba-start status --slug <slug>
/ba-notion srs --slug <slug> --page <url> --mode overwrite
```

## Khi nào dùng `ba-do` và khi nào dùng `ba-start`

### Dùng `ba-do`

Dùng khi anh chưa muốn tự quyết step. Ví dụ:

```text
/ba-do đang làm dở SRS thì có thêm yêu cầu audit log
/ba-do xem next step cho project này
/ba-do publish SRS lên Notion
```

### Dùng `ba-start`

Dùng khi anh đã biết chính xác workflow cần chạy:

```text
/ba-start
/ba-start backbone --slug warehouse-rfp
/ba-start stories --slug warehouse-rfp --module auth-flow
/ba-start srs --slug warehouse-rfp --module auth-flow
```

## Khi nào dùng từng lệnh

| Lệnh | Dùng khi nào |
| --- | --- |
| `ba-do` | Yêu cầu BA tự do, chưa rõ cần step nào |
| `ba-start` | Chạy lifecycle đầy đủ hoặc rerun step cụ thể |
| `ba-notion` | Publish artifact markdown sang Notion |
| `ba-kit-update` | Cập nhật runtime BA-kit đã cài |

## Flow khuyến nghị

1. Đưa raw requirement hoặc business context vào Claude Code.
2. Cho BA-kit chạy `intake` và khóa scope.
3. Sinh `backbone` trước mọi artifact formal.
4. Chỉ sinh FRD, stories, SRS khi gate phù hợp.
5. Nếu có UI scope, chuẩn bị `DESIGN.md` và wireframe handoff pack.
6. Để user/designer tự tạo mockup cuối và attach lại vào SRS.

## Ví dụ prompt thực tế

### Full workflow

```text
/ba-start
Use hybrid mode for a solo IT BA.
Parse the requirements in docs/raw/warehouse-rfp.pdf.
Build the backbone first, then emit downstream artifacts only when justified.
```

### Step-level rerun

```text
/ba-start wireframes --slug warehouse-rfp --module auth-flow
Reuse the approved DESIGN.md if it already exists.
Do not regenerate FRD or stories.
```

### Change impact

```text
/ba-start impact --slug warehouse-rfp
New requirement: Export CSV must require permission, write an audit log, and show a success or failure banner.
```

## Quy tắc vận hành quan trọng

- Nếu có nhiều `slug`, hệ thống phải dừng và hỏi rõ
- Nếu một `slug` có nhiều dated set, hệ thống phải dừng và hỏi rõ
- Nếu context bị trôi, phục hồi từ artifact trên đĩa thay vì yêu cầu user nhắc lại từ đầu
- Nếu delegation bị stall, chỉ rerun slice bị nghẽn
- Không sửa artifact downstream trực tiếp từ một correction statement ngắn; route qua `impact` trước
- Deliverable mặc định viết bằng tiếng Việt nếu anh không yêu cầu tiếng Anh
