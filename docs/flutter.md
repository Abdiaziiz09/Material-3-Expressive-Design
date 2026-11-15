# Flutter implementation

This repository contains documentation and snippets only. It does not publish a Flutter package or runnable app. Verify every API against the target application's `pubspec.yaml`, lockfile, Flutter/Dart version, platform targets, and existing code.

## Setup and dependencies

Use Flutter's current [installation](https://docs.flutter.dev/get-started/install), [Android](https://docs.flutter.dev/platform-integration/android), and [iOS](https://docs.flutter.dev/platform-integration/ios) documentation. Pin dependencies intentionally. Do not add a package or copy an example import unless it exists in the target app.

Flutter's Material libraries and standalone packages evolve across SDK versions. Read the current [Material/Cupertino package migration guide](https://docs.flutter.dev/release/breaking-changes/material-ui-and-cupertino-ui) before selecting imports. Do not mix types from incompatible Material libraries.

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

The optional [token sample](m3e_tokens.dart) demonstrates a small `context.m3e` extension. It is code to copy into an app, not a package dependency or API available automatically in Flutter. Its values are project choices; they are not a complete or official Material token system. Do not write code using this extension unless you add its implementation to the target app.

Prefer the target app's existing design tokens. If no token system exists, use a small, named app-local set only when repeated values justify it. Do not invent imports such as `m3d.design` or pretend the sample is already installed.

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

Inspect the entire snippet and surrounding imports, replace example names such as `brandSeedColor` with app-owned values, verify API signatures for the pinned SDK, and run analyzer/tests after adapting. Label custom choices and state unsupported behavior explicitly.
