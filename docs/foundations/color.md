# Color

## Intent and roles

**Material guidance:** Material 3 uses semantic color roles rather than assigning arbitrary hues to widget types. Accent groups include primary, secondary, and tertiary, and paired `on*` roles are intended for content drawn on corresponding fills. Neutral roles describe surfaces; Flutter's documented `ColorScheme` includes `surface`, surface-container roles, and semantic roles. See [Material color roles](https://m3.material.io/styles/color/roles) and Flutter's [`ColorScheme`](https://api.flutter.dev/flutter/material/ColorScheme-class.html).

Use a role for its semantic purpose and validate contrast for the actual pairing. A role name alone is not a substitute for checking custom overrides, images, opacity, or text size.

## Light, dark, and dynamic schemes

Flutter supports light/dark `ThemeData` and `ColorScheme`. Create both schemes and let the app's `themeMode` reflect the user or system preference. `ColorScheme.fromSeed` is a Flutter Material scheme-generation API, not proof of exact M3 Expressive color fidelity.

Dynamic color is platform/package-dependent. Verify whether the chosen package/API supports the target Android or iOS version before enabling it; do not assume Android wallpaper color behavior is available on iOS. Provide a stable fallback scheme, allow user preference where appropriate, and test contrast after dynamic colors are applied.

## Implementation

- Use semantic `ColorScheme` properties and component themes.
- Keep custom brand colors semantically mapped and verify text/icon contrast.
- Test light and dark schemes, disabled states, overlays, selection, error, and focus.
- Do not claim specific color values are official unless linked to the exact source/token and mode.

**Flutter example:** see [theme configuration](../flutter/theme-configuration.md).

## Validation

Check semantic role mapping, text and icon contrast, disabled legibility, state distinction without color alone, and all supported scheme variants. See [accessibility](accessibility.md).
