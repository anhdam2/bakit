# Plans Workspace

`plans/` is a local runtime workspace for BA-kit.

Generated work plans and report artifacts belong here while you are running `/ba-start`, but they should not be version-controlled in this repository.

Expected runtime structure:

```text
plans/
  reports/
    final/
      intake-{slug}-{date}.md
      backbone-{date}-{slug}.md
      frd-{date}-{slug}.md
      frd-{date}-{slug}.html
      user-stories-{date}-{slug}.md
      srs-{date}-{slug}.md
      srs-{date}-{slug}.html
    drafts/
      srs-{date}-{slug}-group-a.md
      srs-{date}-{slug}-group-b.md
      srs-{date}-{slug}-group-c.md
      srs-{date}-{slug}-group-d.md
      srs-{date}-{slug}-group-e.md
      srs-{date}-{slug}-group-f.md
      wireframe-input-{date}-{slug}.md
      wireframe-map-{date}-{slug}.md
      wireframe-state-{date}-{slug}.md
  {date}-{slug}/
    plan.md
```

If you want to keep sample outputs for documentation, move sanitized examples into `docs/` or a dedicated `examples/` directory instead of committing them under `plans/`.
