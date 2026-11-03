# Android foldables and large mobile screens

This guide covers Android foldables in the repository's Flutter mobile scope. An iPad's multitasking or resized app window is a large-screen layout change, not an Android hinge/posture feature; use the [iOS guide](ios.md) for iPad behavior.

## Responsive layout and adaptation

Flutter distinguishes responsive design (fitting content into available space) from adaptive design (choosing a usable composition and interaction model for that space). Start from the app's actual constraints and task. A folded cover screen may call for a compact, single-pane composition; an unfolded screen may make a list-detail or supporting-pane layout useful. These are design options, not mandatory mappings or universal breakpoint rules.

- Use the space available to the app, not an assumed physical screen size, as the normal layout input.
- Recompose content when space or orientation changes; do not simply stretch a phone layout across a larger display.
- If the app uses layout thresholds, name and document them as application-specific choices and validate them on supported devices.
- Keep actions, text, menus, and dialogs clear of hinges, folds, and cutouts. Avoid placing essential controls across an obstructed or hard-to-read area.
- Preserve the user's task and state across folded/unfolded and orientation changes where the app's architecture permits; verify the actual lifecycle behavior on target devices.

For general responsive/adaptive decisions, see [responsive design](../foundations/responsive-design.md) and Flutter's [large-screen guidance](https://docs.flutter.dev/ui/adaptive-responsive/large-screens).

## Android display features in Flutter

Flutter's [`MediaQueryData.displayFeatures`](https://api.flutter.dev/flutter/widgets/MediaQueryData/displayFeatures.html) reports display features that obstruct hardware display areas. The current API documentation states this list is populated **only on Android**; it is empty when there are no display features. Inspect the reported feature type, bounds, and folding state rather than treating every crease, hinge, or cutout as the same.

[`DisplayFeatureSubScreen`](https://api.flutter.dev/flutter/widgets/DisplayFeatureSubScreen-class.html) can position a child in a sub-screen that avoids a display feature dividing the view. It is a focused layout aid, not a complete two-pane design system. Confirm its behavior and API availability against the Flutter SDK version used by the app.

Do not present `displayFeatures` as cross-platform fold detection or assume that a lack of reported features proves a device has no hinge. iPad multitasking should be handled from its available app constraints and iOS behaviors, not this Android-only API.

## Validation checklist

Validate only device configurations the app claims to support:

- Folded/cover and unfolded layouts, portrait and landscape.
- Book or tabletop posture when supported by the device and app; keep critical content and controls usable in each posture.
- Split-screen or other supported Android multi-window sizes.
- Menus, dialogs, keyboard/IME, navigation, and focus/semantics near display-feature boundaries.
- Continuity of the current destination, selection, entered content, and scroll position through size and posture changes.
- Large text, contrast, touch targets, TalkBack, and RTL in compact and expanded layouts.

Use a supported foldable emulator or physical device to verify hinge and posture behavior. Ordinary phone/tablet widget goldens cannot establish actual hinge, posture, lifecycle, or Android system behavior. If no suitable device is available, state that limitation instead of claiming foldable validation.

## Sources and scope

- Flutter: [Adaptive and responsive design](https://docs.flutter.dev/ui/adaptive-responsive) and [large screens](https://docs.flutter.dev/ui/adaptive-responsive/large-screens). The Flutter guide covers additional targets outside this repository's scope; apply only its relevant mobile guidance.
- Flutter API: [`MediaQueryData.displayFeatures`](https://api.flutter.dev/flutter/widgets/MediaQueryData/displayFeatures.html) and [`DisplayFeatureSubScreen`](https://api.flutter.dev/flutter/widgets/DisplayFeatureSubScreen-class.html).
- Android: [Learn about foldables](https://developer.android.com/develop/ui/compose/layouts/adaptive/foldables/learn-about-foldables). This source provides Android foldable concepts and examples; its Compose-specific implementation details are not Flutter APIs.
