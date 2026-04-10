# Design Artifacts

Use this directory for project runtime `DESIGN.md` files.

`DESIGN.md` is the global design-system and UI-governance document for a project. It is not the final mockup itself. BA-kit uses it to lock:
- visual tone
- colors and typography
- layout principles
- navigation and information architecture
- per-portal navigation schemas and active-state rules
- shared components such as menu, header, footer, cards, forms, and tables
- responsive behavior and anti-patterns

## Current flow

BA-kit does not generate wireframes directly in the default flow.

Instead:
- `designs/{slug}/DESIGN.md` defines the global UI direction
- `wireframe-input.md` defines screen-level constraints
- `wireframe-map.md` tells the user where to attach the final mockup in the SRS
- the user creates the actual wireframe/mockup manually or with an external tool

## Rules

- Keep one `DESIGN.md` per project slug.
- Treat `DESIGN.md` as the source of truth for shared UI patterns and global navigation.
- Treat the backbone `Portal Matrix` plus `DESIGN.md` `Navigation Schema` as the canonical IA pair for module-level wireframe work.
- Do not let module-level artifacts redefine shared components or the overall visual direction.
- If a user-supplied mockup conflicts with `DESIGN.md`, update the BA artifacts deliberately instead of silently accepting visual drift.
