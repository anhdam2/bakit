---
name: ba-kit-update
description: Update an installed BA-kit with one command. Checks for local git conflicts or dirty state, pulls fast-forward only, and reinstalls Claude/Codex/Antigravity assets from the registered source repo.
argument-hint: ""
---

# BA-kit Update

Use this maintenance skill when the user wants to update BA-kit itself instead of generating BA artifacts.

## Invocation

```text
/ba-kit-update
```

## Required Behavior

1. Prefer the installed command:

```bash
ba-kit update
```

2. If `ba-kit` is not on `PATH`, run:

```bash
~/.local/bin/ba-kit update
```

3. Do not manually run `git pull`, `install.sh`, `scripts/install-codex-ba-kit.sh`, or `scripts/install-antigravity-ba-kit.sh` one by one unless the CLI is missing or broken.
4. If the CLI reports local changes, unfinished merge/rebase state, or multiple registered source repos, stop and report the exact blocker instead of forcing the update.
5. After the command completes, report:
   - source repo path
   - previous and current commit
   - which runtimes were reinstalled
6. Run the update command exactly as a single shell command:
   - `ba-kit update`
   - or `~/.local/bin/ba-kit update`
7. Do not wrap the command in extra quotes, subshell templates, heredocs, or generated shell helper functions. If the command itself fails, report the stderr instead of improvising a different shell wrapper.

## Expected Result

- One command updates the tracked BA-kit source repo.
- The update uses `git pull --ff-only`.
- Installed Claude, Codex, and Antigravity assets are re-synced automatically when they were previously installed from that repo.
