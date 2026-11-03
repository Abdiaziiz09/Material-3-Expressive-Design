# Typography

Typography establishes hierarchy, readability, and emphasis. Material 3 defines a role-based type scale; Flutter exposes `TextTheme` and `Typography`. Use the official [Material typography guidance](https://m3.material.io/styles/typography/overview) and Flutter [TextTheme API](https://api.flutter.dev/flutter/material/TextTheme-class.html).

## Apply the scale

- Map content purpose to a named text role instead of selecting a size by visual guess.
- Use hierarchy consistently; expressive emphasis should be intentional and limited to information that needs attention.
- Do not invent an "expressive" Flutter text style or assume Flutter's default `TextTheme` exactly matches a current M3 Expressive spec.
- Preserve user text scaling; avoid fixed-height text containers and clipping.
- Choose font families with the required script coverage and test fallback, weight availability, and line wrapping.

A practical Flutter mapping is to start from `ThemeData.textTheme` and tune only the roles required for the app. Example:

```dart
ThemeData(
  useMaterial3: true,
  textTheme: Typography.material2021().black.copyWith(
    displayLarge: const TextStyle(fontWeight: FontWeight.w400),
    headlineMedium: const TextStyle(fontWeight: FontWeight.w500),
    titleLarge: const TextStyle(fontWeight: FontWeight.w600),
    bodyLarge: const TextStyle(fontWeight: FontWeight.w400),
    labelLarge: const TextStyle(fontWeight: FontWeight.w500),
  ),
);
```

This is a template for a Flutter theme, not a guarantee of a current M3 Expressive token set. Verify role names and exact values against the target design source and SDK. Many expressive variants are design decisions that remain component- and app-specific unless a direct official source states otherwise.

## Verification

Review headings, body, labels, numeric content, long translations, large text scale, and RTL. Confirm text remains readable and controls grow or reflow instead of clipping. Verify that long translations, dense layouts, and phone/tablet constraints do not force overflow or cut off essential labels.
