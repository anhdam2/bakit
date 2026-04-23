# Bắt đầu nhanh

## 1. Clone repository

```bash
git clone https://github.com/anhdam2/bakit.git
cd bakit
```

## 2. Chọn runtime

BA-kit hiện hỗ trợ hai cách dùng chính:

- `Codex`: mở repo trực tiếp và dùng `AGENTS.md`
- `Claude Code`: chạy installer để copy assets vào `~/.claude`

## 3. Dùng ngay với Codex

Chỉ cần mở repo này trong Codex. Với các tác vụ BA không rõ bước, bắt đầu bằng router:

```text
Use AGENTS.md and skills/ba-do/SKILL.md.
Route this BA request to the correct BA-kit command.
```

Nếu đã biết bước lifecycle:

```text
Use AGENTS.md and skills/ba-start/SKILL.md.
Run the equivalent of /ba-start backbone --slug warehouse-rfp.
```

## 4. Cài cho Claude Code

```bash
./install.sh
```

Sau khi cài, restart Claude Code nếu đang mở.

## 5. Các lệnh chính

```text
/ba-start
/ba-start intake <file>
/ba-start backbone --slug <slug>
/ba-start frd --slug <slug> --module <module_slug>
/ba-start stories --slug <slug> --module <module_slug>
/ba-start srs --slug <slug> --module <module_slug>
/ba-start wireframes --slug <slug> --module <module_slug>
/ba-start package --slug <slug>
/ba-start status --slug <slug>
```

## 6. Khi nào dùng `ba-do`

Dùng `ba-do` khi người dùng mô tả nhu cầu theo ngôn ngữ tự nhiên, ví dụ:

```text
/ba-do đang làm dở SRS thì có thêm yêu cầu audit log
/ba-do publish SRS lên Notion
/ba-do xem next step cho project này
```

## 7. Runtime defaults

- Ngôn ngữ mặc định: tiếng Việt
- Mode mặc định: `hybrid`
- UI baseline mặc định: `Shadcn UI` nếu `DESIGN.md` chưa override

## 8. Lưu ý quan trọng

- Không sửa artifact downstream trực tiếp từ một câu correction ngắn; route qua `impact` trước.
- Không đoán slug, date hoặc module theo file mới nhất.
- `plans/` là workspace runtime, không phải source content của chính toolkit.
