# Source catalog

Reviewed 2026-10-23 where access status says **Verified**. "Verified" means the URL resolved and its title or relevant API content was inspected; it does not mean every page detail was extracted. Material Design uses interactive pages, and some could not be retrieved in text. Re-check upstream before relying on version-sensitive claims.

## Material 3 Expressive and Material Design

| Title | Publisher / category | URL | Supports | Status and limitations |
|---|---|---|---|---|
| Material Design | Google / Material home | https://m3.material.io/ | Canonical design system entry | URL present in supplied source list; individual page content not fully inspected. |
| M3 Expressive: Engaging UX Design | Google / M3E blog | https://m3.material.io/blog/building-with-m3-expressive | M3E framing and design intent | Page title/metadata retrieved; article body not reliably available in text. |
| Usability | Google / foundation | https://m3.material.io/foundations/usability/overview | Usability and expressive design intent | Metadata retrieved; full body not available in text. |
| Color roles | Google / foundation | https://m3.material.io/styles/color/roles | Material semantic color guidance | URL retained from supplied source list; interactive content not fully inspected. |
| Typography | Google / foundation | https://m3.material.io/styles/typography/overview | Typography system | URL retained; exact token values not asserted. |
| Shape principles | Google / foundation | https://m3.material.io/styles/shape/overview-principles | Shape guidance | URL retained; exact scale not asserted. |
| Elevation | Google / foundation | https://m3.material.io/styles/elevation/overview | Elevation concepts | URL retained; exact values not asserted. |
| Motion overview | Google / foundation | https://m3.material.io/styles/motion/overview/how-it-works | Motion concepts | Fetch failed in this environment; unverified on review date. |
| Layout overview | Google / foundation | https://m3.material.io/foundations/layout/layout-overview/overview | Layout guidance | URL retained; details not numerically asserted. |


### Component deep-dive sources reviewed 2026-10-24

The following canonical Material component pages were checked by title and text-accessible description/metadata. Several pages rely on interactive content that was not fully extractable; this is not exhaustive verification of their diagrams, token values, behavior, states, or version history. The deep-dive page therefore cites these for purpose/variant identification and directs readers to inspect the current component page for detailed requirements.

| Component source | URL | What the accessible source confirms | Limitation |
|---|---|---|---|
| Button groups | https://m3.material.io/components/button-groups/overview | Page describes groups as organizing buttons and adding interactions. | Detailed anatomy/variants not fully inspected. |
| Toolbars | https://m3.material.io/components/toolbars/overview | Listed as an M3E component in the Flutter umbrella issue cited by the Phase 0/1 audit. | Full Material component page was not independently reviewed in this audit. |
| Bottom app bar | https://m3.material.io/components/bottom-app-bar/overview | Canonical source URL recorded by the component inventory. | Not individually reviewed in the supplied audit; M3E status remains unestablished. |
| Split buttons | https://m3.material.io/components/split-button/overview | Page describes a menu of options related to an action. | Interaction states and visual specification not fully inspected. |
| FAB menu | https://m3.material.io/components/fab-menu/overview | Page describes multiple related actions opening from a FAB. | Full motion/anatomy guidance not extracted. |
| Badges | https://m3.material.io/components/badges/overview | Page describes notification, count, or status information attached to navigation items/icons; labels or numbers may be used. | Detailed usage guidance not fully extracted. |
| Divider | https://m3.material.io/components/divider/overview | Page describes a thin line grouping content in lists and containers. | Detailed variants and usage guidance not fully extracted. |
| Side sheets | https://m3.material.io/components/side-sheets/overview | Page identifies standard and modal side sheets for secondary side-anchored content. | Detailed behavior/layout guidance not fully extracted. |
| Time pickers | https://m3.material.io/components/time-pickers/overview | Page identifies dial and input types. | Detailed state/locale/token guidance not fully extracted. |

## Flutter

