# DESIGN.md - BA IDE Platform

## Metadata

- Project: BA IDE Platform
- Slug: ba-ide-platform
- Date: 260415-1501
- Owner: damtuana
- Reference direction: External inspiration adapted from Meta Store / Dolly design language
- Status: Approved

## 0. Scope Of Use

- Product / flow covered: Login, dashboard, workspace administration, IDE workspace shell, AI settings, AI chat, PR review, artifact authoring flows
- App type: web-app
- Primary audience: BA Lead, BA Member, Reader (Dev/QC)
- This file is the system design document for manual wireframe creation and external design handoff in `designs/ba-ide-platform/`.

## 1. Visual Theme & Atmosphere

- Mood keywords: premium, product-forward, editorial, spacious, guided, modern
- Brand impression: The product should feel like a polished SaaS IDE with the emotional clarity of a consumer hardware showroom. UI chrome stays restrained so artifact content, workflows, and decision points feel curated rather than cluttered.
- Density: Balanced leaning Spacious
- Visual priorities:
  - clarity first for BA workflows
  - productized experience over raw developer-tool aesthetics
  - high-contrast action hierarchy
  - strong sense of guided progression through the BA lifecycle

The approved direction is inspired by the Meta Store's photography-first and whitespace-heavy system, but applied to a collaborative BA platform rather than ecommerce. The core translation rules are:

- treat artifact content, workflow states, and collaboration actions as the "hero objects"
- use large white canvases for reading, editing, and configuration tasks
- use dark immersive sections selectively for hero moments, onboarding emphasis, or focused workflow surfaces
- keep typography warm and geometric rather than terminal-like
- keep CTAs unmistakable through saturated blue pill buttons

The visual rhythm should alternate between:

- bright, clean, gallery-like work surfaces for dashboards, forms, editors, and structured artifact reading
- darker emphasis zones for hero headers, selected workspace focus, AI assistance emphasis, or review states where concentrated attention matters

This design must never drift into:

- generic admin-dashboard clutter
- dense terminal/CLI mimicry
- ornamental "tech" effects that reduce readability

## 2. Information Architecture (Portals & Navigation)

### 2.1 Portal Summary

| Portal ID | Portal / App | Target Actor | Owned Screen Families / Route Groups | Notes |
| --- | --- | --- | --- | --- |
| PORTAL-APP | Main Application | BA Lead, BA Member, Reader | Login, Dashboard, Create Workspace, Workspace Settings, Invite Members, AI Settings | Global application layer outside the IDE workspace shell |
| PORTAL-IDE | Workspace IDE | BA Lead, BA Member, Reader | IDE Main View, Artifact Editor, Branch Selector, Commit Dialog, Create PR Dialog, PR Review View, AI Chat Panel, New Artifact Dialog | Workspace-scoped authoring and review shell |

- Global navigation pattern:
  - `PORTAL-APP`: frosted top bar with contextual secondary actions
  - `PORTAL-IDE`: top workspace bar + persistent left sidebar + optional right utility panel
- Routing persistence:
  - active navigation stays tied to route group, not transient component state
  - breadcrumbs appear only when the user is deeper than the portal landing or inside settings/detail contexts

### 2.2 Navigation Schema

| Portal ID | Nav Schema ID | Navigation Pattern | Menu Item List | Default Landing | Active / Selected Rule | Breadcrumb / Back Rule | Hidden / Contextual Nav Exceptions |
| --- | --- | --- | --- | --- | --- | --- | --- |
| PORTAL-APP | NAV-APP-01 | Frosted glass top bar + page-level content navigation | Dashboard, Workspaces, AI Settings | Dashboard / Workspace List | Highlight current route group in top navigation; CTA remains visually distinct but not active-highlighted | Breadcrumb appears from level 2 down; browser back remains valid | Login screen hides global navigation completely |
| PORTAL-IDE | NAV-IDE-01 | Workspace top bar + left sidebar tree + contextual right panel | Overview, Files, Pull Requests, Members, AI Assistant | IDE Main View / Files | Highlight active workspace section in top bar and selected file/path in sidebar; right-side panels are contextual and do not own active state | Back follows browser history or closes overlay to parent IDE context | Dialogs, drawers, branch switchers, commit dialogs, create-PR dialogs, and AI utility overlays may hide parts of global nav but must preserve portal ownership explicitly |

