# Bản ghi Promotion Bộ nhớ (Memory File-Back Record)

**Record ID:** [FB-{YYMMDD}-{NN}]
**Ngày promotion (Promoted At):** [YYYY-MM-DD]
**Mục tiêu (Promotion Target):** [đường dẫn shard đích]

## Truy vết nguồn (Trace)

| Trường | Giá trị |
| --- | --- |
| source_artifact | [đường dẫn artifact nguồn] |
| source_ids | [FR-01, STR-02, UC-03...] |
| promotion_target | [đường dẫn shard đích] |
| approved_by | [tên hoặc vai trò người phê duyệt] |
| approved_role | [Lead BA / Module BA / End User] |
| approved_at | [YYYY-MM-DD] |
| approval_basis | [lý do phê duyệt] |
| approval_trigger | [sự kiện kích hoạt promotion] |
| impact_ref | [tham chiếu impact run hoặc SHORT_CIRCUIT nếu chỉ là wording-only] |
| supersedes | [Memory ID bị thay thế, nếu có] |
| superseded_by | [con trỏ ngược khi bản thay thế tồn tại, tùy chọn] |

## Nội dung đã promotion (Promoted Content)

[Nội dung cụ thể được thêm vào shard đích]

## Ghi chú

[Bất kỳ ngữ cảnh bổ sung nào cần thiết cho kiểm toán]
