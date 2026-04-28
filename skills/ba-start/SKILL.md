---
name: ba-start
description: Lifecycle engine for BA-kit. Accepts raw requirements, normalizes them, locks scope, builds a requirements backbone, emits only the necessary downstream artifacts, and packages deliverables.
argument-hint: "[intake|impact|backbone|frd|stories|srs|wireframes|package|status] [file|--slug|--date|--module|--mode]"
---

# BA Start

Use this skill when the BA lifecycle step is explicit. Treat `ba-do` as the freeform router and `ba-start` as the execution engine.

## Required Read Order

1. Read [../../core/contract.yaml](../../core/contract.yaml) for exact paths, prerequisites, defaults, states, and command metadata.
2. Read [../../core/contract-behavior.md](../../core/contract-behavior.md) for shared LLM policy.
3. Resolve the selected subcommand.
4. Read only the matching file under `steps/`.
5. Read templates and upstream artifacts only when the active step actually needs them.

## Invocation

```text
/ba-start
/ba-start intake <file>
/ba-start impact --slug <slug> [change-file]
/ba-start backbone --slug <slug>
/ba-start frd --slug <slug> --module <module_slug>
/ba-start stories --slug <slug> --module <module_slug>
/ba-start srs --slug <slug> --module <module_slug>
/ba-start wireframes --slug <slug> --module <module_slug>
/ba-start package --slug <slug>
/ba-start status --slug <slug>
/ba-start next --slug <slug>
```

## Step Dispatch

| Command | Read next | Notes |
| --- | --- | --- |
| no subcommand | `steps/intake.md`, then downstream gated steps | full lifecycle |
| `intake` | `steps/intake.md` | Steps 1-4 |
| `impact` | `steps/impact.md` | analysis only |
| `backbone` | `steps/backbone.md` | Step 5 |
| `frd` | `steps/frd.md` | Step 6 |
| `stories` | `steps/stories.md` | Step 7 |
| `srs` | `steps/srs.md` | SRS router; loads narrower SRS step files on demand |
| `wireframes` | `steps/wireframes.md` | Step 9 standalone |
| `package` | `steps/package.md` | Step 12 |
| `status` | `steps/status.md` | inspection only |
| `next` | `../../core/workflows/next.md` | BA-facing next-step recommendation; no mutation |

## Fast Execution Contract

1. Parse arguments before doing any work.
2. Resolve the command and target scope with exact matching only.
3. Enforce prerequisites from `core/contract.yaml`.
4. Stop on ambiguity instead of guessing.
5. Ask before overwriting any mutable target.
6. Keep the accepted rerun step locked once the user approves it.

## Stop Conditions

- Never silently choose a slug, date, or module by mtime.
- Never use broad `*-{slug}*` matching when exact modular paths exist.
- Never mutate artifacts from a bare change statement; route through `impact` first.
- Never delegate merge or packaging assembly of large artifacts.

## Shared References

- [../../templates/manifest.json](../../templates/manifest.json)
- [../../templates/sub-agent-handoff-template.md](../../templates/sub-agent-handoff-template.md)