## 3. Color Palette & Roles

The runtime palette follows the Meta Store-inspired source directly, but role mapping is adapted for BA IDE Platform.

| Role | Color | Usage | Notes |
| --- | --- | --- | --- |
| Primary background | `#FFFFFF` | Main app canvas, editor surfaces, forms, cards | Default reading/editing background |
| Secondary background | `#F1F4F7` | Dashboard bands, secondary sections, subtle containers | Use to separate content zones without heavy borders |
| Tertiary card background | `#F7F8FA` | Flat cards, auxiliary panels, settings tiles | Good for non-primary cards |
| Hero / immersive dark surface | `#1C1E21` | Workspace hero headers, selected-state sections, focus moments | Use sparingly for contrast rhythm |
| Deep focus dark surface | `#181A1B` / `#000000` | AI focus zones, review emphasis, premium workspace moments | Avoid overuse in form-heavy screens |
| Primary text | `#1C2B33` | Main headings, nav text, key labels | Prefer over pure black for warmth |
| Secondary text | `#5D6C7B` | Supporting copy, descriptions, metadata | Keep body copy brief |
| Divider / border | `#DEE3E9` / `#CED0D4` | Dividers, card outlines, input borders | Functional only, never decorative |
| Primary CTA | `#0064E0` | Primary buttons, action links, selected emphasis | Reserved for actionable elements |
| Primary CTA hover | `#0143B5` | Hover state for primary actions | Keep contrast strong |
| Primary CTA pressed | `#004BB9` | Active state for primary actions | Short pressed state only |
| CTA on dark | `#47A5FA` | CTA treatment when placed on dark surfaces | Use selectively |
| Success | `#007D1E` / `#31A24C` | Success banners, validation pass, merged/approved states | Prefer darker store success for prominent confirmations |
| Warning | `#F7B928` | Warnings, caution markers, pending review emphasis | Pair with neutral/dark text |
| Error | `#C80A28` / `#E41E3F` | Validation errors, failed actions, blocking states | Use darker tone for serious blocking errors |
| Informational tint | `rgba(0, 145, 255, 0.15)` | Informational badges, hint surfaces | Keep low visual weight |

### Product Accent Governance

- `#D6311F` Ray-Ban Red, `#A121CE` Oculus Purple, `#6441D2` Work Purple, and Portal blues are allowed only as sectional accents, badges, or thematic highlights.
- Never mix multiple product-accent families in the same content block unless the block is explicitly a cross-product overview.
- Default BA IDE Platform accent remains Meta Blue.

### Gradient System

- Dark overlay gradient: `linear-gradient(rgba(0,0,0,0), rgba(0,0,0,0.6))`
- Use overlay gradients whenever text is placed over dark media or high-contrast illustration
- Shadow alpha scale: 0.05, 0.10, 0.15, 0.20, 0.30, 0.40, 0.50, 0.60, 0.80

## 4. Typography Rules

### Font Direction

- Primary: Optimistic VF
- Fallbacks: Montserrat, Helvetica, Arial, Noto Sans
- OpenType features: `"ss01", "ss02"`
- Secondary utility font: Helvetica / Arial for tiny utility copy when needed
- Monospace / data fallback: a neutral monospace only inside code-ish artifact previews or file metadata when necessary; do not let monospace become the dominant product voice

| Level | Font / Style | Size / Weight | Usage |
| --- | --- | --- | --- |
| Display 1 | Optimistic VF with ss01/ss02 | 64px / 500 | Hero headlines on desktop landing and premium workspace headers |
| Display 2 | Optimistic VF with ss01/ss02 | 48px / 500 | Section hero, focused workspace callouts |
| Heading 1 | Optimistic VF | 36px / 500 | Major section headings |
| Heading 2 | Optimistic VF | 28px / 300 | Subheadings with lighter editorial tone |
| Heading 3 | Optimistic VF with ss01/ss02 | 18px / 700 | Card titles, panel titles, emphasized labels |
| Body | Optimistic VF | 18px / 400 | Primary body copy, descriptive text |
| Body Compact | Optimistic VF | 16px / 500 / -0.16px | Navigation links, labels, input-adjacent text |
| Caption Bold | Optimistic VF | 14px / 700 | Strong metadata, status labels, compact emphasis |
| Caption | Optimistic VF | 14px / 400 / -0.14px | Secondary metadata, helper text |
| Small | Helvetica / Optimistic VF | 12px / 400 | Legal copy, timestamps, low-emphasis utilities |
| Button | Optimistic VF | 14px / 400 / -0.14px | Buttons across app and IDE |
| Mono / Data | Neutral monospace fallback | 12-14px / 400 | File names, branch names, code-like content only when needed |

