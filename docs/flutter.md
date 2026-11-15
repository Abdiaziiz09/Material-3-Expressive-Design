# Flutter implementation

This repository contains documentation and snippets only. It does not publish a Flutter package or runnable app. Verify every API against the target application's `pubspec.yaml`, lockfile, Flutter/Dart version, platform targets, and existing code.

## Setup and dependencies

Use Flutter's current [installation](https://docs.flutter.dev/get-started/install), [Android](https://docs.flutter.dev/platform-integration/android), and [iOS](https://docs.flutter.dev/platform-integration/ios) documentation. Pin dependencies intentionally. Do not add a package or copy an example import unless it exists in the target app.

Flutter's Material libraries and standalone packages evolve across SDK versions. Read the current [Material/Cupertino package migration guide](https://docs.flutter.dev/release/breaking-changes/material-ui-and-cupertino-ui) before selecting imports. Do not mix types from incompatible Material libraries.

## Dart and Flutter code style

Write code in idiomatic Dart using Flutter's established APIs and widget-composition patterns. Follow the target project's Dart SDK constraints, `analysis_options.yaml`, formatter, lints, and existing conventions. If no project-specific rules exist, use the [Dart style guide](https://dart.dev/effective-dart/style) and [documentation guidance](https://dart.dev/effective-dart/documentation), and format with `dart format`.

Write code comments in clear, professional English. Add a concise explanation for the responsibility of each meaningful class, widget, and function so readers can understand each part without inferring its role from implementation details alone. Use Dart documentation comments (`///`) for public APIs. Add focused comments for non-obvious logic, constraints, and trade-offs; do not narrate every line or repeat what clear names and code already communicate. Keep comments near the relevant code and update them when behavior changes.

## Theme configuration

```dart
import 'package:flutter/material.dart';

ThemeData buildTheme(Color seed, Brightness brightness) {
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: seed,
      brightness: brightness,
    ),
  );
}

Widget buildApp(Color brandSeedColor, Widget home) {
  return MaterialApp(
    theme: buildTheme(brandSeedColor, Brightness.light),
    darkTheme: buildTheme(brandSeedColor, Brightness.dark),
    themeMode: ThemeMode.system,
    home: home,
  );
}
```

This is a Flutter Material 3 starting point, not an M3E compliance recipe or exact brand palette. Add typography, component themes, dynamic color, and app-local tokens only when requirements and evidence justify them. Use `Theme.of(context).colorScheme` and `.textTheme` as the standard Flutter theme surfaces.

## App-local token example

The optional [token sample](m3e_tokens.dart) demonstrates app-local spacing and shape values through a small `context.m3e` extension. It is code to copy into an app, not a package dependency or API available automatically in Flutter. Its values are project choices; they are not a complete or official Material token system. It intentionally provides no generic motion-duration or curve tokens: choose motion for the actual widget and transition as described in [Foundations](foundations.md#motion). Do not write code using this extension unless you add its implementation to the target app.

Prefer the target app's existing design tokens. If no token system exists, use a small, named app-local set only when repeated values justify it. Do not invent imports such as `m3d.design` or pretend the sample is already installed.

## Choosing an animation API

Select an animation API after defining the interaction; do not start by applying the same effect to every widget.

| Need | Flutter starting point | Fit and limits |
|---|---|---|
| Animate a property when its target changes | `AnimatedContainer`, `AnimatedScale`, or another implicit animation | Good for simple state-driven property changes; the animated container does not animate its child or descendants |
| Replace one child with another | `AnimatedSwitcher` | Supports custom transitions; use distinct keys when a changed child must be treated as a new child |
| Show the same visual element continuing between routes | `Hero` | Use matching tags and compatible layouts; reserve for meaningful continuity |
| Insert or remove list content | `AnimatedList` or `AnimatedGrid` | Use for structural changes, not as an automatic animation for every list rebuild |
| Drive a gesture-linked or physics-based movement | `AnimationController` with `SpringSimulation` or the appropriate simulation | Use when velocity/physical settling is relevant; manage controller lifecycle and interruption |
| Animate a numeric value | `TweenAnimationBuilder` or a custom transition | Number roll-up is a custom UI pattern, not an asserted M3E component or built-in Material widget |

These APIs are alternatives, not a checklist. Prefer the least complex mechanism that communicates the particular state change. A Material component may already provide appropriate interaction feedback; avoid wrapping it in duplicate ripple or scale behavior.

Material 3 Expressive's AndroidX Compose [MotionScheme](https://developer.android.com/reference/kotlin/androidx/compose/material3/MotionScheme) separates spatial changes from effects and distinguishes expressive prominent/hero interactions from standard utilitarian/repeated ones. That API is Kotlin/Compose-specific. Flutter apps should use Flutter APIs and target-app conventions, applying the same contextual reasoning without importing or pretending to have Compose's `MotionScheme`.

### Motion accessibility and lifecycle

- Flutter's [`MediaQueryData.disableAnimations`](https://api.flutter.dev/flutter/widgets/MediaQueryData/disableAnimations.html) describes Android's remove-animations request. iOS reduced motion is exposed separately through [`AccessibilityFeatures.reduceMotion`](https://api.flutter.dev/flutter/dart-ui/AccessibilityFeatures/reduceMotion.html).
- `AnimationController` adapts to the framework's `disableAnimations` signal. Since iOS exposes reduced motion separately, custom motion must also account for the target platform's `reduceMotion` accessibility feature where applicable.
- Dispose controllers and listeners; verify rapid repeated input, cancellation, route changes, and widget removal.
- Animated numbers must preserve a correct final value and useful semantics; do not make screen readers announce every intermediate frame.

## Architecture

See [Project structure and coding guidance](https://github.com/Abdiaziiz09/Flutter-M3E-Design/blob/main/ai-rules-project-structure.md). Feature-first organization is a scalable option, not a rule for every app. Reuse the target app's state, routing, error, and dependency patterns. Avoid adding BLoC, GetIt, GoRouter, or result-type packages unless they are already used or a documented need warrants the dependency.

## Error handling and lifecycle

- Model loading, empty, success, and failure states when the feature needs them.
- Surface failures using the target app's established logging and user-notification patterns; do not silently swallow errors or return success-shaped fallbacks.
- Dispose controllers and subscriptions; consider app lifecycle, interruption, cancellation, and repeated user input.
- Preserve user input when validation errors can be corrected.

## Testing

Use Flutter's [testing guidance](https://docs.flutter.dev/testing). Choose tests that cover behavior:

- Unit tests for pure logic and state transitions.
- Widget tests for composition, callbacks, semantics, keyboard focus, and themes.
- Integration tests for navigation and OS/plugin behavior on target devices.
- Visual comparisons for representative sizes and states, reviewed alongside manual inspection.

Run relevant commands in the **target app**:

```bash
flutter --version
flutter analyze
flutter test
```

Run integration tests only when such tests and suitable devices are configured. This documentation repository has no Flutter test target. Do not infer accessibility, platform behavior, or M3E conformance from successful analysis or screenshot equality.

## Copying snippets

Inspect the entire snippet and surrounding imports, replace example names such as `brandSeedColor` with app-owned values, verify API signatures for the pinned SDK, format and analyze it using the target project's tools, and run relevant tests after adapting. Add English comments to explain the responsibility of meaningful code units and any non-obvious choices. Label custom choices and state unsupported behavior explicitly.