| Title | Publisher / category | URL | Supports | Status and limitations |
|---|---|---|---|---|
| Material Design for Flutter | Flutter / guide | https://docs.flutter.dev/ui/design/material | Flutter Material overview | Verified; page reported Flutter 3.47 content and 2026-09 update. |
| Adaptive and responsive design | Flutter / guide | https://docs.flutter.dev/ui/adaptive-responsive | Responsive/adaptive definitions and input context | Verified; page reported Flutter 3.47 content. |
| ThemeData constructor | Flutter API | https://api.flutter.dev/flutter/material/ThemeData/ThemeData.html | Theme constructor properties including `useMaterial3` | Verified API listing; API evolves with Flutter releases. |
| ColorScheme | Flutter API | https://api.flutter.dev/flutter/material/ColorScheme-class.html | Flutter color roles and Material 3 surfaces | Verified API page. |
| Testing Flutter apps | Flutter / guide | https://docs.flutter.dev/testing | Unit/widget/integration testing | Official source; check current version before use. |
| Accessibility and internationalization | Flutter / guide | https://docs.flutter.dev/ui/accessibility-and-internationalization/accessibility | Flutter accessibility guidance | URL recorded; exact current page content not retrieved. |
| UI design and styling accessibility | Flutter / guide | https://docs.flutter.dev/ui/accessibility/ui-design-and-styling | Large text, contrast, and mobile tap-target recommendations | Verified 2026-10-25; page reflects Flutter 3.47. Platform recommendations are not a substitute for checking any separate conformance requirement. |
| Android accessibility guidance | Android / platform guide | https://developer.android.com/guide/topics/ui/accessibility/apps#touch-targets | Android recommends 48x48 dp touch targets | Verified 2026-10-25; platform recommendation. |
| Android platform integration | Flutter / guide | https://docs.flutter.dev/platform-integration/android | Android mobile setup and integration | Verify current tooling and OS requirements. |
| iOS platform integration | Flutter / guide | https://docs.flutter.dev/platform-integration/ios | iOS mobile setup and integration | Verify current tooling and OS requirements. |
| Material/Cupertino package migration | Flutter / migration guide | https://docs.flutter.dev/release/breaking-changes/material-ui-and-cupertino-ui | Standalone `material_ui` and `cupertino_ui` package availability and migration context; contributions to the in-framework libraries were frozen starting in Flutter 3.44 | Verified 2026-10-25; Flutter 3.47 makes the standalone 1.0 packages available. Verify imports, package constraints, and APIs for the target SDK. |
| M3 Expressive component migration checklist | Flutter / implementation checklist | https://github.com/flutter/flutter/blob/master/docs/ecosystem/material_ui/Material-3-Expressive-component-migration-checklist.md | Component-level M3E opt-in and migration workflow for `material_ui`; retains Material 3 as default | Verified 2026-10-25 through merged [Flutter PR #192519](https://github.com/flutter/flutter/pull/192519). This is implementation guidance for Flutter's package, not universal app-level normative guidance. |

### Mobile adaptive and foldable sources checked 2026-11-03

| Title | Publisher / category | URL | Supports | Status and limitations |
|---|---|---|---|---|
| Large screens | Flutter / mobile adaptive guide | https://docs.flutter.dev/ui/adaptive-responsive/large-screens | Flutter guidance on large-screen layouts, orientation, foldables, and app-space adaptation | Verified 2026-11-03; page reflects Flutter 3.47. It also covers web, desktop, and iPad; this repository uses only applicable mobile guidance. |
| `MediaQueryData.displayFeatures` | Flutter API | https://api.flutter.dev/flutter/widgets/MediaQueryData/displayFeatures.html | Flutter display-feature bounds, types, and folding state | Verified 2026-11-03; API documentation says the list is populated only on Android. |
| `DisplayFeatureSubScreen` | Flutter API | https://api.flutter.dev/flutter/widgets/DisplayFeatureSubScreen-class.html | Positioning a child to avoid a display feature that splits the screen | Verified 2026-11-03; a focused widget behavior, not a complete adaptive layout solution. Check the target SDK. |
| Learn about foldables | Android / foldable design and developer guide | https://developer.android.com/develop/ui/compose/layouts/adaptive/foldables/learn-about-foldables | Foldable states/postures, continuity, display areas, and large-screen scenarios | Verified 2026-11-03; includes Compose implementation details that are not Flutter APIs. |