### Typographic Principles

- Headings should feel warm, geometric, and calm rather than aggressively technical.
- Body copy must stay scannable and short; prefer short paragraphs and bulleted structure in UI surfaces.
- Smaller UI text should use slightly tightened letter spacing for a crisp system feel.
- Avoid more than two dominant text levels in a single card or panel.

## 5. Component Stylings

- Button style:
  - primary buttons are fully rounded pill buttons with `#0064E0` background, white text, 100px radius, and 10px/22px padding
  - hover deepens color to `#0143B5` with slight scale-up
  - pressed state uses `#004BB9` with subtle scale-down
  - secondary buttons are outlined pills with light border and lower visual weight
- Input and form style:
  - white field surface, 8px radius, 1px divider border
  - generous label spacing, visible helper/error states
  - focus ring uses the blue accent
- Table / list style:
  - airy rows with strong column alignment and restrained dividers
  - empty states should feel guided, not barren
  - use cards or grouped list rows rather than cramped spreadsheet styling unless the data truly demands table density
- Card / panel style:
  - default card radius 20px, feature card radius 24px
  - elevated cards may use the soft dual-shadow treatment
  - cards in dark sections should rely more on color separation than heavy shadow
- Navigation style:
  - `PORTAL-APP`: frosted top nav on white / soft gray
  - `PORTAL-IDE`: polished workspace shell, left file/navigation rail, restrained top context bar, optional right-side AI panel
  - avoid terminal mimicry or VS Code clone aesthetics; this should feel friendlier and more curated
- Feedback style:
  - inline validation for forms
  - toast for lightweight confirmation
  - banners for cross-surface warnings/errors
  - dialogs use dark overlay and rounded high-elevation surfaces
- Shared-navigation governance:
  - module docs may reference schema snapshots but may not redefine global menu ownership established in this file

## 6. Layout Principles

- Grid and spacing philosophy:
  - base unit is 8px
  - use wide negative space as a deliberate premium signal
  - 64-80px vertical spacing for major sections where space allows
- Content width and breakpoints:
  - primary content max width approximately 1440px
  - dashboard and settings views use centered containers with controlled width
  - IDE view may use full viewport width while preserving content rhythm inside panels
- Section hierarchy:
  - hero or summary zone
  - primary action or content zone
  - supporting information zone
  - feedback / status zone
- Mobile / responsive priority: Desktop-first
- BA IDE-specific adaptation:
  - dashboard/settings screens should feel editorial and spacious
  - IDE shell can be denser, but still must preserve clarity through disciplined spacing and panel grouping

### Spacing Tokens

| Token | Value | Use |
| --- | --- | --- |
| space-1 | 1px | Hairline dividers |
| space-2 | 4px | Tight internal spacing |
| space-3 | 8px | Base unit |
| space-4 | 10px | Card horizontal padding reference |
| space-5 | 12px | Compact gaps |
| space-6 | 14px | Small text rhythm |
| space-7 | 16px | Standard UI spacing |
| space-8 | 18px | Body rhythm |
| space-9 | 24px | Grid gaps, panel spacing |
| space-10 | 32px | Section padding |
| space-11 | 40px | Major block spacing |
| space-12 | 48px | Compact section padding |
| space-13 | 64px | Standard section padding |
| space-14 | 80px | Hero padding |

## 7. Depth & Elevation

- Surface model: Mixed, mostly flat with selective soft elevation
- Border radius direction:
  - 8px inputs and small controls
  - 20px standard cards
  - 24px feature cards and highlight containers
  - 100px pill CTAs/tags
- Shadow / border treatment:
  - use soft dual-shadow for elevated light surfaces
  - prefer border/color separation in dark sections
