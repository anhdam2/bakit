# Token Budget Baseline

Mục tiêu của file này là khóa trần kích thước cho instruction surface của BA-kit sau refactor `contract + stub + step files`.

- Đơn vị dùng trong CI là `bytes`, không phải token.
- `bytes` được dùng vì ổn định hơn tokenization runtime và đủ tốt để bắt drift sớm.
- Các ngưỡng `max` không phải mục tiêu để lấp đầy; chúng chỉ là guardrail.
- Khi một thay đổi cố ý mở rộng instruction surface, cập nhật cả `baseline` lẫn `max` trong block JSON bên dưới, rồi chạy lại budget check.

## Baseline hiện tại

- Shared entry runtime hiện tại: `core/contract.yaml` + `core/contract-behavior.md` + `skills/ba-start/SKILL.md` = `14,880 bytes`
- Runtime policies hiện tại: `AGENTS.md` + `GEMINI.md` + `CLAUDE.md` = `7,152 bytes`
- Các path đắt nhất hiện tại:
  - `wireframes_bundle` = `19,666 bytes`
  - `srs_wireframe_bundle` = `23,821 bytes`

## Guardrail source

```json
{
  "version": 1,
  "captured_at": "2026-04-09",
  "units": "bytes",
  "files": [
    { "path": "core/contract.yaml", "baseline": 5187, "max": 6500, "label": "machine contract" },
    { "path": "core/contract-behavior.md", "baseline": 6914, "max": 8500, "label": "behavior contract" },
    { "path": "skills/ba-start/SKILL.md", "baseline": 2779, "max": 3500, "label": "ba-start stub" },
    { "path": "skills/ba-start/steps/intake.md", "baseline": 3212, "max": 4000, "label": "intake step" },
    { "path": "skills/ba-start/steps/impact.md", "baseline": 2689, "max": 3300, "label": "impact step" },
    { "path": "skills/ba-start/steps/backbone.md", "baseline": 1225, "max": 1700, "label": "backbone step" },
    { "path": "skills/ba-start/steps/frd.md", "baseline": 1240, "max": 1700, "label": "frd step" },
    { "path": "skills/ba-start/steps/stories.md", "baseline": 1342, "max": 1800, "label": "stories step" },
    { "path": "skills/ba-start/steps/srs.md", "baseline": 1337, "max": 1800, "label": "srs router step" },
    { "path": "skills/ba-start/steps/srs-core.md", "baseline": 2770, "max": 3400, "label": "srs core step" },
    { "path": "skills/ba-start/steps/srs-wireframes.md", "baseline": 2986, "max": 3600, "label": "srs wireframes step" },
    { "path": "skills/ba-start/steps/srs-assembly.md", "baseline": 1848, "max": 2300, "label": "srs assembly step" },
    { "path": "skills/ba-start/steps/wireframes.md", "baseline": 4786, "max": 5600, "label": "wireframes step" },
    { "path": "skills/ba-start/steps/package.md", "baseline": 1809, "max": 2400, "label": "package step" },
    { "path": "skills/ba-start/steps/status.md", "baseline": 1585, "max": 2200, "label": "status step" },
    { "path": "AGENTS.md", "baseline": 2888, "max": 3500, "label": "codex runtime policy" },
    { "path": "GEMINI.md", "baseline": 2504, "max": 3200, "label": "antigravity runtime policy" },
    { "path": "CLAUDE.md", "baseline": 1760, "max": 2500, "label": "claude runtime policy" }
  ],
  "bundles": [
    {
      "name": "runtime_policies",
      "baseline": 7152,
      "max": 8500,
      "paths": ["AGENTS.md", "GEMINI.md", "CLAUDE.md"]
    },
    {
      "name": "shared_entry_runtime",
      "baseline": 14880,
      "max": 17500,
      "paths": ["core/contract.yaml", "core/contract-behavior.md", "skills/ba-start/SKILL.md"]
    },
    {
      "name": "intake_bundle",
      "baseline": 18092,
      "max": 20500,
      "paths": ["core/contract.yaml", "core/contract-behavior.md", "skills/ba-start/SKILL.md", "skills/ba-start/steps/intake.md"]
    },
    {
      "name": "backbone_bundle",
      "baseline": 16105,
      "max": 18500,
      "paths": ["core/contract.yaml", "core/contract-behavior.md", "skills/ba-start/SKILL.md", "skills/ba-start/steps/backbone.md"]
    },
    {
      "name": "status_bundle",
      "baseline": 16465,
      "max": 19000,
      "paths": ["core/contract.yaml", "core/contract-behavior.md", "skills/ba-start/SKILL.md", "skills/ba-start/steps/status.md"]
    },
    {
      "name": "stories_bundle",
      "baseline": 16222,
      "max": 18500,
      "paths": ["core/contract.yaml", "core/contract-behavior.md", "skills/ba-start/SKILL.md", "skills/ba-start/steps/stories.md"]
    },
    {
      "name": "wireframes_bundle",
      "baseline": 19666,
      "max": 22500,
      "paths": ["core/contract.yaml", "core/contract-behavior.md", "skills/ba-start/SKILL.md", "skills/ba-start/steps/wireframes.md"]
    },
    {
      "name": "srs_core_bundle",
      "baseline": 20835,
      "max": 23500,
      "paths": ["core/contract.yaml", "core/contract-behavior.md", "skills/ba-start/SKILL.md", "skills/ba-start/steps/srs.md", "skills/ba-start/steps/srs-core.md", "skills/ba-start/steps/srs-assembly.md"]
    },
    {
      "name": "srs_wireframe_bundle",
      "baseline": 23821,
      "max": 27000,
      "paths": ["core/contract.yaml", "core/contract-behavior.md", "skills/ba-start/SKILL.md", "skills/ba-start/steps/srs.md", "skills/ba-start/steps/srs-core.md", "skills/ba-start/steps/srs-wireframes.md", "skills/ba-start/steps/srs-assembly.md"]
    }
  ]
}
```

## Cách chạy

```bash
scripts/check-token-budget.sh
```

Nếu budget fail, ưu tiên:

1. Gỡ rule trùng lặp khỏi runtime policy files.
2. Tách bớt step file nếu một path cụ thể phình quá nhanh.
3. Đưa phần deterministic sang CLI hoặc manifest machine-readable thay vì prose.
