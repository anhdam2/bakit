<purpose>
Translate BA-friendly collaboration intent into safe module ownership, review, and optional GitHub handoff steps.

This workflow hides Git mechanics from non-technical BAs. It may update local collaboration artifacts, but external side effects require explicit approval.
</purpose>

<required_reading>
Read `contract.yaml`, `contract-behavior.md`, and the relevant `PROJECT-HOME.md` / `COLLAB-HOME.md` / `MODULE-HOME.md` when present.
</required_reading>

<process>

<step name="resolve">
Resolve slug/date/module exactly. If the user names a module, prefer that module. If multiple projects or modules match, stop and ask.
</step>

<step name="classify_intent">
Map the user text using the first matching intent:

| BA says | Internal action |
| --- | --- |
| create collaboration workspace / chia module / setup teamwork | initialize `COLLAB-HOME.md` and module homes |
| tôi nhận module X / assign module X cho Y | claim or assign module |
| kiểm tra module X trước review / có conflict không | pre-review check |
| làm xong module X / gửi Lead BA review | create review packet; optional PR only after approval |
| cập nhật theo feedback / changes requested | mark changes-requested or in-progress |
| approve module X | mark approved; Lead BA only |
| tổng hợp module đã approve / integrated | mark integrated after assembly/merge confirmation |
| tạo PR / push lên GitHub / merge | external GitHub handoff; require explicit approval |
</step>

<step name="safe_execution">
Allowed local mutations:
- create or refresh `paths.collab_home` from `templates/collab-home-template.md`
- create or refresh `paths.module_home` from `templates/module-home-template.md`
- create or refresh `paths.review_packet` from `templates/review-packet-template.md`
- update module status only as: unassigned, assigned, in-progress, ready-for-review, changes-requested, approved, integrated, blocked
- update review status only as: none, local-packet, draft-pr, review-requested, changes-requested, approved, merged, conflict

Never mutate lifecycle artifacts directly from collab intent. If the request changes requirements, route `impact` first.
</step>

<step name="ownership_checks">
Before marking ready-for-review or approved:
- verify the module has an owner
- verify changed paths are inside `03_modules/{module_slug}/` unless Lead BA approved escalation
- flag changes to backbone, DESIGN.md, hot/global memory, or other modules as cross-module escalation
- flag possible duplicate `CR-*` / `MSG-*` codes when detectable
</step>

<step name="external_side_effect_gate">
Commit, push, PR creation, reviewer request, and merge are external side effects.

Before any of them:
1. Print the exact action plan.
2. Print files to be included.
3. Print proposed branch/commit/PR title when relevant.
4. Ask for explicit approval.
5. If approval is absent, stop after local review packet creation.
</step>

<step name="display">
Print a BA-friendly result:

```text
BA Collaboration

Project: {slug}
Module: {module}
Action: {friendly action}
Status: {collab_module status}
Review: {collab_review status}
Updated: {paths updated}
Next: {next BA-friendly step}
External GitHub action: {not requested | approval required | completed}
```
</step>

</process>

<success_criteria>
- [ ] Project/module resolved exactly or ambiguity surfaced
- [ ] Local collaboration artifacts updated only when safe
- [ ] Requirement changes routed through impact
- [ ] GitHub side effects gated by explicit approval
- [ ] BA-facing statuses shown without requiring Git vocabulary
</success_criteria>
