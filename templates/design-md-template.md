# DESIGN.md - [Tên dự án]

## Metadata

- Project: [Tên dự án]
- Slug: [initiative-slug]
- Date: [YYMMDD-HHmm]
- Owner: [BA owner / approver]
- Reference direction: [Custom brief | Brand guide | External DESIGN.md inspiration]
- Status: [Draft | Approved]

## 0. Phạm vi áp dụng (Scope Of Use)

- Product / flow covered: [Phạm vi]
- App type: [web-app | mobile-app]
- Primary audience: [Người dùng chính]
- This file is the system design document for AI wireframe generation in `designs/{slug}/`.

## 1. Visual Theme & Atmosphere

- Mood keywords: [Ví dụ: operational, premium, calm, data-dense]
- Brand impression: [Mô tả]
- Density: [Compact | Balanced | Spacious]
- Visual priorities: [Ví dụ: clarity first, fast scanning, guided completion]

## 2. Information Architecture (Portals & Navigation)

| Portal / App | Target Actor | Main Navigation (Sitemap) | Notes |
| --- | --- | --- | --- |
| [Tên portal, VD: Admin Portal] | [Role, VD: System Admin] | - Dashboard<br>- Users<br>- Settings | [Menu type: Top bar / Sidebar] |

- Global navigation pattern: [Sidebar | Top bar | Bottom tabs]
- Routing persistence: [Cách menu giữ trạng thái active / Hệ thống Breadcrumbs]

## 3. Color Palette & Roles

| Role | Color | Usage | Notes |
| --- | --- | --- | --- |
| Primary background | [#HEX] | [Usage] | [Notes] |
| Primary text | [#HEX] | [Usage] | [Notes] |
| Accent / CTA | [#HEX] | [Usage] | [Notes] |
| Success | [#HEX] | [Usage] | [Notes] |
| Warning | [#HEX] | [Usage] | [Notes] |
| Error | [#HEX] | [Usage] | [Notes] |
| Border / Divider | [#HEX] | [Usage] | [Notes] |

## 4. Typography Rules

| Level | Font / Style | Size / Weight | Usage |
| --- | --- | --- | --- |
| Display | [Rule] | [Rule] | [Usage] |
| Heading | [Rule] | [Rule] | [Usage] |
| Body | [Rule] | [Rule] | [Usage] |
| Label | [Rule] | [Rule] | [Usage] |
| Mono / Data | [Rule] | [Rule] | [Usage] |

## 5. Component Stylings

- Button style: [Shape, emphasis, states]
- Input and form style: [Density, labels, validation]
- Table / list style: [Headers, row density, empty states]
- Card / panel style: [Borders, shadows, sections]
- Navigation style: [Sidebar, tabs, top bar, breadcrumbs]
- Feedback style: [Toast, inline error, banners, dialogs]

## 6. Layout Principles

- Grid and spacing philosophy: [Rule]
- Content width and breakpoints: [Rule]
- Section hierarchy: [Rule]
- Mobile / responsive priority: [Desktop-first | Mobile-first | Balanced]

## 7. Depth & Elevation

- Surface model: [Flat | Layered | Mixed]
- Border radius direction: [Rule]
- Shadow / border treatment: [Rule]
- Overlays and modal treatment: [Rule]

## 8. Do's and Don'ts

### Do

- [Approved pattern]
- [Approved pattern]

### Don't

- [Anti-pattern]
- [Anti-pattern]

## 9. Responsive Behavior

- Navigation collapse behavior: [Rule]
- Table/list adaptation: [Rule]
- Form adaptation: [Rule]
- Minimum touch/interaction targets: [Rule]

## 10. Agent Prompt Guide

- Use this file as the system design document before generating any wireframe for this project.
- Follow the approved visual tone, color roles, typography rules, and component styling consistently across all frames.
- Strictly adhere to the Portals & Navigation architecture. Make sure global menus and sitemaps are present and consistent in all screens of their respective portals.
- Keep behavior aligned with use cases and Screen Contract Lite. Do not invent flows that are not documented.
- Use Shadcn UI as the fallback component baseline only when this file leaves a detail unspecified.
