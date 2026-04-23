# Đồng bộ với GitBook

## Mục tiêu

Thư mục `gitbook/` được tạo để có thể sync riêng vào GitBook mà không phụ thuộc vào toàn bộ repository tree.

## Cách dùng khuyến nghị

1. Tạo một space mới trong GitBook.
2. Kết nối repository GitHub chứa BA-kit bằng Git Sync.
3. Chọn thư mục `gitbook/` làm nguồn sync nếu GitBook cho phép chọn subfolder trong luồng import hiện tại.
4. Dùng `SUMMARY.md` để giữ navigation ổn định.

Tham khảo chính thức:

- Git Sync: https://gitbook.com/docs/getting-started/git-sync

## Vì sao có `SUMMARY.md`

GitBook vẫn hỗ trợ điều hướng từ file `SUMMARY.md` trong luồng Git Sync/import markdown. Cách này phù hợp khi muốn kiểm soát sidebar từ chính repository.

## Khuyến nghị vận hành

- Xem `gitbook/` như product docs public-facing
- Giữ `docs/` cho tài liệu kỹ thuật hoặc nội bộ chi tiết hơn
- Khi thêm trang mới vào GitBook, cập nhật `SUMMARY.md` cùng lúc
- Tránh đưa `plans/` vào GitBook vì đó là runtime workspace theo từng engagement

## Nội dung nên bổ sung tiếp

- FAQ
- Troubleshooting
- Ví dụ end-to-end theo một project mẫu
- Hướng dẫn publish Notion và handoff cho stakeholder
