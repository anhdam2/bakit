# Dùng với Antigravity

## Antigravity khác gì so với Claude Code và Codex

Antigravity không dùng slash command như Claude Code. Nó hoạt động bằng prompt tự nhiên và system context, nên BA-kit phải được gọi bằng câu lệnh mô tả thay vì `/ba-start`.

Điểm quan trọng:

- Antigravity đọc `GEMINI.md` và `AGENTS.md` khi làm việc repo-native
- Có thể cài sâu bằng Knowledge Item qua installer
- Có prompt equivalent cho `ba-do`, `ba-start`, `impact`, `status`, `next`
- Không có auto-delegation behavior giống Claude/Codex

## Cách 1: Dùng repo-native

Phù hợp khi anh chỉ muốn mở repo và dùng ngay.

1. Mở Antigravity trong workspace của repo BA-kit.
2. Đảm bảo nó thấy `GEMINI.md` và `AGENTS.md`.
3. Viết prompt bằng tiếng Việt hoặc tiếng Anh mô tả step cần chạy.

Ví dụ:

```text
Read skills/ba-do/SKILL.md and route: đang làm dở SRS thì có thêm yêu cầu audit log
```

```text
Read skills/ba-start/SKILL.md and run srs for slug warehouse-rfp module auth-flow
```

## Cách 2: Cài runtime

```bash
bash scripts/install-antigravity-ba-kit.sh
```

Installer sẽ:

1. Tạo Knowledge Item `ba-kit-workflow`
2. Cài CLI `ba-kit` vào `~/.local/bin`
3. Ghi install manifest để dùng `ba-kit update` về sau

## Mapping từ Claude command sang Antigravity prompt

| Claude-style | Antigravity equivalent |
| --- | --- |
| `/ba-start` | `Read skills/ba-start/SKILL.md and run the full BA workflow` |
| `/ba-start intake <file>` | `Read skills/ba-start/SKILL.md and run intake for <file>` |
| `/ba-start impact --slug X` | `Read skills/ba-start/SKILL.md and run impact for slug X` |
| `/ba-do <description>` | `Read skills/ba-do/SKILL.md and route: <description>` |
| `/ba-next --slug X` | `Read skills/ba-next/SKILL.md and inspect slug X` |

## Flow khuyến nghị

1. Nếu task mơ hồ, bắt đầu bằng `ba-do`.
2. Nếu step đã rõ, gọi thẳng `ba-start`.
3. Nếu requirement thay đổi giữa chừng, chạy `impact`.
4. Nếu chỉ muốn xem tiến độ hoặc artifact còn thiếu, chạy `status` hoặc `ba-next`.

## Ví dụ prompt thực tế

### Full workflow

```text
Read skills/ba-start/SKILL.md and run the full BA workflow.
Use hybrid mode for a solo IT BA.
Parse the requirements in docs/raw/warehouse-rfp.pdf.
```

### Impact

```text
Read skills/ba-start/SKILL.md and run impact for slug warehouse-rfp.
New requirement: Export CSV must require permission, write an audit log, and show a success or failure banner.
```

### Status

```text
Read skills/ba-start/SKILL.md and run status for slug warehouse-rfp.
Report missing artifacts, wireframe state, and any stalled delegation tracker.
```

## Điều cần nhớ

- Antigravity đã sync core workflow với Claude Code và Codex
- Nhưng không có slash commands native
- Agent roles hiện mang tính reference, không phải auto-delegation runtime
- Flow manual wireframe handoff vẫn giống các runtime còn lại: chuẩn bị `DESIGN.md`, `wireframe-input.md`, `wireframe-map.md`, rồi để user tự attach mockup
