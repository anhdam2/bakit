# Dùng với Codex

## Cách BA-kit chạy trong Codex

Codex dùng repo này như một BA operating guide:

- `AGENTS.md` giữ instruction bền vững ở cấp repo
- `skills/` là playbook cần đọc theo đúng task
- `templates/` là nguồn tạo artifact
- `core/` định nghĩa path, prerequisite và behavior

## Flow khuyến nghị

1. Với yêu cầu BA tự nhiên, bắt đầu bằng `ba-do`.
2. Khi step đã rõ, dùng `ba-start`.
3. Khi requirement thay đổi trong lúc đang làm artifact downstream, route qua `impact`.
4. Khi muốn biết bước kế tiếp, dùng `ba-next`.

## Prompt mẫu

### Router

```text
Use AGENTS.md and skills/ba-do/SKILL.md.
Route this BA request to the right BA-kit command:
"Đang làm dở SRS thì thêm yêu cầu export CSV phải ghi audit log."
```

### Full workflow

```text
Use AGENTS.md and skills/ba-start/SKILL.md.
Parse the requirements in docs/raw/warehouse-rfp.pdf.
Build the requirements backbone first, then emit FRD, stories, SRS, and manual wireframe handoff artifacts only when justified.
```

### Impact

```text
Use AGENTS.md and skills/ba-start/SKILL.md.
Run the equivalent of /ba-start impact --slug warehouse-rfp.
Resolve the exact dated set. Do not choose by mtime.
Tell me affected artifacts and the exact next command.
```

## Quy tắc cần nhớ

- Không dùng broad filename matching để chọn artifact
- Không mutate trực tiếp artifact từ một correction statement ngắn
- Với rerun mutating step, cần explicit overwrite approval nếu target đã tồn tại
- Deliverable mặc định viết bằng tiếng Việt
