# BA Start Step - SRS Assembly

This step requires:

- `core/contract.yaml`
- `core/contract-behavior.md`

## Step 10.1 - Produce validation pack

Produce the validation and traceability pack from the completed SRS sections. Prefer `ba-documentation-manager` ownership when delegated.

Sections:

- Test Cases
- Glossary
- Traceability cross-references

Output: `paths.srs_group` with `group=f`

## Step 11 - Assembly and quality review

The orchestrator assembles the final SRS inline. Do not delegate assembly.

Assembly procedure:

1. Write the SRS skeleton to `paths.srs` using the `srs-template.md` heading structure.
2. For each group in template order (`A -> B -> C -> D -> E -> F`):
   - read the group fragment from `paths.srs_group`
   - edit-append it into the matching section of the skeleton
   - confirm the edit succeeded before moving on
3. After all groups are appended, run a cross-artifact consistency check on the file on disk:
   - every UC step maps to a screen field or action and vice versa
   - Screen Contract Lite entries have matching wireframes and final screen descriptions
   - UC actor actions use the same wording as screen User Actions
   - UC system responses match screen Behaviour Rules
   - alternate flows are reflected in screen error states
   - user story acceptance criteria are covered by UC postconditions and screen validation rules
4. Resolve placeholder references and ID conflicts inline.
5. Verify every SCR and UC traces back to user stories.
6. Delete group fragments only after the merged SRS is verified.

Execution order:

```text
Group A
  -> Group B
  -> Group D
Group B -> Group C
Group C -> Wireframes
Wireframes -> Group E
Group E -> Group F
Group F -> Assembly
```

If a grouped pass fails, retry once. If it still fails, complete that group inline. The merge itself always runs inline.