- Overlays and modal treatment:
  - backdrop uses `rgba(0,0,0,0.6)`
  - modal/dialog surfaces use rounded corners, high contrast, and minimal chrome

### Elevation Levels

| Level | Treatment | Use |
| --- | --- | --- |
| Flat | no shadow | Base cards and sections |
| Level 1 | `0 2px 4px 0 rgba(0,0,0,0.1)` | Lightweight hover and interactive lift |
| Level 2 | `0 12px 28px 0 rgba(0,0,0,0.2), 0 2px 4px 0 rgba(0,0,0,0.1)` | Dropdowns, high-value cards, dialogs |
| Overlay | `rgba(0,0,0,0.6)` | Dialog/lightbox backdrop |
| Inset / frosted | subtle white inset + blur | Frosted nav or translucent utility surfaces |

## 8. Do's and Don'ts

### Do

- Use pill-shaped CTA buttons for all primary and secondary actions
- Use Meta Blue as the dominant action color
- Keep dashboard and settings screens spacious, calm, and highly legible
- Let artifact content, workflow steps, and key actions be the visual heroes
- Use Optimistic VF with stylistic sets on major headings
- Alternate light and dark sections intentionally to create rhythm
- Use gradients when placing text over dark imagery or dark illustration backdrops
- Maintain consistent portal navigation behavior across screens in the same schema
- Keep forms and settings layouts tidy with strong hierarchy and concise helper text

### Don't

- Don't mimic a terminal, code editor, or developer console too literally
- Don't crowd cards, forms, or editor-adjacent panels with dense controls
- Don't use sharp corners below 8px
- Don't mix multiple accent families inside one section without a clear thematic reason
- Don't use decorative borders or unnecessary dividers
- Don't place important text over imagery without a legibility scrim
- Don't let Facebook Blue replace Meta Blue for primary CTAs
- Don't overload single cards with too many text levels or too much copy
- Don't use long explanatory paragraphs in UI surfaces

## 9. Responsive Behavior

- Navigation collapse behavior:
  - `PORTAL-APP` top navigation collapses to hamburger below 768px
  - `PORTAL-IDE` shifts from persistent multi-panel layout to stacked / toggleable panels on smaller widths
- Table/list adaptation:
  - desktop favors card-grid or structured list
  - mobile stacks rows and compresses metadata
- Form adaptation:
  - wide multi-column layouts collapse to single-column below tablet
  - button groups stack vertically on mobile when needed
- Minimum touch/interaction targets: 44x44px

### Breakpoints

| Name | Width | Key Changes |
| --- | --- | --- |
| Mobile | `<768px` | Single-column layouts, collapsed nav, stacked actions, reduced section padding |
| Tablet | `768-1024px` | Two-column content where useful, compact nav, reduced hero scale |
| Desktop | `1024-1440px` | Full nav, 2-3 column grid where appropriate, spacious section rhythm |
| Large Desktop | `>1440px` | Centered max-width containers for app surfaces; IDE may remain fluid with bounded content regions |

## 10. Design Handoff Guide

- Use this file as the system design document before creating any manual wireframe or mockup for this project.
- Follow the approved Meta Store-inspired visual tone, color roles, typography rules, and component styling consistently across all frames.
- Strictly adhere to the Portals & Navigation architecture in this document.
- Keep behavior aligned with use cases and Screen Contract Plus. Do not invent flows that are not documented.
- Every global navigation screen must show the correct active/selected state defined by the matching `Nav Schema ID`.
- If a screen intentionally hides global navigation, document the exception explicitly instead of silently omitting the menu.
- Use Shadcn UI as the fallback component baseline only when this file leaves a detail unspecified.
- When the final mockup is ready, the user must manually reference or insert it into the final SRS.

## 11. Promptable Design Reference

Use the following shorthand when briefing manual wireframe work or future UI generation:

- "Meta Store-inspired, but for a collaborative BA IDE"
- "Spacious editorial SaaS shell with pill CTAs and Meta Blue actions"
- "Warm geometric typography with Optimistic-style hierarchy"
- "White reading surfaces, selective dark focus zones, no terminal aesthetics"
- "Friendlier than VS Code, more premium than a default admin dashboard"
