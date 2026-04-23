# BA-kit

BA-kit là playbook Business Analysis cho môi trường AI agents như Claude Code, Codex, và Antigravity. Mục tiêu của repo này là biến agent thành một BA có quy trình rõ ràng, artifact có cấu trúc, và handoff đủ chuẩn để không phải “nhắc prompt thủ công” ở mỗi dự án.

## Flow hiện tại

Lifecycle chuẩn của BA-kit:

```text
Raw input
-> Intake + Gap Analysis
-> Requirements Backbone
-> FRD / Stories / Use Cases + Screen Contract Plus
-> DESIGN.md + wireframe-input.md + wireframe-map.md
-> User tự tạo mockup / wireframe
-> Final SRS + HTML package
```

Điểm quan trọng:
- `/ba-start wireframes` vẫn giữ nguyên tên command để tương thích ngược.
- Nhưng Step 9 không còn gọi MCP để generate UI.
- Step 9 chỉ chuẩn bị bộ handoff cho wireframe thủ công:
  - `designs/{slug}/DESIGN.md`
  - `plans/{slug}-{date}/03_modules/{module_slug}/wireframe-input.md`
  - `plans/{slug}-{date}/03_modules/{module_slug}/wireframe-map.md`
  - `plans/{slug}-{date}/03_modules/{module_slug}/wireframe-state.md`

## Vai trò từng artifact

- `DESIGN.md`
  Dùng để khóa design tổng thể: visual tone, màu sắc, typography, layout principles, navigation schema, menu/header/footer, component patterns, responsive rules, anti-patterns.

- `wireframe-input.md`
  Dùng để khóa constraint ở mức màn hình/flow: màn hình nào phải có, portal/menu schema nào phải theo, state nào phải thể hiện, action/label nào là non-negotiable, và active-menu evidence nào phải xuất hiện.

- `wireframe-map.md`
  Dùng làm checklist handoff: screen nào user phải tự vẽ, supporting states nào cần có, và sau khi vẽ xong thì phải attach hình/link vào đâu trong SRS.

- `SRS`
  Là nơi chứa Use Case, Screen Contract Plus, Screen Inventory, và phần mô tả màn hình chi tiết. BA-kit/BA viết phần screen descriptions; user chỉ tự attach mockup thủ công vào section tương ứng.

## Ai làm gì

- BA-kit / BA:
  - viết intake, backbone, FRD, stories, SRS core
  - sinh `DESIGN.md`, `wireframe-input.md`, `wireframe-map.md`
  - viết `Screen Descriptions` trong SRS như pha enrich sau wireframe, không tái định nghĩa portal/menu đã khóa

- User / Designer:
  - dựa trên `DESIGN.md`, `wireframe-input.md`, Use Case, Screen Contract Plus, Screen Inventory để tự tạo wireframe/mockup
  - tự dán image/link/mockup vào đúng section trong SRS

Mockup không phải source of truth. Source of truth vẫn là backbone, Use Case, Screen Contract Plus, Screen Inventory, và Screen Descriptions trong SRS.

## Cấu trúc thư mục

```text
plans/
  {slug}-{date}/
    01_intake/
    02_backbone/
    03_modules/
      {module_slug}/
        frd.md
        user-stories.md
        srs.md
        srs-group-a.md
        srs-group-b.md
        srs-group-c.md
        wireframe-input.md
        wireframe-map.md
        wireframe-state.md
    04_compiled/

designs/
  {slug}/
    DESIGN.md
```

## Teamwork và modular architecture

BA-kit hỗ trợ làm việc nhóm bằng Git theo 2 tầng:
- System-level:
  - `01_intake/`
  - `02_backbone/`
- Module-level:
  - `03_modules/{module_slug}/`

Quy tắc quan trọng:
- Các module không được tự định nghĩa global navigation, portal actors, hay UX direction riêng.
- Những quyết định dùng chung phải được khóa ở `02_backbone` qua `Portal Matrix` và ở `designs/{slug}/DESIGN.md` qua `Navigation Schema`.
- `/ba-start wireframes --module ...` chỉ chuẩn bị constraint/handoff cho module đó; nó không tự sinh mockup.

## Cài đặt nhanh

### Claude Code

```bash
git clone https://github.com/anhdam2/bakit.git
cd bakit
./install.sh
```

Sau đó restart Claude Code. Claude sẽ dùng:
- `CLAUDE.md`
- `skills/`
- `rules/`
- `templates/`
- shared core trong `~/.claude/ba-kit/`

### Codex

Mở repo này trực tiếp trong Codex là dùng được ngay qua `AGENTS.md`.

Nếu muốn cài bundle lâu dài:

```bash
bash scripts/install-codex-ba-kit.sh
```

### Antigravity

```bash
bash scripts/install-antigravity-ba-kit.sh
```

Script này:
- cài CLI `ba-kit`
- ghi installation manifest
- tạo Knowledge Item workflow cho Antigravity dựa trên flow manual wireframe handoff hiện tại

## Ví dụ sử dụng

### Claude Code

```text
/ba-start
/ba-start backbone --slug hr-app
/ba-start srs --slug hr-app --module auth-flow
/ba-start wireframes --slug hr-app --module auth-flow
/ba-start status --slug hr-app
```

Ý nghĩa của bước `wireframes`:
- hỏi/chốt `DESIGN.md` nếu cần
- build `wireframe-input.md`
- build `wireframe-map.md`
- đánh dấu `wireframe-state.md`
- không generate hình UI

### Codex

```text
Use AGENTS.md and skills/ba-start/SKILL.md.
Build the requirements backbone first, then emit FRD, stories, SRS core, and manual wireframe handoff artifacts.
Do not generate wireframes directly. Let the user create and attach the final mockup manually.
```

### Antigravity

```text
Read skills/ba-start/SKILL.md and run srs for slug warehouse-rfp module auth-flow.
Then run wireframes for the same target, but only prepare DESIGN.md, wireframe-input.md, and wireframe-map.md.
The user will create and attach the mockup manually.
```

## Nâng cấp

```bash
ba-kit doctor
ba-kit update
```

`ba-kit doctor` kiểm tra runtime readiness và `ba-kit update` sẽ refresh các runtime đã cài mà không đụng vào artifact dự án.

## Tài liệu nên đọc tiếp

- [GitBook-ready Docs](gitbook/documentation/README.md)
- [Getting Started](docs/getting-started.md)
- [Codex Setup](docs/codex-setup.md)
- [Skill Catalog](docs/skill-catalog.md)
- [BA Methodology Guide](docs/ba-methodology-guide.md)
- [Design Artifacts](designs/README.md)
