# Contributing

## Principles

- Keep BA-kit practical and reusable.
- Prefer template-backed workflows over ad hoc prose.
- Preserve traceability between goals, requirements, and outputs.
- Use Mermaid for diagrams.

## Change Areas

When you change the skill:
- update `skills/ba-start/SKILL.md`
- update templates or rules if the workflow contract changes
- update `docs/getting-started.md` if usage changes

When you change a template:
- keep it ready-to-fill, not overexplained
- keep related-template links current
- ensure the skill clearly points to it

When you change an agent:
- keep handoff references current across all agent files
- update `CLAUDE.md` delegation section if ownership changes

## Verification

Before opening a pull request:
- run `bash -n install.sh`
- test `./install.sh` in a temporary `HOME` if you changed install behavior
- check internal paths and links you touched

## Pull Requests

- Keep scope focused.
- Explain user-facing workflow changes clearly.
- Call out any new assumptions about Claude runtime paths or installation layout.