### Component API sources checked 2026-10-24


| Component APIs checked 2026-10-24 | Flutter API | API fact used in the component deep dive | Version limitation |
|---|---|---|---|
| Segmented button | https://api.flutter.dev/flutter/material/SegmentedButton-class.html | Bounded option selection; single-select default and optional multi-select. | Verify API and behavior against the app SDK. |
| Menu anchor | https://api.flutter.dev/flutter/material/MenuAnchor-class.html | Anchored-menu building block; not itself a split button or FAB menu specification. | Verify focus/placement behavior against the app SDK and targets. |
| Badge | https://api.flutter.dev/flutter/material/Badge-class.html | Optional label; Flutter API describes small and labeled badge forms. | API existence does not establish M3E parity or announcement behavior. |
| Divider | https://api.flutter.dev/flutter/material/Divider-class.html | Separator widget with documented list/drawer use. | Verify selected SDK and semantic output. |
| Scaffold end drawer | https://api.flutter.dev/flutter/material/Scaffold/endDrawer.html | Side panel attached to scaffold edge; drawer API is not a side-sheet equivalence claim. | Verify directionality and behavior in the app SDK. |
| Time picker | https://api.flutter.dev/flutter/material/showTimePicker.html | Dialog API exposes entry mode and returns selected time or cancellation. | Verify locale, theming, and behavior against the app SDK. |

### Flutter M3 Expressive issue-tracker context reported 2026-10-24

These issue-tracker references are implementation-status evidence, not normative Material design specifications. Their titles, status, and discussion can change; the supplied Phase 0/1 audit reports their state at review time, and this integration did not independently re-fetch them.

| Reference | URL | Audit use | Limitation |
|---|---|---|---|
| M3E umbrella issue | https://github.com/flutter/flutter/issues/168813 | Tracks Flutter's M3E component/style work and reports “15 new or updated components.” | The audit noted 14 named entries in the rendered list; reconcile the discrepancy against the live issue and Material catalog before freezing scope. |
| Button groups proposal | https://github.com/flutter/flutter/issues/184936 | Evidence that a dedicated button-group implementation is distinct from assuming an existing `SegmentedButton` is sufficient. | Reported as Backlog in the supplied audit's 2026-10-24 snapshot; not independently re-checked here. |
| Buttons proposal | https://github.com/flutter/flutter/issues/184937 | Evidence that M3E button changes have a separate Flutter proposal. | Reported as Backlog in the supplied audit's 2026-10-24 snapshot; not independently re-checked here. |

## Packages and implementation repositories

| Title | Publisher / category | URL | Supports | Status and limitations |
|---|---|---|---|---|
| dynamic_color | Flutter community package / pub.dev | https://pub.dev/packages/dynamic_color | Package-documented dynamic color integrations | Verified package page; third-party, version/platform support may change. Not an official M3E specification. |
| material_3_expressive | paadevelopments / community implementation | https://github.com/paadevelopments/material_3_expressive | Example Flutter implementation claims and package code | Page retrieved; non-normative and not official. |
| m3_expressive | fabric-apps / community implementation | https://github.com/fabric-apps/m3_expressive | Example custom Flutter components | Page retrieved; non-normative and not official. |

## Mobile platforms, accessibility, and testing

Use current official references for [Android](https://developer.android.com/design/ui), [Apple Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/), and Flutter's [Android](https://docs.flutter.dev/platform-integration/android) and [iOS](https://docs.flutter.dev/platform-integration/ios) setup guides. These are starting points, not proof of app-level behavior; consult the target OS version and device guidance directly. Apply accessibility standards when required by the mobile product, and verify their scope independently of platform tap-target recommendations.

## Preserved starting URLs

The full originally supplied list is preserved in the repository-root `link_sources.md`. A listed URL is not automatically a verified source; this catalog marks access limits explicitly.
