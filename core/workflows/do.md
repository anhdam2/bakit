<purpose>
Analyze freeform BA text and route it to the most appropriate BA-kit command.

This is a dispatcher. It should not do the downstream BA work itself.
</purpose>

<required_reading>
Read the installed BA playbook, `contract.yaml`, and `contract-behavior.md` before routing.
</required_reading>

<process>

<step name="validate">
If the input is empty, ask:

"What would you like to do? Describe the BA task, artifact, or requirement change and I will route it to the right BA-kit command."
</step>

<step name="route">
Match intent using the first rule that fits:

| If the text describes... | Route to | Why |
| --- | --- | --- |
| publishing to Notion | `ba-notion` | publish workflow |
| checking status, completion, or missing artifacts | `ba-start status` | inspection path |
| asking what the next BA step should be | `ba-next` | state-aware recommendation |
| adding, changing, removing, or correcting a requirement/rule/scope item | `ba-impact` | change triage before mutation |
| a bare correction statement in an existing BA project context | `ba-impact` | safe default before edits |
| directly generating or rerunning intake/backbone/frd/stories/srs/wireframes/package | `ba-start` with the matching subcommand | direct BA lifecycle step |
| a new BA engagement from raw input | `ba-start` | full lifecycle |

If the text could match both `ba-impact` and a direct edit request, prefer `ba-impact` unless the user explicitly says to update, edit, overwrite, regenerate, or rerun a named artifact or step.
</step>

<step name="display">
Show the decision:

```text
BA-kit Routing

Input: {short input excerpt}
Routing to: {command}
Reason: {one-line reason}
```
</step>

<step name="dispatch">
Hand off to the chosen command and stop.

Rules:
- `ba-impact` for requirement changes or correction statements
- `ba-next` for "what should I do next"
- `ba-start` for explicit lifecycle steps
- `ba-notion` for publishing

The dispatcher must not directly edit BA artifacts.
</step>

</process>

<success_criteria>
- [ ] Input validated
- [ ] Exactly one BA command chosen
- [ ] `ba-impact` preferred for ambiguous change statements
- [ ] Routing reason shown before handoff
- [ ] Dispatcher does not mutate artifacts itself
</success_criteria>
