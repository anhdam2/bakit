# Runtime Antigravity Capability Spike

**Status:** SPIKE PENDING EXECUTION
**Date:** 2026-04-24
**Phase:** 04 — Parity Harness Skeleton

---

## Purpose

Before Phase 3 locks the cross-runtime packet schema, this spike verifies whether
Antigravity can support the schema's required fields at parity with Claude Code and Codex.

If Antigravity has hard constraints (tool access, file I/O, context injection), the packet
schema must be partitioned into portable-core fields (required) and runtime-hint fields
(optional, Antigravity may skip). Locking the schema before this is confirmed risks
building a contract that one runtime cannot satisfy.

---

## Capability Assessment

Assessment is currently PENDING execution. The table below documents expected comparison
dimensions. Values are filled in after spike execution.

| Capability | Claude Code | Codex | Antigravity |
| --- | --- | --- | --- |
| Read local files directly | Yes (Read tool) | Yes (file I/O) | PENDING |
| Write local files directly | Yes (Write/Edit tools) | Yes (file I/O) | PENDING |
| Receive context via injected packet | Yes | Yes | PENDING |
| Parse structured markdown tables | Yes | Yes | PENDING |
| Enforce approval gates (HITL) | Yes | Partial | PENDING |
| Surface visible warnings to user | Yes | Yes | PENDING |
| Resolve slug/date without mtime | Yes (explicit only) | Yes | PENDING |
| Access system prompt / hook injection | Yes | Codex instructions | PENDING |

---

## Key Constraints (Suspected — Confirmation Pending)

The following constraints are suspected based on publicly available Antigravity documentation
and general agent architecture patterns. None are confirmed until spike execution.

1. **File I/O access** — Antigravity may not have direct local file read/write. Packet
   delivery may need to be via context injection rather than file paths.

2. **Tool availability** — `Read`, `Write`, `Edit`, `Bash` tool equivalents may not exist
   or may have different names/signatures. Packet schema fields that reference tool names
   directly (e.g., `read_scope`) may require abstraction.

3. **Hook/system-prompt injection** — BA-kit relies on hook-injected context (slug, date,
   plan path). Antigravity's equivalent mechanism is unconfirmed.

4. **HITL approval gates** — The approval gate pattern requires the runtime to pause and
   present a decision to the user. Whether Antigravity supports mid-execution pause is
   unconfirmed.

5. **Compact fallback warning surfacing** — Visible user-facing warnings (not log-only)
   require a display mechanism. Antigravity's output channel format is unconfirmed.

---

## Open Questions

1. Does Antigravity support direct local file access, or must all context be pre-loaded
   into the packet/system prompt?

2. What is Antigravity's equivalent of Claude Code's hook injection mechanism?

3. Can Antigravity pause execution mid-step to request user approval (HITL gate)?

4. Does Antigravity have a concept of "visible warning" distinct from normal output?

5. Is there a token/context-window limit that affects how large a packet Antigravity can
   receive in a single call?

6. Does Antigravity support POSIX-compatible shell script execution, or does the
   `test-runtime-parity.sh` harness need an in-process equivalent?

---

## Mitigation Options

If spike execution confirms hard constraints, the following downgrade paths apply
(in order of preference — use the least-invasive option that restores parity):

**Option A — Portable-core packet only**
Keep packet schema fields that are plain markdown-readable and runtime-neutral. Remove or
make optional any field that requires tool-specific names or file-path resolution.
- Core fields: `resolved_command`, `resolved_slug`, `approval_gate`, `activation_level`,
  `fallback_code`
- Downgraded to optional hints: `read_scope`, `write_target`, `source_of_truth_artifact`

**Option B — Context-injection delivery**
Replace file-path references in the packet with pre-loaded content blocks. Antigravity
receives the artifact content inline rather than a path to resolve independently.
- Trade-off: larger packet size, potential context-window pressure.

**Option C — Disable runtime-specific enforcement**
Keep manual packet usage for Antigravity but disable automated parity enforcement
(golden checks) for Antigravity-specific fields until adapter is built.
- Parity harness marks Antigravity rows as `EXEMPT` rather than `PENDING` or `FAIL`.
- Revisit after Phase 3 schema is stable.

**Option D — Defer richer ergonomics**
Defer any packet field that requires runtime-specific ergonomics (e.g., tool-call
interceptors, hook callbacks) to a post-Phase-3 enhancement. Ship Phase 3 with the
minimal portable schema only.

---

## Spike Methodology

When executing this spike, follow these steps:

1. Provision an Antigravity instance with BA-kit installed per `antigravity-setup.md`.
2. Submit each F01–F05 fixture's Input Command to Antigravity manually.
3. Record raw output for each fixture.
4. Normalize output against the Behavior Envelope fields in each golden file.
5. Mark each golden's `Antigravity` row as `PASS` or `FAIL` with a one-line reason.
6. If any `FAIL`: identify which constraint caused it and select a mitigation option above.
7. Update this document's Capability Assessment table and Constraints list with findings.
8. Update status from `SPIKE PENDING EXECUTION` to `SPIKE COMPLETE` with a summary.

---

## Expected Output Format (Post-Execution)

After spike execution, this document should include a filled Capability Assessment table,
confirmed constraint list, selected mitigation option (with rationale), and a one-paragraph
summary suitable for Phase 3 schema lock decision.

---

## Related Files

- `tests/runtime-parity/fixtures/` — input scenarios for parity testing
- `tests/runtime-parity/goldens/` — normalized behavior envelopes (the contract)
- `scripts/test-runtime-parity.sh` — harness entry point
- `antigravity-setup.md` — Antigravity installation guide
- `docs/skill-catalog.md` — runtime skill inventory
