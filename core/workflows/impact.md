<purpose>
Run BA change-impact triage for an existing project set.

This command is the safe landing zone for:
- new requirements
- changed rules
- removed scope items
- bare correction statements such as "Khong co nhom admin user"

It must not mutate artifacts. It analyzes impact first, then returns the next commands.
</purpose>

<required_reading>
Read the installed BA playbook, `contract.yaml`, and `contract-behavior.md` before doing anything else.
</required_reading>

<process>

<step name="load_contract">
Read:
- the installed `ba-start` skill from the same runtime
- `contract.yaml` from the installed BA core
- `contract-behavior.md` from the installed BA core

Use the `impact` subcommand contract in `ba-start` as the authoritative decision logic.
</step>

<step name="validate_input">
If the command arguments or the attached user text do not contain any change statement, ask one concise question:

"What changed? Paste the new requirement, correction, or rule update and I will analyze the impact."
</step>

<step name="resolve_project">
Resolve the target slug and dated set using the artifact contract.

Rules:
- Prefer explicit `--slug` when present
- Otherwise inspect the current workspace for exact BA-kit artifacts
- If slug or dated set is ambiguous, stop and ask the user to choose
- If only legacy artifacts exist, stop and report that the project must be migrated or rerun under the current contract
</step>

<step name="triage">
Execute the equivalent of `/ba-start impact --slug <slug>` using the resolved project set and the change statement.

Follow the `impact` logic from `ba-start` exactly:
- determine the current source of truth
- classify the change
- list affected and unaffected artifacts
- recommend the narrowest safe rerun path
- print exact commands

Do not apply edits during this command.
</step>

<step name="finish">
Return only the impact analysis and next commands.
Do not ask a generic "what do you want me to do next?" question unless the triage itself requires clarification.
</step>

</process>

<success_criteria>
- [ ] Project set resolved exactly or ambiguity surfaced explicitly
- [ ] Change classified without mutating artifacts
- [ ] Current source of truth identified
- [ ] Affected and unaffected artifacts listed
- [ ] Exact next commands printed
</success_criteria>
