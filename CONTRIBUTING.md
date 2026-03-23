# Contributing

## Principles

- Keep BA-kit practical and reusable.
- Prefer template-backed workflows over ad hoc prose.
- Preserve traceability between goals, requirements, and outputs.
- Use Mermaid for diagrams.

## Change Areas

When you add or change a skill:
- update the relevant file under `skills/`
- update [docs/skill-catalog.md](./docs/skill-catalog.md) if usage changes
- update templates or rules if the workflow contract changes

When you add or change a template:
- keep it ready-to-fill, not overexplained
- keep related-template links current
- ensure at least one skill clearly points to it

## Verification

Before opening a pull request:
- run `bash -n install.sh`
- test `./install.sh` in a temporary `HOME` if you changed install behavior
- check internal paths and links you touched

## Pull Requests

- Keep scope focused.
- Explain user-facing workflow changes clearly.
- Call out any new assumptions about Claude runtime paths or installation layout.
