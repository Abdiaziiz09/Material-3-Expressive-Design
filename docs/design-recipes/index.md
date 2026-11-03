# Design recipes

Recipes are patterns, not official templates. Any screen-specific spacing, breakpoint, or animation not prescribed by a cited source is an implementation decision. Before shipping, validate all applicable items in the [visual checklist](../ai-agent-guide/validation-checklist.md).

## Settings screen

Use a page heading and grouped settings sections. Choose controls by semantics: switch for an immediate on/off preference, checkbox for selection in a form, and a navigation row when the item opens a detail screen. Provide concise labels, supporting text when needed, and visible focus. On tablets, consider a persistent category navigation plus a detail pane when the task benefits from a two-pane layout; select this based on task and available space rather than a universal threshold. Verify RTL, text scaling, external-keyboard navigation where supported, and screen-reader labels.

See also the [expressive screen recipes](expressive-screen-recipes.md) for onboarding, profile, search, feed, chat, notifications, and account settings patterns.

## Dashboard

Establish one primary task and use semantic headings, content grouping, and surface roles. Avoid encoding every metric as a card; use the simplest structure that makes comparison and action clear. Reflow grids when space changes and preserve reading order. Test empty/loading/error states and ensure data visualizations have textual alternatives.

## Form-heavy interface

Use labelled `TextFormField` controls, appropriate keyboard types, inline and announced validation, logical focus order, and clear submission feedback. Preserve entered data after validation errors. On small viewports, allow scrolling and keyboard inset handling; on larger layouts, use bounded content width and intentional grouping. Test long localized labels and screen-reader error announcements.

## List-detail and navigation shell

Use a list and detail composition when selection context matters; adapt from single-pane navigation on phones to side-by-side panes on tablets when space supports it. Use Flutter's `NavigationBar`, `NavigationRail`, or `NavigationDrawer` only when the mobile task and available screen space make that pattern appropriate. Keep selection semantics and back behavior coherent. No breakpoint is prescribed here.

## Light/dark theme

Create light and dark `ColorScheme`s with shared semantic roles; test contrast and all component states in both. Dynamic color is optional and platform-dependent. This recipe establishes no official token values. See [color](../foundations/color.md) and [theme configuration](../flutter/theme-configuration.md).
