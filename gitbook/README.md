# BA-kit

BA-kit là playbook Business Analysis dành cho môi trường AI agents như Codex và Claude Code. Sản phẩm này chuẩn hóa quy trình BA từ đầu vào thô đến bộ tài liệu bàn giao có cấu trúc, giúp analyst hoặc product owner không phải dựng lại framework làm việc ở mỗi dự án.

## BA-kit giải quyết vấn đề gì

Các coding agent rất mạnh ở implementation, nhưng BA lại cần một lớp vận hành khác:

- chuẩn hóa intake và gap analysis
- khóa scope trước khi tách artifact
- giữ một source of truth xuyên suốt
- sinh artifact có traceability và acceptance criteria
- hỗ trợ handoff sang thiết kế và kỹ thuật

BA-kit bổ sung đúng lớp đó bằng workflow, template, rule và agent boundary rõ ràng.

## Giá trị cốt lõi

- Giảm thời gian setup cho BA work trong môi trường agent
- Tăng độ nhất quán giữa intake, backbone, FRD, stories và SRS
- Giữ traceability từ business goal đến testable output
- Hỗ trợ solo IT BA theo mặc định với `hybrid` mode
- Tách rõ phần BA tạo và phần user/designer tự hoàn thiện

## Thành phần chính

| Thành phần | Vai trò |
| --- | --- |
| `skills/ba-start/` | Điều phối toàn bộ lifecycle BA |
| `skills/ba-do/` | Router cho yêu cầu BA tự nhiên |
| `templates/` | Mẫu tài liệu chuẩn hóa |
| `rules/` | Quy tắc chất lượng và workflow |
| `designs/` | Nơi lưu `DESIGN.md` theo từng project |
| `agents/` | Biên giới chuyên môn cho delegation |
| `AGENTS.md` | Repo instruction để Codex vận hành đúng playbook |

## Kết quả đầu ra điển hình

- Intake form
- Work plan
- Requirements backbone
- FRD
- User stories
- SRS
- `DESIGN.md`
- `wireframe-input.md`
- `wireframe-map.md`
- HTML package để chỉnh sửa/bàn giao

## Ai nên dùng

- Business analyst
- Product manager đang làm BA
- Solo consultant
- Team discovery và pre-sales solutioning

Đi tiếp:

- [Tổng quan sản phẩm](product-overview.md)
- [Bắt đầu nhanh](getting-started.md)
- [Cách BA-kit hoạt động](how-it-works.md)
