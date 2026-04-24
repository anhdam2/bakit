# Token Budget Baseline

Mục tiêu của file này là khóa trần kích thước cho instruction surface của BA-kit sau refactor `contract + stub + step files`.

- Đơn vị dùng trong CI là `bytes`, không phải token.
- `bytes` được dùng vì ổn định hơn tokenization runtime và đủ tốt để bắt drift sớm.
- Các ngưỡng `max` không phải mục tiêu để lấp đầy; chúng chỉ là guardrail.
- Khi một thay đổi cố ý mở rộng instruction surface, cập nhật cả `baseline` lẫn `max` trong block JSON bên dưới, rồi chạy lại budget check.

## Baseline hiện tại

- Shared entry runtime hiện tại: `core/contract.yaml` + `core/contract-behavior.md` + `skills/ba-start/SKILL.md` = `30,246 bytes`
- Runtime policies hiện tại: `AGENTS.md` + `GEMINI.md` + `CLAUDE.md` = `8,845 bytes`
- Các path đắt nhất hiện tại:
  - `wireframes_bundle` = `36,330 bytes`
  - `srs_wireframe_bundle` = `41,370 bytes`

## Guardrail source

```json
{
  "version": 2,
  "captured_at": "2026-04-24",
  "units": "bytes",
  "notes": "Baselines updated after Phase 01-03 memory architecture expansion. contract-behavior.md grew ~2.8x to add Memory Architecture, Activation, Read Scope, and Multi-BA Governance contracts. Step files each grew ~500-900 bytes for Memory Read Scope and Governance Gate sections.",
  "files": [
    { "path": "core/contract.yaml", "baseline": 7925, "max": 9000, "label": "machine contract" },
    { "path": "core/contract-behavior.md", "baseline": 19542, "max": 22000, "label": "behavior contract" },
    { "path": "skills/ba-start/SKILL.md", "baseline": 2779, "max": 3500, "label": "ba-start stub" },
    { "path": "skills/ba-start/steps/intake.md", "baseline": 3526, "max": 4200, "label": "intake step" },
    { "path": "skills/ba-start/steps/impact.md", "baseline": 3804, "max": 4500, "label": "impact step" },
    { "path": "skills/ba-start/steps/backbone.md", "baseline": 2860, "max": 3400, "label": "backbone step" },
    { "path": "skills/ba-start/steps/frd.md", "baseline": 2082, "max": 2500, "label": "frd step" },
    { "path": "skills/ba-start/steps/stories.md", "baseline": 2201, "max": 2600, "label": "stories step" },
    { "path": "skills/ba-start/steps/srs.md", "baseline": 2192, "max": 2600, "label": "srs router step" },
    { "path": "skills/ba-start/steps/srs-core.md", "baseline": 4005, "max": 4600, "label": "srs core step" },
    { "path": "skills/ba-start/steps/srs-wireframes.md", "baseline": 3608, "max": 4200, "label": "srs wireframes step" },
    { "path": "skills/ba-start/steps/srs-assembly.md", "baseline": 2014, "max": 2400, "label": "srs assembly step" },
    { "path": "skills/ba-start/steps/wireframes.md", "baseline": 6084, "max": 7000, "label": "wireframes step" },
    { "path": "skills/ba-start/steps/package.md", "baseline": 2293, "max": 2700, "label": "package step" },
    { "path": "skills/ba-start/steps/status.md", "baseline": 1836, "max": 2200, "label": "status step" },
    { "path": "AGENTS.md", "baseline": 3345, "max": 3900, "label": "codex runtime policy" },
    { "path": "GEMINI.md", "baseline": 3052, "max": 3600, "label": "antigravity runtime policy" },
    { "path": "CLAUDE.md", "baseline": 2448, "max": 2900, "label": "claude runtime policy" }
  ],
  "bundles": [
    {
      "name": "runtime_policies",
      "baseline": 8845,
      "max": 10400,
      "paths": ["AGENTS.md", "GEMINI.md", "CLAUDE.md"]
    },
    {
      "name": "shared_entry_runtime",
      "baseline": 30246,
      "max": 34000,
      "paths": ["core/contract.yaml", "core/contract-behavior.md", "skills/ba-start/SKILL.md"]
    },
    {
      "name": "intake_bundle",
      "baseline": 33772,
      "max": 38000,
      "paths": ["core/contract.yaml", "core/contract-behavior.md", "skills/ba-start/SKILL.md", "skills/ba-start/steps/intake.md"]
    },
    {
      "name": "backbone_bundle",
      "baseline": 33106,
      "max": 37000,
      "paths": ["core/contract.yaml", "core/contract-behavior.md", "skills/ba-start/SKILL.md", "skills/ba-start/steps/backbone.md"]
    },
    {
      "name": "status_bundle",
      "baseline": 32082,
      "max": 36000,
      "paths": ["core/contract.yaml", "core/contract-behavior.md", "skills/ba-start/SKILL.md", "skills/ba-start/steps/status.md"]
    },
    {
      "name": "stories_bundle",
      "baseline": 33247,
      "max": 37000,
      "paths": ["core/contract.yaml", "core/contract-behavior.md", "skills/ba-start/SKILL.md", "skills/ba-start/steps/stories.md"]
    },
    {
      "name": "wireframes_bundle",
      "baseline": 36330,
      "max": 41000,
      "paths": ["core/contract.yaml", "core/contract-behavior.md", "skills/ba-start/SKILL.md", "skills/ba-start/steps/wireframes.md"]
    },
    {
      "name": "srs_core_bundle",
      "baseline": 38543,
      "max": 43000,
      "paths": ["core/contract.yaml", "core/contract-behavior.md", "skills/ba-start/SKILL.md", "skills/ba-start/steps/srs.md", "skills/ba-start/steps/srs-core.md", "skills/ba-start/steps/srs-assembly.md"]
    },
    {
      "name": "srs_wireframe_bundle",
      "baseline": 41370,
      "max": 46000,
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
