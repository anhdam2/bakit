# Cách BA-kit hoạt động

## Lifecycle chuẩn

```text
Raw input
-> Intake + Gap Analysis
-> Requirements Backbone
-> FRD / User Stories
-> SRS
-> DESIGN.md + wireframe-input.md + wireframe-map.md
-> User tự tạo wireframe/mockup
-> Final packaging
```

## Nguyên tắc vận hành

### 1. Backbone-first

Sau intake, `backbone` trở thành source of truth chính. Các artifact sau đó phải bám theo backbone thay vì diễn giải lại từ raw input.

### 2. Gated artifact emission

Không phải dự án nào cũng cần sinh mọi artifact với cùng độ sâu. BA-kit chỉ phát hành FRD, stories, SRS hoặc wireframe handoff khi điều kiện phù hợp.

### 3. Exact resolution

Hệ thống ưu tiên:

- `--slug` explicit
- `--date` explicit
- `--module` explicit

BA-kit không được chọn theo mtime hoặc pattern mơ hồ.

### 4. Impact-first cho requirement change

Nếu project đã có artifact và xuất hiện thay đổi requirement, rule, actor hoặc screen behavior, đường đi đúng là `impact` trước, không mutate trực tiếp artifact đích.

### 5. Manual wireframe handoff

Bước `wireframes` không sinh UI cuối. Nó chuẩn bị:

- `designs/{slug}/DESIGN.md`
- `wireframe-input.md`
- `wireframe-map.md`
- `wireframe-state.md`

User hoặc designer sẽ tạo wireframe/mockup ở ngoài và attach ngược lại vào SRS.

## Vai trò của từng lớp

| Lớp | Mục đích |
| --- | --- |
| `core/` | Contract và behavior chuẩn |
| `skills/` | Playbook theo task |
| `templates/` | Khung tài liệu |
| `rules/` | Quality bar và working rules |
| `agents/` | Delegation boundaries |

## Chất lượng tối thiểu

- Mỗi requirement có acceptance criteria
- Use case có primary và alternate flow khi SRS tồn tại
- Screen description có navigation, validation và state
- Recommendation phải gắn với business value, risk hoặc outcome
