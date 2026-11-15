# Design foundations

Material 3 Expressive uses design to make hierarchy, information, and actions clearer. Apply the relevant source to the task; do not add expressive treatments merely for decoration. See the [official source catalog](evidence.md#primary-sources).

## Color

- Use semantic `ColorScheme` roles for their intended purpose and verify foreground/background contrast.
- Configure and test light and dark schemes. `ColorScheme.fromSeed` is a Flutter API, not proof of exact M3E palette fidelity.
- Dynamic color depends on target OS, package/API, and fallback behavior; verify support for each platform.
- Do not treat role names as proof of contrast after custom colors, imagery, or opacity are applied.

## Typography

- Start from semantic `TextTheme` roles chosen by content purpose, not by visual guess.
- Respect platform text scaling. Allow long content and translations to wrap; avoid fixed-height text containers.
- Verify font/script coverage, fallback behavior, line wrapping, and RTL.
- Do not claim that a default Flutter text theme exactly implements current M3E typography.

## Shape

- Select shapes based on component intent and direct design evidence.
- The [token sample](m3e_tokens.dart) contains only optional app-local rounded-corner examples. This repository does not implement expressive shape geometry, clipping paths, or shape morphing.
- A shape name or screenshot does not specify a Flutter path. Verify geometry and interaction behavior before implementing custom clipping.
- Preserve readable content, visible focus, and usable rectangular hit regions.

## Surfaces and elevation

- Use semantic surface roles to establish page, container, and overlay hierarchy.
- Elevation and surface color are related but not interchangeable. Avoid relying on arbitrary shadows as the only hierarchy cue.
- Check cards, menus, sheets, and overlays in light/dark themes and at relevant contrast settings.

## Spacing and layout

- Material sources describe grid and spacing principles; the exact values, maximum widths, pane sizes, and breakpoints in an app are product decisions unless the cited source specifies otherwise.
- Use named tokens provided by the target app. The optional sample defines a small example scale, not a Material token package.
- Prefer logical directional insets for RTL. Use available constraints rather than platform name or assumed device width to choose a layout.
- Recompose for available space; do not simply stretch a phone layout across tablets or foldables.
- Avoid fixed text bounds. Use scrollable content, flexible children, and app-specific maximum widths where useful.

```dart
LayoutBuilder(
  builder: (context, constraints) {
    if (constraints.maxWidth >= appBreakpoints.expandedMin) {
      return const ExpandedLayout();
    }
    return const CompactLayout();
  },
)
```

`appBreakpoints` is an application-defined example, not a repository runtime API or universal Material breakpoint.

## Motion

- Use motion when it communicates state, feedback, or spatial relationships and the applicable source supports it.
- The optional token sample has example durations and curves only. This repository does not prescribe universal motion tokens or implement spring simulations.
- Respect operating-system reduced-motion settings. Preserve an understandable end state when nonessential animation is removed.
- Dispose animation controllers, support interruption, and test rapid repeated input.

## Icons

- Prefer icons with established meaning; provide accessible labels for icon-only actions.
- Verify asset availability, size, alignment, contrast, and script/platform rendering.
- Do not use color, shape, or motion alone to convey an essential state.

## Accessibility

Accessibility is part of implementation, not a final visual polish step.

- Use semantic controls and meaningful labels; verify TalkBack and VoiceOver output on supported platforms.
- Preserve text scaling, visible focus, logical focus order, and supported external input.
- Verify contrast, state cues beyond color, dialog/menu focus behavior, and error announcements.
- Follow target-platform touch guidance and any separately required conformance criteria; these have different scopes.
- Test large text, long/localized labels, RTL, reduced motion, and keyboard/IME interactions.
- Report accessibility checks that could not be performed.

## Responsive and adaptive decisions

Responsive design fits content to available space; adaptive design also chooses a usable composition and interaction. There is no single breakpoint that fits every app. Document app-specific thresholds and test supported phones, tablets, foldables, orientations, and resized windows.

## Primary sources

- [Material color roles](https://m3.material.io/styles/color/roles)
- [Material typography](https://m3.material.io/styles/typography/overview)
- [Material shape principles](https://m3.material.io/styles/shape/overview-principles)
- [Material elevation](https://m3.material.io/styles/elevation/overview)
- [Material layout and spacing](https://m3.material.io/foundations/layout/grids-spacing/overview)
- [Material motion](https://m3.material.io/styles/motion/overview/how-it-works)
- [Flutter accessibility](https://docs.flutter.dev/ui/accessibility-and-internationalization/accessibility)
- [Flutter adaptive and responsive design](https://docs.flutter.dev/ui/adaptive-responsive)
