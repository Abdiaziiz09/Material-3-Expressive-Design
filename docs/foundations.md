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

Motion is selected for the widget, action, and state change being implemented. Do not treat spring, ripple, shape morphing, scale, or number-ticker animation as a required bundle for every app or component. Add motion only when it improves feedback, continuity, hierarchy, or comprehension.

### Select motion by intent

1. Identify the widget's role, the user action or state change, and what the user needs to understand.
2. Classify the property being animated:
   - **Effects:** color, opacity, or other changes that do not alter the component's shape or bounds.
   - **Spatial:** position, size, bounds, or shape changes.
3. Consider prominence and repetition. A prominent action or meaningful shared transition may justify more expressive motion; a frequently repeated utility control usually benefits from restrained, quick feedback.
4. Choose the simplest Flutter animation that communicates the change. Use existing Material control feedback when it already meets the need.
5. Verify the actual design source, target SDK behavior, interruption handling, and reduced-motion behavior. Treat unsourced timings and curves as application choices.

AndroidX Compose Material 3 Expressive documents this intent-sensitive approach in its [MotionScheme API](https://developer.android.com/reference/kotlin/androidx/compose/material3/MotionScheme): it distinguishes spatial from effects specs and describes expressive motion for prominent UI/hero interactions versus standard motion for utilitarian and recurring interactions. This is **Compose-specific implementation guidance**, not a Flutter API or a universal Flutter prescription; use it as a decision model, not as Kotlin code to copy into Flutter.

| Widget/task context | Motion that may fit | Avoid assuming |
|---|---|---|
| Repeated button, switch, or selection control | Existing Material pressed/selected feedback; restrained state change | Every tap needs a spring or scale bounce |
| Dragged or flung object | Velocity-aware physics when the object should continue or settle naturally | A visibly oscillating spring is always desirable |
| Content or control changes position, size, or shape | Spatial transition when it helps users follow continuity | Shape morphing is supported for every pair of shapes |
| Navigation to the same content in a new view | Shared-element transition when it clarifies continuity | Every route needs a `Hero` transition |
| Item enters or leaves a list | Insert/remove animation when it preserves orientation | Every rebuild should animate the entire list |
| Important value changes | Number/count transition only when it improves understanding | Every number should roll or tick |

These are examples for making a decision, not a component-to-animation mandate. An application's motion choices should remain coherent while allowing different widgets and tasks to use different patterns.

The optional token example no longer defines generic durations or curves: this repository has no source-backed universal motion token set. Use the target app's verified motion system or choose and document app-specific values for the actual transition.

Respect operating-system reduced-motion settings and preserve an understandable end state when nonessential animation is reduced or skipped. Dispose animation controllers, support interruption, and test rapid repeated input.

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
