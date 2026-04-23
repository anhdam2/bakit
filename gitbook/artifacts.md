# Artifacts và đầu ra

## Cấu trúc chính

```text
plans/
  {slug}-{date}/
    01_intake/
    02_backbone/
    03_modules/{module_slug}/
    04_compiled/

designs/
  {slug}/DESIGN.md
```

## Artifact theo lifecycle

| Artifact | Mục đích |
| --- | --- |
| `intake.md` | Chuẩn hóa input và bộc lộ gap |
| `plan.md` | Kế hoạch thực hiện và các gate |
| `backbone.md` | Source of truth sau scope lock |
| `frd.md` | Mô tả functional requirements theo cấu trúc formal |
| `user-stories.md` | Epic / feature / story với acceptance criteria |
| `srs.md` | Đặc tả hành vi hệ thống, use case, screen, NFR |
| `DESIGN.md` | Design governance ở mức project |
| `wireframe-input.md` | Constraint pack ở mức screen |
| `wireframe-map.md` | Checklist handoff để user attach mockup |
| `wireframe-state.md` | Trạng thái explicit của wireframe flow |
| `compiled-frd.html` | Bản HTML để review/chia sẻ |
| `compiled-srs.html` | Bản HTML để review/chia sẻ |

## DESIGN.md dùng để làm gì

`DESIGN.md` không phải mockup cuối. Nó khóa:

- visual tone
- màu sắc và typography
- layout principles
- navigation schema
- shared components
- responsive behavior
- anti-patterns

## Wireframe handoff pack

BA-kit tách rõ:

- BA-kit chuẩn bị constraint và mapping
- user/designer tự tạo mockup
- mockup được attach lại vào SRS

Cách làm này giữ mockup không trở thành source of truth.

## Trạng thái wireframe

Giá trị hợp lệ:

- `completed`
- `skipped`
- `not-applicable`
- `missing`
