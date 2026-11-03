# M3 Expressive component deep dives

This page expands the less-covered component topics in the [component coverage matrix](../reference/component-coverage.md): button groups, split buttons, FAB menus, badges, dividers, side sheets, and time pickers. The per-component [verification ledger](../reference/component-verification-ledger.md) records which official Material source metadata and local Flutter APIs were checked. This is an implementation reference, not a complete reproduction of Material's interactive specifications or an assertion that each component has an M3 Expressive-only design.

## Evidence and version boundary

**Review snapshot:** 2026-10-24. The local stable Flutter SDK reports **Flutter 3.47.7 / Dart 3.13.5**. Flutter API links below are live API documentation and can change independently of that SDK snapshot. The Material pages are canonical design sources; their text-accessible metadata confirms basic purpose and certain variant names, but does not expose every interactive spec, token, state, or illustration. Use the official page itself for visual details and re-check it before relying on exact requirements. No component is claimed fully verified or conformant based on metadata alone.

Flutter facts below describe the cited APIs, not guaranteed behavior on every release. Check the project's pinned SDK (`flutter --version`, analyzer and tests) before adopting properties, constructors, or state assumptions. Unless specifically stated, implementation suggestions are **repository recommendations**, not official requirements.

| Topic | Official Material source and verified scope | Flutter API starting point | Current coverage boundary |
|---|---|---|---|
| Button groups | [Button groups](https://m3.material.io/components/button-groups/overview): groups organize buttons and add interactions between them. Exact variants/anatomy require direct source review. | `SegmentedButton<T>` for bounded choice selection; otherwise compose ordinary button widgets. | No generic `ButtonGroup` Flutter widget is asserted. Segmented selection is not interchangeable with a group of independent actions. |
| Split buttons | [Split buttons](https://m3.material.io/components/split-button/overview): expose a menu of options related to an action. | Compose a primary button with an independently operable menu trigger, e.g. `MenuAnchor`. | No dedicated stock split-button mapping or expressive motion claim. |
| FAB menu | [FAB menu](https://m3.material.io/components/fab-menu/overview): opens from a FAB to present multiple related actions. | `FloatingActionButton` plus a menu/overlay composition, potentially `MenuAnchor`. | No dedicated stock FAB-menu API is asserted; interaction and animation need deliberate implementation and testing. |
| Badges | [Badges](https://m3.material.io/components/badges/overview): Material describes notification, count, or status information attached to navigation items/icons, with labels or numbers. Flutter's API describes a badge label as conveying a small amount of information about its child. | [`Badge`](https://api.flutter.dev/flutter/material/Badge-class.html). | API existence is verified; expressive-specific visual details and assistive-technology announcement behavior are not inferred. |
| Dividers | [Divider](https://m3.material.io/components/divider/overview): Material describes a thin line grouping content in lists and containers. Flutter describes dividers as separators for lists, drawers, and other content. | [`Divider`](https://api.flutter.dev/flutter/material/Divider-class.html), `VerticalDivider`, or `ListTile.divideTiles`. | Use and visual details still depend on context; do not treat every spacing boundary as a visible divider. |
| Side sheets | [Side sheets](https://m3.material.io/components/side-sheets/overview): secondary content anchored to a screen side; the page identifies standard and modal types. | No direct side-sheet widget asserted. `Scaffold.endDrawer` is a drawer alternative, not proof of side-sheet equivalence. | Pane behavior, sizing, motion, modal semantics, and breakpoint are not prescribed here. |
| Time pickers | [Time pickers](https://m3.material.io/components/time-pickers/overview): the page identifies dial and input types. | [`showTimePicker`](https://api.flutter.dev/flutter/material/showTimePicker.html), `TimePickerDialog`, `TimePickerTheme`. | Flutter API exposes entry modes; exact Material/M3E parity, locale conventions, and app-specific time rules need verification. |

## Button groups

**Design source:** Material describes button groups as organizing buttons and adding interactions between them. That purpose alone does not determine whether the group represents mutually exclusive choices, multiple selections, or independent actions. Read the specific source examples and requirements for the intended group before deciding its semantics.

**Flutter mapping:** `SegmentedButton<T>` is a relevant built-in for a bounded set of choices. Its Flutter API documents single selection by default, optional multi-selection, and app-managed selection state. It is not a generic wrapper for arbitrary adjacent actions. For independent actions, compose the appropriate button family and make grouping/layout an application decision; do not give actions radio/choice semantics just because they are adjacent.

**Implementation checks:**

- Name the group purpose and cardinality: exactly one, zero-or-one, one-or-more, or independent commands.
- Ensure each option has a meaningful text or semantic label; do not rely on icons or color alone.
- Verify selection announcements and keyboard traversal on the selected Flutter release and target screen readers.
- Check wrapping/overflow under large text, narrow widths, localization, and RTL. Avoid forcing a horizontal row when it clips.
- Test selected, unselected, disabled, focused, and pressed states that the chosen widget exposes; test hover only if the mobile app supports a pointer.

## Split buttons

**Design source:** the Material page describes a split button as opening a menu to offer options related to an action. Treat the primary action and the menu trigger as distinct commands: activating the primary portion should not unexpectedly open the menu, and activating the menu portion should not unexpectedly perform the primary action.

**Flutter mapping:** Flutter has button and menu building blocks, including `MenuAnchor`, but this page does not identify a dedicated stock split-button widget. A composed implementation is therefore a custom composition, not a Flutter-provided M3E component. Choose a composition only after checking the exact design anatomy in the canonical page; do not assume an icon button beside a button is automatically equivalent.

**Implementation checks:**

- Give both controls distinct accessible names and focus/activation behavior; identify the menu trigger as opening options.
- Keep menu actions related and avoid duplicating the primary action in a confusing way.
- Verify menu placement, dismissal, focus return, external-keyboard navigation where supported, touch use, and behavior near screen edges.
- Test disabled and loading states independently for the primary command and menu trigger; avoid a visually enabled menu trigger with no available options unless intentional.
- Confirm the composed hit targets remain distinguishable at text scale and in RTL.

## FAB menus

**Design source:** Material describes a FAB menu as opening from a FAB to show multiple related actions. The source establishes that purpose, but the locally accessible text does not establish all animation, arrangement, labels, or platform-specific details.

**Flutter mapping:** `FloatingActionButton` is a standard Flutter widget; a FAB menu requires an additional menu/overlay composition unless the project's selected SDK provides a suitable verified API. `MenuAnchor` can be considered as a lower-level anchored-menu building block, but is not itself a FAB menu specification. Verify the behavior in the pinned SDK before choosing it.

**Implementation checks:**

- Use the pattern only when the actions share a clear task context and the menu genuinely improves access; otherwise use visible actions or another navigation pattern.
- Expose a clear open/close state, menu-item labels, focus order, Escape/back dismissal as appropriate, and focus return to the trigger.
- Ensure actions remain reachable and do not overlap system controls, content, or the on-screen keyboard.
- Verify motion and reduced-motion behavior against current primary guidance; do not invent durations or easing values.
- Check phone/tablet screen sizes, touch interaction, supported external-keyboard use, screen-reader announcements, and whether the open menu obscures important content.

## Badges

**Design source and Flutter fact:** use the [Material badge guide](https://m3.material.io/components/badges/overview) for design intent. Flutter's [`Badge`](https://api.flutter.dev/flutter/material/Badge-class.html) supports an optional label; its API documents a small dot when there is no label and a labeled badge when a label is present. API existence does not prove exact M3E conformance or that every badge automatically communicates its value accessibly.

**Implementation checks:**

- Use a badge for concise supplementary information attached to a related item, not as the only carrier of critical status or a long message.
- Make the relationship between the badge and its child understandable in the semantics tree. Inspect actual screen-reader output; add or adjust semantics if necessary without duplicating announcements.
- Do not encode status or urgency by color alone. Keep counts concise and define the product's overflow/zero behavior explicitly.
- Verify clipping, overlap, contrast, text scaling, RTL placement, and tap-target behavior of the underlying control.

## Dividers

**Design source and Flutter fact:** a divider can separate related content groups; Flutter's [`Divider`](https://api.flutter.dev/flutter/material/Divider-class.html) is a thin horizontal line with surrounding padding and documents use in lists, drawers, and elsewhere. Flutter also exposes vertical/list-related divider tools. None of these facts requires a visible line between every pair of elements.

**Implementation checks:**

- First use spacing, headings, grouping, and alignment to establish hierarchy; add a divider when it improves scanning or communicates a meaningful boundary.
- Avoid visual clutter and repeated rules that weaken grouping. Do not treat a divider as a substitute for a heading or accessible group label.
- Check color contrast against adjacent surfaces, scaling/layout behavior, and consistency with the chosen component theme.
- If a boundary carries semantic meaning, expose that meaning through structure and labels rather than assuming the line itself communicates it. Inspect screen-reader output for unnecessary noise.

## Side sheets

**Design source:** Material identifies standard and modal side sheets as secondary content anchored at the side of the screen. The choice between them affects how the surrounding content remains available; follow the current component page for specific design rules. A side sheet is not automatically equivalent to a navigation drawer, bottom sheet, or dialog.

**Flutter mapping:** Flutter's `Scaffold.endDrawer` provides a drawer panel attached to the scaffold edge and is a possible starting point for a drawer interaction, but it does not establish side-sheet anatomy or standard/modal equivalence. A persistent side panel may instead need a responsive custom composition. Document this as custom work and validate it rather than claiming built-in support.

**Implementation checks:**

- Choose modal versus non-modal behavior according to the task and source guidance; define whether background content remains interactive and how dismissal works.
- For modal behavior, test focus containment/return, Escape/back behavior, barrier interaction, and assistive-technology announcements. For non-modal behavior, ensure the main task remains operable.
- Define width and placement from available mobile screen constraints rather than inventing a universal breakpoint. Support RTL edge placement and phone/tablet resizing.
- Check phone and tablet constraints, large text, keyboard/IME visibility, scrolling, and whether sheet content can be dismissed or reached without gestures alone.
- Keep navigation-drawer mappings distinct in documentation and semantics.

## Time pickers

**Design source:** the Material page identifies dial and input time-picker types. Flutter's [`showTimePicker`](https://api.flutter.dev/flutter/material/showTimePicker.html) opens a dialog and exposes `initialEntryMode`, among other options; the returned future can resolve to a selected `TimeOfDay` or `null` on cancellation. The Flutter API fact is not proof that the full design variants or every interaction match a particular M3E revision.

**Implementation checks:**

- Select the entry mode that fits the task and user context; verify that users can reach the alternative mode where appropriate.
- Check localized labels, 12/24-hour conventions, keyboard entry, dial interaction, validation/error copy, cancellation, and confirm behavior in the target locale.
- Treat time zone, date association, daylight-saving interpretation, allowed ranges, and business rules as application concerns; communicate them where ambiguity could affect the result.
- Test text scaling, phone/tablet constraints, RTL, screen-reader operation, focus movement, and the complete dialog dismissal/action model.
- Verify `TimePickerTheme` customization against the exact Flutter SDK and current design source; do not hard-code inferred tokens or motion.

## Cross-component validation checklist

For each component and target configuration, record the Flutter version, Android/iOS version, device form factor, available screen constraints, input mode, locale/direction, and accessibility tools used. Validate the relevant default, selected/open, disabled, focused, pressed, error, and dismissal states; check hover only if the mobile app supports a pointer. Check semantics, touch and any supported external input, contrast, large text, phone/tablet resizing, and RTL. Compare visual details with the official component source directly. Record application-specific choices separately from official design requirements and Flutter API facts.

## Sources

- Google Material Design: [Button groups](https://m3.material.io/components/button-groups/overview), [split buttons](https://m3.material.io/components/split-button/overview), [FAB menu](https://m3.material.io/components/fab-menu/overview), [badges](https://m3.material.io/components/badges/overview), [divider](https://m3.material.io/components/divider/overview), [side sheets](https://m3.material.io/components/side-sheets/overview), and [time pickers](https://m3.material.io/components/time-pickers/overview).
- Flutter API: [`SegmentedButton`](https://api.flutter.dev/flutter/material/SegmentedButton-class.html), [`MenuAnchor`](https://api.flutter.dev/flutter/material/MenuAnchor-class.html), [`FloatingActionButton`](https://api.flutter.dev/flutter/material/FloatingActionButton-class.html), [`Badge`](https://api.flutter.dev/flutter/material/Badge-class.html), [`Divider`](https://api.flutter.dev/flutter/material/Divider-class.html), [`Scaffold.endDrawer`](https://api.flutter.dev/flutter/material/Scaffold/endDrawer.html), and [`showTimePicker`](https://api.flutter.dev/flutter/material/showTimePicker.html).
- For the distinction among official intent, Flutter behavior, and local recommendations, see [design decision rules](../ai-agent-guide/design-decision-rules.md), [Flutter API reference](../reference/flutter-api-reference.md), and the [source catalog](../reference/official-sources.md).
