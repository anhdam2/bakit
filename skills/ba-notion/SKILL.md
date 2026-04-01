---
name: ba-notion
description: Push BA-kit artifacts or other BA markdown documents to Notion through MCP. Supports creating a new page, appending to an existing page, overwriting content, or filling only missing sections.
argument-hint: "[artifact|file] [--slug <slug>] [--date <YYMMDD-HHmm>] [--page <url|id>] [--parent <url|id>] [--mode auto|create|append|overwrite|fill-gaps]"
---

# BA Notion

Use this maintenance skill when the user wants to publish BA output into Notion instead of generating or rerunning the BA artifacts themselves.

## Invocation

```text
/ba-notion srs --slug warehouse-rfp --page https://www.notion.so/... --mode overwrite
/ba-notion frd --slug warehouse-rfp --parent https://www.notion.so/... --mode create
/ba-notion plans/reports/final/backbone-260331-1015-warehouse-rfp.md --page https://www.notion.so/... --mode append
/ba-notion srs --slug warehouse-rfp --mode fill-gaps
```

## Supported Inputs

- An artifact alias:
  - `intake`
  - `backbone`
  - `frd`
  - `stories`
  - `srs`
  - `wireframe-map`
- Or an explicit file path to a markdown artifact

Prefer markdown BA artifacts as the Notion source. If the user asks for packaged HTML, use the matching markdown artifact when it exists and explain that Notion editing should be driven from the markdown source-of-truth.

## Exact Resolution Rules

When the source is an artifact alias instead of a direct file path:

1. Resolve `--slug <slug>` first.
2. Resolve `--date <YYMMDD-HHmm>` next.
3. Use exact BA-kit artifact patterns only.
4. Never silently choose a slug or dated set by mtime.
5. If multiple candidates exist, stop and ask the user to choose.

Use these exact patterns:

- `plans/reports/final/intake-{slug}-{date}.md`
- `plans/reports/final/backbone-{date}-{slug}.md`
- `plans/reports/final/frd-{date}-{slug}.md`
- `plans/reports/final/user-stories-{date}-{slug}.md`
- `plans/reports/final/srs-{date}-{slug}.md`
- `plans/reports/drafts/wireframe-map-{date}-{slug}.md`

## Publish Modes

Default mode: `auto`

- `create`: create a new Notion page from the source artifact
- `append`: keep the existing page and append the new content below the current content
- `overwrite`: replace the existing page body with the source artifact
- `fill-gaps`: fetch the existing page, compare headings and sections, and append only sections that are missing
- `auto`: choose the safest operation based on the supplied destination and user intent

## Destination Resolution

Use this order:

1. If `--page <url|id>` is provided, treat it as the target page to update.
2. If `--parent <url|id>` is provided, create a new page under that parent.
3. If neither is provided but the user named a specific Notion destination, search Notion for an exact page match.
4. If search returns one unambiguous match, use it.
5. If the destination is still ambiguous, ask one concise follow-up question.

Do not invent a parent page. If creating a page requires a parent and the target parent is genuinely unknown, stop and ask.

## Required Behavior

1. Read the source artifact from disk first.
2. Fetch `notion://docs/enhanced-markdown-spec` before creating or updating page content.
3. When updating an existing page, fetch that page first.
4. Preserve the source language by default. BA-kit artifacts are usually Vietnamese unless the user requested English.
5. Use the source document title as the Notion page title unless the user requested a different title.
6. Use `mode=overwrite` only when the user asked for replacement or when `auto` clearly indicates a full refresh of the same artifact page.
7. Use `mode=append` when the user wants to add a new revision or addendum without destroying existing page content.
8. Use `mode=fill-gaps` when the user wants to enrich an existing page while preserving manual edits already present in Notion.
9. If updating page content would delete child pages or databases, stop and ask for confirmation before allowing deletion.
10. After publishing, report:
   - source artifact path
   - destination page URL or ID
   - mode used
   - whether the page was created or updated

## Notion Tooling Guide

- Use `notion_fetch` to inspect the target page or database.
- Use `notion_search` only when the destination was described but not explicitly linked.
- Use `notion_create_pages` to create a new page under a page or data source.
- Use `notion_update_page` with:
  - `replace_content` for overwrite
  - `update_content` for append or selective fill-gaps updates

Prefer targeted `update_content` operations over full replacement when the page already contains user-maintained material that should remain intact.

## Expected Result

- BA content is published to Notion with a traceable source artifact.
- The destination handling is explicit and reversible.
- The agent chooses create, append, overwrite, or fill-gaps deliberately instead of always replacing the whole page.
