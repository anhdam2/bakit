<purpose>
Detect the next logical BA step from the current BA-kit artifact set.

This command is the BA equivalent of a lightweight state machine. It reads the current project artifacts and recommends the next exact command.
</purpose>

<required_reading>
Read the installed BA playbook, `contract.yaml`, and `contract-behavior.md` before computing the next step.
</required_reading>

<process>

<step name="resolve_project">
Resolve the target slug and dated set using the artifact contract.

Rules:
- prefer explicit `--slug`
- otherwise detect a single existing project set from exact BA-kit artifact patterns
- if ambiguous, stop and ask the user to choose
</step>

<step name="inspect_artifacts">
Inspect the resolved artifact set and determine which of these exist:
- intake
- backbone
- frd
- user stories
- srs
- wireframe-input
- wireframe-map
- wireframe-state
- packaged FRD/SRS HTML

Read the backbone gate section when it exists. Use it to decide whether FRD, SRS, wireframes, or packaging are required.
</step>

<step name="determine_next_step">
Apply the first matching rule:

1. no intake -> next step `ba-start intake`
2. intake exists but no backbone -> `ba-start backbone --slug <slug>`
3. backbone exists and FRD is explicitly required but missing -> `ba-start frd --slug <slug>`
4. backbone exists but user stories are missing -> `ba-start stories --slug <slug>`
5. SRS is required and missing -> `ba-start srs --slug <slug>`
6. wireframe-input exists and wireframe-state is missing while wireframes are required -> `ba-start wireframes --slug <slug>`
7. final markdown exists but required packaged HTML is missing -> `ba-start package --slug <slug>`
8. everything required already exists -> `ba-start status --slug <slug>`

When FRD/SRS/wireframes gates are unclear, explain the uncertainty and recommend `ba-start status --slug <slug>` instead of guessing.
</step>

<step name="display">
Print:

```text
BA Next

Project: {slug}
Date set: {date}
Next command: /ba-start ...
Reason: ...
```

Do not mutate artifacts during this command.
</step>

</process>

<success_criteria>
- [ ] Project set resolved exactly or ambiguity surfaced
- [ ] Current artifact set inspected from exact patterns
- [ ] Next BA command recommended from the current state
- [ ] No artifacts mutated
</success_criteria>
