# Material 3 Expressive for Flutter

[![Expressive app bars, toolbars, and buttons](https://firebasestorage.googleapis.com/v0/b/design-spec/o/projects%2Fm3%2Fimages%2Fmoia5ltu-blog12.png?alt=media)](https://m3.material.io/blog/building-with-m3-expressive)

*Official Material 3 Expressive example. Open the [source article](https://m3.material.io/blog/building-with-m3-expressive).*

An independent, source-traceable guide for implementing Flutter interfaces informed by Material 3 Expressive (M3 Expressive). This repository is not an official Google or Flutter specification and does not certify conformance.

## What this repository covers

[![The expressive color system can create a wide range of accessible palettes](https://firebasestorage.googleapis.com/v0/b/design-spec/o/projects%2Fm3%2Fimages%2Fmoi9819i-blog4.png?alt=media)](https://m3.material.io/blog/building-with-m3-expressive)

*Official Material illustration about expressive color palettes; see the [source article](https://m3.material.io/blog/building-with-m3-expressive).*

- Material 3 Expressive design intent, scope, and evidence labels.
- Foundations, component selection, Flutter theming, and custom implementation decisions.
- Flutter mobile targets: Android and iOS phones, tablets, and foldables, with platform limitations called out.
- Responsive/adaptive layouts, accessibility, localization, testing, and AI-agent workflows.

## Mobile device visual references

The following supplementary images were supplied by the project maintainer, who confirmed permission to include them. Their original source and design-spec status have not been independently verified. Treat them as visual inspiration only—not official requirements, Flutter screenshots, or proof of M3 Expressive conformance.

| Phone app screens | Foldable entertainment layout |
|---|---|
| <a href="docs/assets/readme/01-phone-apps.png"><img src="docs/assets/readme/01-phone-apps.png" alt="Three phone app screens showing activity, email, and photos" width="320"></a> | <a href="docs/assets/readme/02-foldable-entertainment-layout.png"><img src="docs/assets/readme/02-foldable-entertainment-layout.png" alt="Foldable device displaying media and related content side by side" width="320"></a> |
| Foldable gallery and multitasking | iPad split view |
| <a href="docs/assets/readme/03-foldable-multitasking-gallery.png"><img src="docs/assets/readme/03-foldable-multitasking-gallery.png" alt="Foldable device showing a gallery beside other app content" width="320"></a> | <a href="docs/assets/readme/04-ipad-split-view.png"><img src="docs/assets/readme/04-ipad-split-view.png" alt="iPad split view with two apps and a draggable divider" width="320"></a> |
| Android tablet controls | |
| <a href="docs/assets/readme/05-android-tablet-notifications.png"><img src="docs/assets/readme/05-android-tablet-notifications.png" alt="Android tablet notification and quick settings interface" width="320"></a> | |

Flutter's Material library implements Material Design components and theming. Setting `ThemeData.useMaterial3` selects Flutter's Material 3 behavior; it does **not** prove that every M3 Expressive component, motion treatment, or platform behavior is implemented. Use the [support matrix](docs/reference/support-matrix.md) and [component verification ledger](docs/reference/component-verification-ledger.md) to determine what is API verified, configurable, custom, platform-dependent, or unverified.

## Foundation examples

### Typography

[![The updated type scale includes new emphasized text styles](https://firebasestorage.googleapis.com/v0/b/design-spec/o/projects%2Fm3%2Fimages%2Fmoi65wlg-blog1.png?alt=media)](https://m3.material.io/blog/building-with-m3-expressive)

*Official Material illustration; the article caption identifies the updated type scale and emphasized text styles. See the [source article](https://m3.material.io/blog/building-with-m3-expressive).*

Use typography as a hierarchy system, not a collection of arbitrary sizes. In Flutter, map the design roles to `TextTheme` entries and validate text scaling, long localization, and RTL flows. Exact expressive type-token values are not assumed unless the active Material source states them directly.

### Shape

[![Material shape library example](https://firebasestorage.googleapis.com/v0/b/design-spec/o/projects%2Fm3%2Fimages%2Fmoi7e8z9-blog3.png?alt=media)](https://m3.material.io/blog/building-with-m3-expressive)

*Official Material illustration; the article says its shape library includes 35 iconic shapes. See the [source article](https://m3.material.io/blog/building-with-m3-expressive).*

[![Material shape families shown in a labeled grid](https://firebasestorage.googleapis.com/v0/b/design-spec/o/projects%2Fgoogle-material-3%2Fimages%2Fm0c3rf47-3.png?alt=media)](https://m3.material.io/blog/building-with-m3-expressive)

*Official Material shape illustration. Use it to recognize visual families, not to infer Flutter APIs or exact token values; see the [source article](https://m3.material.io/blog/building-with-m3-expressive).*

[![Expressive image composition using varied geometric shapes](https://firebasestorage.googleapis.com/v0/b/design-spec/o/projects%2Fgoogle-material-3%2Fimages%2Fm0c35amt-1.png?alt=media)](https://m3.material.io/blog/building-with-m3-expressive)

*Official Material expressive imagery example. See the [source article](https://m3.material.io/blog/building-with-m3-expressive) for context.*

[![Material illustration pairing a wordmark with expressive geometric forms](https://firebasestorage.googleapis.com/v0/b/design-spec/o/projects%2Fgoogle-material-3%2Fimages%2Fm7pa01q8-4.png?alt=media)](https://m3.material.io/blog/building-with-m3-expressive)

*Official Material illustration. See the [source article](https://m3.material.io/blog/building-with-m3-expressive); do not treat the artwork as a reusable brand asset.*

For color roles, elevation, spacing, icons, motion, accessibility, and responsive design, use the [foundations guide](docs/foundations/index.md). Exact values are included only where the cited source supports them; unspecified values are not guessed.

## Component visual references

[![Expressive app bars, toolbars, and buttons](https://firebasestorage.googleapis.com/v0/b/design-spec/o/projects%2Fm3%2Fimages%2Fmoia5ltu-blog12.png?alt=media)](https://m3.material.io/blog/building-with-m3-expressive)

*Official Material example of expressive component styling. See the [source article](https://m3.material.io/blog/building-with-m3-expressive).*

The examples below are served from Google's Material Design hosting and link to the relevant official component guidance. They illustrate design intent; they are not Flutter renderings or proof of M3 Expressive parity.

### Buttons

[![Four button changes in the Expressive update](https://firebasestorage.googleapis.com/v0/b/design-spec/o/projects%2Fgoogle-material-3%2Fimages%2Fmmm1tos0-03.png?alt=media)](https://m3.material.io/components/buttons/overview)

*Official Material image. Read the [buttons guidance](https://m3.material.io/components/buttons/overview).*

### Cards

[![Three Material card variants](https://firebasestorage.googleapis.com/v0/b/design-spec/o/projects%2Fgoogle-material-3%2Fimages%2Flwuilyza-1.png?alt=media)](https://m3.material.io/components/cards/overview)

*Official Material image. Read the [cards guidance](https://m3.material.io/components/cards/overview).*

### Navigation bar

[![Material 3 Expressive navigation bar compared with the baseline navigation bar](https://firebasestorage.googleapis.com/v0/b/design-spec/o/projects%2Fgoogle-material-3%2Fimages%2Fmae7qe43-02.png?alt=media)](https://m3.material.io/components/navigation-bar/overview)

*Official Material image. The page describes the Expressive navigation bar as shorter than the baseline. Read the [navigation bar guidance](https://m3.material.io/components/navigation-bar/overview).*

### Chips

[![Four Material chip variants](https://firebasestorage.googleapis.com/v0/b/design-spec/o/projects%2Fgoogle-material-3%2Fimages%2Flzthj7vk-1.png?alt=media)](https://m3.material.io/components/chips/overview)

*Official Material image. Read the [chips guidance](https://m3.material.io/components/chips/overview).*

### Additional mobile component and interaction references

The following ten maintainer-supplied images are preserved in this repository and summarized by the visible patterns they depict. Their original source and specification status have not been independently verified. Use them as visual inspiration only; confirm component anatomy, states, sizing, and behavior against the linked official guidance and the Flutter verification ledger before implementation.

| Image | Visible pattern (summary only) |
|---|---|
| <a href="docs/assets/readme/13-expressive-quick-settings.png"><img src="docs/assets/readme/13-expressive-quick-settings.png" alt="Mobile expressive controls and quick settings shown at multiple sizes" width="320"></a> | A mobile screen collection showing compact and expanded toolbar actions, chips, and quick-setting controls at different sizes. |
| <a href="docs/assets/readme/14-expressive-mobile-apps-collage.png"><img src="docs/assets/readme/14-expressive-mobile-apps-collage.png" alt="Expressive music, finance, and messaging app screens" width="320"></a> | A collage combining music playback, a finance interface, and a messaging conversation to show varied app-level color and composition. |
| <a href="docs/assets/readme/15-rich-text-formatting-toolbar.png"><img src="docs/assets/readme/15-rich-text-formatting-toolbar.png" alt="Rich-text formatting toolbar with emphasis and color controls" width="320"></a> | A formatting toolbar with bold, italic, underline, text-color, and highlight controls. |
| <a href="docs/assets/readme/16-share-split-button.png"><img src="docs/assets/readme/16-share-split-button.png" alt="Share split button with a separate dropdown action" width="320"></a> | A two-part share action that separates the primary command from a dropdown affordance. |
| <a href="docs/assets/readme/17-slider-and-progress-indicators.png"><img src="docs/assets/readme/17-slider-and-progress-indicators.png" alt="Expressive linear slider and circular progress indicator" width="320"></a> | Linear and circular progress treatments with varied track thickness and shape. |
| <a href="docs/assets/readme/18-segmented-time-selector.png"><img src="docs/assets/readme/18-segmented-time-selector.png" alt="Day, week, and month segmented selector with Day selected" width="320"></a> | A three-option time-range selector with the Day option selected. |
| <a href="docs/assets/readme/19-expressive-actions-and-controls.png"><img src="docs/assets/readme/19-expressive-actions-and-controls.png" alt="Collection of expressive buttons, selection controls, sliders, and navigation actions" width="320"></a> | A broad control collage covering buttons, selection states, sliders, and compact navigation actions. |
| <a href="docs/assets/readme/20-foldable-bottom-action-bars.png"><img src="docs/assets/readme/20-foldable-bottom-action-bars.png" alt="Two mobile app action bars shown on overlapping device panes" width="320"></a> | Bottom app actions shown across overlapping device panes, useful as a composition reference for larger or foldable layouts. |
| <a href="docs/assets/readme/21-mobile-floating-action-button.png"><img src="docs/assets/readme/21-mobile-floating-action-button.png" alt="Mobile content view with a floating edit action and bottom actions" width="320"></a> | A floating edit action paired with a bottom row of content actions. |
| <a href="docs/assets/readme/22-mobile-bottom-action-bar.png"><img src="docs/assets/readme/22-mobile-bottom-action-bar.png" alt="Mobile bottom action bar with archive, bookmark, delete, and edit actions" width="320"></a> | A bottom action row showing archive, bookmark, delete, and edit affordances. |

### Supplementary mobile app and interaction imagery

These maintainer-supplied images are additional visual references, not verified component specifications. Compare them with the relevant official Material pages before making implementation decisions.

| Expressive mobile apps | Mobile music player |
|---|---|
| <a href="docs/assets/readme/06-expressive-mobile-apps.png"><img src="docs/assets/readme/06-expressive-mobile-apps.png" alt="Collage of expressive mobile application screens" width="320"></a> | <a href="docs/assets/readme/07-mobile-music-player.png"><img src="docs/assets/readme/07-mobile-music-player.png" alt="Music player screen on a phone" width="320"></a> |
| Mobile interface gallery | Mobile screen compositions |
| <a href="docs/assets/readme/08-expressive-app-gallery.png"><img src="docs/assets/readme/08-expressive-app-gallery.png" alt="Gallery of colorful expressive mobile app interfaces" width="320"></a> | <a href="docs/assets/readme/09-mobile-interface-compositions.png"><img src="docs/assets/readme/09-mobile-interface-compositions.png" alt="Multiple mobile interface compositions with varied color and layout" width="320"></a> |
| Messaging interface | Chat and calls |
| <a href="docs/assets/readme/10-mobile-messaging.png"><img src="docs/assets/readme/10-mobile-messaging.png" alt="Mobile messaging inbox with conversation list" width="320"></a> | <a href="docs/assets/readme/11-mobile-chat-and-calls.png"><img src="docs/assets/readme/11-mobile-chat-and-calls.png" alt="Mobile chat, call, and keyboard screens" width="320"></a> |
| Music playback controls | |
| <a href="docs/assets/readme/12-expressive-music-controls.png"><img src="docs/assets/readme/12-expressive-music-controls.png" alt="Expressive music playback controls on a mobile screen" width="320"></a> | |

[![Material example of expressive control shapes and component treatments](https://firebasestorage.googleapis.com/v0/b/design-spec/o/projects%2Fgoogle-material-3%2Fimages%2Fm0c73wle-8.png?alt=media)](https://m3.material.io/blog/building-with-m3-expressive)

*Official Material component illustration. Use it as visual context only; confirm component behavior and requirements in the relevant [component guide](docs/components/index.md) and [Flutter verification ledger](docs/reference/component-verification-ledger.md).*

For other component mappings, applicable states, Flutter SDK evidence, and visual-test gaps, see the [component catalog](docs/components/index.md), [component coverage matrix](docs/reference/component-coverage.md), and [verification ledger](docs/reference/component-verification-ledger.md).

The [Phase 0/1 audit](docs/reference/m3e-phase0-1-audit.md) records the documentation-readiness rubric and its limitations. Its [38-entry component inventory](docs/reference/m3e-master-component-inventory.csv) and [source-evidence ledger](docs/reference/m3e-source-evidence-ledger.csv) are audit artifacts, not M3E conformance claims.

## Start implementing

[![Material 3 Expressive navigation bar visual example](https://firebasestorage.googleapis.com/v0/b/design-spec/o/projects%2Fgoogle-material-3%2Fimages%2Fmae7qe43-02.png?alt=media)](https://m3.material.io/components/navigation-bar/overview)

*Official Material component reference; Flutter support and appearance must be checked separately.*

1. Read [scope and terminology](docs/getting-started/scope.md), [support matrix](docs/reference/support-matrix.md), and [AI-agent instructions](AGENTS.md).
2. Identify the target Flutter version, platforms, input modes, localization/RTL needs, and accessibility requirements.
3. Follow the relevant foundation and component pages. Separate official Material guidance from Flutter API facts and repository recommendations.
4. Prefer built-in Flutter Material widgets when their verified behavior meets the requirement. Add custom work only for a documented gap.
5. Run the [validation checklist](docs/ai-agent-guide/validation-checklist.md) and applicable tests; report what was not tested.

```dart
MaterialApp(
  theme: ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF6750A4),
    ),
  ),
  home: const MyHomePage(),
)
```

This is a Material 3 Flutter starting point, not an M3 Expressive compliance recipe. Define light/dark schemes, typography, and component themes deliberately, then validate the implementation against the applicable guidance.

## Documentation and sample app

[![Three Material card variants](https://firebasestorage.googleapis.com/v0/b/design-spec/o/projects%2Fgoogle-material-3%2Fimages%2Flwuilyza-1.png?alt=media)](https://m3.material.io/components/cards/overview)

*Official cards visual reference; the repository's Flutter sample is a separate, non-normative implementation example.*

| Topic | Start here |
|---|---|
| Scope, evidence labels, and quick setup | [Getting started](docs/getting-started/scope.md) |
| Foundations | [Foundations index](docs/foundations/index.md) |
| Components | [Components index](docs/components/index.md) |
| Flutter architecture, theme, custom widgets, tests | [Flutter guide](docs/flutter/index.md) |
| Android and iOS mobile apps | [Platform guidance](docs/platforms/index.md) |
| Screen recipes | [Design recipes](docs/design-recipes/index.md) |
| AI coding-agent workflow | [AGENTS.md](AGENTS.md) and [agent guide](docs/ai-agent-guide/index.md) |
| Official source and visual references | [Source catalog](docs/reference/official-sources.md), [visual gallery](docs/reference/visual-reference-gallery.md) |
| Flutter sample app and official visual references | [Reference app](examples/flutter/reference_app/) |

## Build and validate

[![Material 3 Expressive button update example](https://firebasestorage.googleapis.com/v0/b/design-spec/o/projects%2Fgoogle-material-3%2Fimages%2Fmmm1tos0-03.png?alt=media)](https://m3.material.io/components/buttons/overview)

*Official button visual reference. Use actual Flutter/platform captures as well as automated tests when validating a product.*

Build the documentation from the repository root:

```bash
python -m pip install -r requirements.txt
python scripts/validate_docs.py
python scripts/validate_links.py
mkdocs build --strict
```

Validate the standalone Flutter example from `examples/flutter/reference_app/`:

```bash
flutter pub get
flutter analyze
flutter test
```

Flutter widget-test goldens are regression fixtures for the test renderer, not Android or iOS device screenshots; see the [testing guide](docs/flutter/testing.md). No single automated test establishes accessibility or M3 Expressive conformance.

## Evidence, limitations, and image attribution

[![Four Material chip variants](https://firebasestorage.googleapis.com/v0/b/design-spec/o/projects%2Fgoogle-material-3%2Fimages%2Flzthj7vk-1.png?alt=media)](https://m3.material.io/components/chips/overview)

*Official Material image; open the [chips guidance](https://m3.material.io/components/chips/overview) for source context.*

Material's interactive pages may not expose every specification detail through text retrieval. The [source catalog](docs/reference/official-sources.md) and [component verification ledger](docs/reference/component-verification-ledger.md) state what was actually checked. Visuals and behavior still require review on intended Android and iOS devices, including relevant phone/tablet form factors, text scales, locales, touch input, and assistive technologies.

Official Material illustrations in this README are embedded from Google-hosted pages and link to their source pages; those files are not copied into this repository, and rights remain with their respective owners. Maintainer-supplied supplementary images are stored unchanged under [`docs/assets/readme/`](docs/assets/readme/) with permission from the project maintainer; their original sources and specification status have not been independently verified. Do not treat either group of images as Flutter screenshots or proof of conformance. See [Google Terms of Service](https://policies.google.com/terms) and the relevant Material source pages for current terms.

The original source list is preserved in [link_sources.md](link_sources.md) and the source catalog in [docs/reference/official-sources.md](docs/reference/official-sources.md). To report an inaccuracy or propose a source-backed change, follow [contribution guidance](CONTRIBUTING.md). The repository intentionally makes no claim of universal or 100% compliance.
