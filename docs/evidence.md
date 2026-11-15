# Evidence and source register

Use this page and the linked source records to separate design guidance from implementation facts. URLs, component names, API listings, and historic test records are not proof that the current target app conforms.

## Authority and decision rules

1. Use current official Material guidance for design intent.
2. Use the target app's versioned Flutter documentation/source for API availability and behavior.
3. Use Android, Apple, and applicable accessibility sources for platform behavior.
4. Treat community implementations and repository snippets as non-normative examples.
5. Where sources do not prescribe a detail, state that it is unspecified and label the chosen app-specific decision.

Prefer the most specific applicable source. Record disagreements rather than silently selecting a convenient interpretation. Do not infer exact dimensions, states, motion, or component anatomy from screenshots, theme flags, names, or issue titles.

## Primary sources

### Material

- [Material 3 Expressive overview](https://m3.material.io/blog/building-with-m3-expressive)
- [Material Motion overview](https://m3.material.io/styles/motion/overview/how-it-works) — accessible page metadata describes motion as a way to make UI expressive and easy to use; detailed page content could not be fully retrieved in this review.
- [Color roles](https://m3.material.io/styles/color/roles)
- [Typography](https://m3.material.io/styles/typography/overview)
- [Shape principles](https://m3.material.io/styles/shape/overview-principles)
- [Elevation](https://m3.material.io/styles/elevation/overview)
- [Motion](https://m3.material.io/styles/motion/overview/how-it-works)
- Component-specific links are listed in [Components](components.md#component-validation).

### Flutter

- [Material overview](https://docs.flutter.dev/ui/design/material)
- [ThemeData](https://api.flutter.dev/flutter/material/ThemeData/ThemeData.html), [ColorScheme](https://api.flutter.dev/flutter/material/ColorScheme-class.html), and [TextTheme](https://api.flutter.dev/flutter/material/TextTheme-class.html)
- [Adaptive and responsive design](https://docs.flutter.dev/ui/adaptive-responsive)
- [Accessibility](https://docs.flutter.dev/ui/accessibility-and-internationalization/accessibility)
- [Testing](https://docs.flutter.dev/testing)
- [Material/Cupertino package migration](https://docs.flutter.dev/release/breaking-changes/material-ui-and-cupertino-ui)
- [M3 Expressive component migration checklist](https://github.com/flutter/flutter/blob/master/docs/ecosystem/material_ui/Material-3-Expressive-component-migration-checklist.md) — Flutter implementation guidance, not a universal app-level M3E requirement.
- [Animation guide](https://docs.flutter.dev/ui/animations) and [physics simulation recipe](https://docs.flutter.dev/cookbook/animation/physics-simulation)

### AndroidX Compose implementation evidence (reviewed 2026-11-15)

- [Material 3 Compose guide](https://developer.android.com/develop/ui/compose/designsystems/material3) describes M3 Expressive as including updates to motion among other design areas.
- [AndroidX Compose `MotionScheme` API](https://developer.android.com/reference/kotlin/androidx/compose/material3/MotionScheme) describes a harmonious scheme for components, distinguishes spatial specs (shape/bounds changes) from effects specs (such as color), and documents expressive motion for prominent/hero interactions versus standard motion for utilitarian/repeated interactions. This is evidence for the Compose implementation and a useful decision model; it does not establish a Flutter API or exact Flutter motion values.
- Flutter API references used for contextual examples: [`SpringSimulation`](https://api.flutter.dev/flutter/physics/SpringSimulation-class.html), [`AnimationController.fling`](https://api.flutter.dev/flutter/animation/AnimationController/fling.html), [`InkWell`](https://api.flutter.dev/flutter/material/InkWell-class.html), [`InkResponse`](https://api.flutter.dev/flutter/material/InkResponse-class.html), [`Material`](https://api.flutter.dev/flutter/material/Material-class.html), [`Hero`](https://api.flutter.dev/flutter/widgets/Hero-class.html), [`AnimatedList`](https://api.flutter.dev/flutter/widgets/AnimatedList-class.html), [`AnimatedSwitcher`](https://api.flutter.dev/flutter/widgets/AnimatedSwitcher-class.html), [`AnimatedContainer`](https://api.flutter.dev/flutter/widgets/AnimatedContainer-class.html), and [`TweenAnimationBuilder`](https://api.flutter.dev/flutter/widgets/TweenAnimationBuilder-class.html).

### Platforms

- [Android design guidance](https://developer.android.com/design/ui) and [foldables](https://developer.android.com/develop/ui/compose/layouts/adaptive/foldables/learn-about-foldables)
- [Apple Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/)

## Preserved research data

The following artifacts are retained as research snapshots, not current runtime capabilities:

- [`m3e-master-component-inventory.csv`](m3e-master-component-inventory.csv) and [`m3e-master-component-inventory.json`](m3e-master-component-inventory.json): a historical 38-row component inventory.
- [`m3e-source-evidence-ledger.csv`](m3e-source-evidence-ledger.csv): evidence notes tied to the historical audit.

The accompanying audit was dated 2026-10-24; platform/API source updates were recorded through 2026-11-03. The audit's 57/100 value is historical documentation-readiness, not conformance or a current assessment. Its API/test rows refer to a removed sample app and must not be presented as validation of present code.

Recheck upstream pages and the target app's SDK before implementation. Source verification means only what the record explicitly says (for example, URL/title metadata versus full visual/interaction review); do not silently upgrade an evidence grade.

## Repository validation

From the repository root:

```bash
python scripts/validate_docs.py
python scripts/validate_links.py
mkdocs build --strict
```

This repository has no Flutter app to analyze or test. Flutter validation must run in the target application and its actual SDK environment.
