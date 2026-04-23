# Dùng với Claude Code

## Cài đặt

Từ root của repository:

```bash
./install.sh
```

Script sẽ copy skill, rule, template và shared workflow vào runtime của Claude Code.

## Entry points chính

```text
/ba-do <mô tả BA task>
/ba-start
/ba-start status --slug <slug>
/ba-notion srs --slug <slug> --page <url> --mode overwrite
```

## Khi nào dùng từng lệnh

| Lệnh | Dùng khi nào |
| --- | --- |
| `ba-do` | Yêu cầu BA tự do, chưa rõ cần step nào |
| `ba-start` | Chạy lifecycle đầy đủ hoặc rerun step cụ thể |
| `ba-notion` | Publish artifact markdown sang Notion |
| `ba-kit-update` | Cập nhật runtime BA-kit đã cài |

## Quy tắc vận hành

- Nếu có nhiều `slug`, hệ thống phải dừng và hỏi rõ
- Nếu một `slug` có nhiều dated set, hệ thống phải dừng và hỏi rõ
- Nếu context bị trôi, phục hồi từ artifact trên đĩa thay vì yêu cầu user nhắc lại từ đầu
- Nếu delegation bị stall, chỉ rerun slice bị nghẽn
