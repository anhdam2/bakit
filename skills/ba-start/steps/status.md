# BA Start Step - Status

This step requires:

- `core/contract.yaml`
- `core/contract-behavior.md`

## Scope

Inspect the selected project set and print a checklist with artifact status, last-modified date, and any active delegated worker slices.

## Prerequisites

- Resolve slug and date using the shared contract.
- If slug or date resolution is ambiguous, stop and ask.

## Output Format

Print a checklist like this:

```text
Project: {slug}
Date set: {date}

[System Paths]
- [x] 01_intake/intake.md — 2026-03-26
- [x] 01_intake/plan.md — 2026-03-26
- [x] 02_backbone/backbone.md — 2026-03-26

[Module: auth-flow]
- [x] 03_modules/auth-flow/frd.md — 2026-03-26
- [x] 03_modules/auth-flow/user-stories.md — 2026-03-26
- [ ] 03_modules/auth-flow/srs.md — missing
- [ ] 03_modules/auth-flow/wireframe-input.md — missing

[Compiled]
- [x] 04_compiled/compiled-frd.html — 2026-03-26
- [x] 04_compiled/compiled-srs.html — 2026-03-26

[Designs]
- [ ] designs/{slug}/DESIGN.md — missing
- [!] wireframes — skipped — 2026-03-26
```

Status rules:

- For regular artifacts, print `exists` or `missing` with the last-modified date when present.
- For wireframes, print the explicit wireframe state plus the marker date.
- When wireframes are `completed`, also list the detected runtime design file, input pack, wireframe map, `.pen` artifacts, and export folders under `paths.design_root`.
- For delegated slices under `paths.delegation_root`, print the tracker state directly and mark `likely stalled` when the last heartbeat exceeds `states.stall_after_minutes`.
