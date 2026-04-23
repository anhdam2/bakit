# Tổng quan sản phẩm

## BA-kit là gì

BA-kit là toolkit giúp AI agents làm Business Analysis theo một quy trình có kiểm soát. Thay vì chỉ trả lời theo prompt ngắn hạn, agent được đặt vào một operating model có:

- canonical contract
- workflow routing rõ ràng
- template chuẩn
- artifact gating
- quality bar có thể kiểm tra được

## Bài toán sản phẩm

Trong nhiều dự án, phần BA bị rơi vào hai thái cực:

- quá thủ công, phụ thuộc vào kinh nghiệm cá nhân
- hoặc quá mơ hồ, tài liệu sinh ra không trace được về scope ban đầu

BA-kit xử lý vấn đề đó bằng cách đặt `backbone` làm source of truth sau intake, rồi chỉ phát sinh downstream artifacts khi có đủ điều kiện.

## Mục tiêu

- Làm cho workflow BA có thể lặp lại giữa nhiều dự án
- Giảm việc viết lại template và checklist
- Tăng độ rõ của handoff cho design và engineering
- Giữ deliverable ở mức decision-ready, không chỉ là prose

## Điểm khác biệt

1. Dùng một lifecycle thống nhất thay vì nhiều prompt rời rạc.
2. Ưu tiên `backbone` trước khi sinh FRD, stories, SRS.
3. Hỗ trợ manual wireframe handoff thay vì giả định agent tự sinh mockup cuối.
4. Phân tách rõ quy tắc repo, rule, template và execution behavior.

## In scope

- Intake và gap analysis
- Scope lock và planning
- Requirements backbone
- FRD, user stories, SRS
- `DESIGN.md` và wireframe handoff pack
- Packaging HTML để bàn giao

## Out of scope

- Full project management automation
- Code implementation cho delivery team
- UI mockup generation như output mặc định
- Domain/regulatory reasoning chuyên sâu ngoài starter guidance

## Đối tượng sử dụng

- BA solo trong team IT
- PM kiêm BA
- Team tư vấn discovery
- Solution analyst
