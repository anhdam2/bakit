# Cài Đặt và Cấu Hình Antigravity

Antigravity hoạt động dựa trên cơ chế nạp bối cảnh hệ thống (system context). Nó có khả năng ghi nhớ dài hạn bằng bộ nhớ kiến thức (Knowledge Items - KIs), do đó, BA-kit chạy rất mạnh trên hệ máy này.

## Cách Dùng Trực Tiếp (Repo Native)

Nếu bạn chỉ cần mượn repo này để bắt đầu công việc:
1. Mở IDE kết nối với Antigravity.
2. Trỏ đường viền vào gốc của repo BA-kit.
3. Antigravity sẽ tự động đọc cấu trúc chỉ thị ở `GEMINI.md` (báo cáo quyền hạn) và `AGENTS.md` (mạng lưới routing).
4. Chat câu lệnh tiếng việt bình thường để làm việc:
```text
"Tạo cấu trúc workflow cho ứng dụng web bán sách"
```

## Cách Tích Hợp Sâu (Lưu Bộ Nhớ Cứng)

Nếu bạn muốn Antigravity của bạn "nạp" luôn bộ não BA-kit vào sâu bên trong tủy sống để xài lúc nào cũng được:
Chạy lệnh gốc này ở màn hình Terminal:
```bash
bash scripts/install-antigravity-ba-kit.sh
```
Nó sẽ:
1. Khởi tạo một Gói Kiến Thức `ba-kit-workflow` KI vào `~/.gemini/antigravity/knowledge/`.
2. Gắn lệnh tiện ích `ba-kit` vào `~/.local/bin`. 
3. Lưu vết cài đặt vào Data Tracking Manifest để nâng cấp về sau bằng lệnh `ba-kit update`.

## Routing Và Kích Hoạt Prompt
Trái với Claude (dùng dấu gạch chéo `/`), Antigravity định tuyến luồng công việc của bạn bằng ngôn ngữ tự nhiên tiếng Việt mượt mà. Đội ngũ phát triển đã nhúng sâu Auto-routing detection rule.

Chỉ cần gõ:
- "Impact đánh giá rủi ro cho chức năng xuất file PDF" (Kích hoạt change management)
- "Status của dự án QL Kho" (Kích hoạt kiểm thử độ hoàn chỉnh file document).
- "Chạy gói FRD" (Kích hoạt bộ kỹ năng xây dựng yêu cầu tính năng). 
