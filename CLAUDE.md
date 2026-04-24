# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
npm run dev        # Start dev server (Astro hot reload)
npm run build      # Production build to dist/
npm run preview    # Serve the production build locally
npm run deploy     # Build + push dist/ to GitHub Pages (gh-pages)
```

No linting or test framework is configured.

## Architecture

Static DSA prep site ([algofrog.in](https://algofrog.in)) built with Astro. All content lives in `src/data/topics.ts` as a typed TypeScript array — no CMS, no database, no API calls.

**Single-page design:** `src/pages/index.astro` renders every topic on one HTML document. Navigation is client-side: clicking a sidebar link scrolls to `id="tp{id}"` on the matching TopicCard. There are no dynamic routes.

**Data flow:**
1. `src/data/types.ts` defines the `Topic` interface and `TierCode` enum
2. `src/data/topics.ts` exports `Topic[]` — the sole data source
3. `index.astro` maps topics → `<TopicCard>` and passes the array to `<SidebarNav>` for grouping

## Topic Data Shape

Each `Topic` in `topics.ts` has two concerns:

**Sidebar/nav fields** — used by `SidebarNav.astro` to build grouped navigation:
- `navSection`: group header (e.g., `"Algorithms"`, `"Data Structures"`)
- `navLabel`: link text shown in sidebar
- `navTierDotColor`: hex color dot beside the label
- `showInSidebar`: whether the topic appears in nav at all
- `displayNumber`: used for sort order within each section

**Content fields** — used by `TopicCard.astro`:
- `title`, `tier`, `typeLabel`, `summaryMeta`, `topbarMeta`: header metadata
- `bodyHtml`: raw HTML string (use `String.raw\`...\`` to avoid escaping). This is the full rendered content — tables of LeetCode problems, pattern triggers, sub-variant pills, etc.

When adding a new topic, assign the next sequential `id`, pick a `navSection` that matches an existing group, and write `bodyHtml` as an HTML string with the same table/div structure used in other topics.

## Components

- **`SidebarNav.astro`** — groups topics by `navSection`, sorts by `displayNumber`, renders anchor links
- **`TopicCard.astro`** — renders one topic: header row (number, title, tier badge, type label) + `bodyHtml` via `set:html`
- **`Topbar.astro`** — top bar; shows breadcrumb from `topbarMeta` when a topic is active

## Theming

`src/styles/global.css` defines all design tokens as CSS variables on `:root` (light) and `[data-theme="dark"]`. Theme is toggled by setting `document.documentElement.dataset.theme` and persisted in `localStorage`. Primary colors: `#01696f` (light) / `#4f98a3` (dark). Always use CSS variables rather than hardcoded colors.

## Deployment

`npm run deploy` runs `gh-pages -d dist --dotfiles`, pushing the built `dist/` folder to the `gh-pages` branch. The production domain is `https://algofrog.in`.
