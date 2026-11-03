# Flutter-M3E-Design: Improvements Needed for Production Readiness

**Target repository:** https://github.com/Abdiaziiz09/Flutter-M3E-Design
**Review date:** 2026-10-24
**Targets:** Flutter mobile apps on Android and iOS, including phones, tablets, and foldables
**Purpose of this file:** a prioritized, source-backed list of what must change before this repository can be called a complete, production-ready Material 3 Expressive (M3E) reference. It is a plan, not a record of completed work.

---

## 0. What this review is based on, and what it is not

**Reviewed (read directly):** the repository landing page and README, `link_sources.md`, `AGENTS.md`, `docs/reference/m3e-phase0-1-audit.md`, `docs/reference/component-verification-ledger.md`, `docs/flutter/testing.md`, `docs/platforms/index.md`.

**Not done in this review:**

- No code was changed, and nothing was pushed to the repository.
- `flutter test`, `flutter analyze`, `python scripts/validate_docs.py`, `python scripts/validate_links.py` and `mkdocs build --strict` were **not run**. No Flutter toolchain or repository checkout was available.
- The contents of `examples/flutter/reference_app/` could not be opened (the page blocks automated access). Statements about the app below come from the repository's own ledger and README, not from reading the Dart files.
- This historical review did not individually inspect every mobile platform guide; only the platform index was read.

Anything in this plan that depends on those files is marked **(verify)**.

---

## 1. Where the repository stands today

| Area | Current state | Source |
|---|---|---|
| Positioning | Independent, source-traceable guide. Explicitly *not* an official spec and makes no conformance claim. | README |
| Readiness score | **57/100** documentation-readiness (not conformance). A separately mentioned 68% is not reproducible and is not used. | Phase 0/1 audit |
| Weakest dimensions | Foundations/tokens 7/20; Flutter implementation 6/10; components 10/25; accessibility/motion 7/10; platforms 10/15 | Phase 0/1 audit |
| Component inventory | 38 entries (9 M3E updated, 5 M3E new, 24 baseline or unconfirmed) | Phase 0/1 audit |
| Evidence quality | Mostly **E1 (metadata only)**: HTTP 200, page title, description. No exact dimensions, tokens, motion or full state specs were inspected. | Component ledger |
| Flutter snapshot | Reports Flutter 3.47.7 stable / Dart 3.13.5 with the **in-framework** Material library | Component ledger |
| Sample app | A Material 3 baseline (`useMaterial3: true` plus `ColorScheme.fromSeed`), not an M3E component library | README, audit |
| Tests | Widget-test goldens (overview and search, light/dark, narrow/wide) plus a few interaction tests. Goldens use the Ahem test font, so text renders as blocks. | Ledger, testing guide |
| Token registry | None. The audit's gate says exact token values must not be assigned until sources reach E3. | Audit |

**Strengths to preserve:** the evidence-grade vocabulary (E0–E4), the refusal to equate `useMaterial3: true` with M3E, the "report what was not tested" completion note in `AGENTS.md`, and the dated, honest ledger.

---

## 2. Corrections to the working brief

Several assumptions in the task brief do not hold against what I could verify. Fixing the plan around them avoids building on bad premises.

1. **`AdaptiveScaffold` should not be the foundation.** `flutter_adaptive_scaffold` is marked **discontinued** on pub.dev. Community forks exist (for example `canonical_adaptive_scaffold`, `adaptive_scaffold_router`), but none is first-party. Recommended: build the responsive recipes from `LayoutBuilder` plus `NavigationBar` / `NavigationRail` / `NavigationDrawer` with a repo-owned window-size-class helper. Treat any fork as optional and label it third-party.
2. **`golden_toolkit` should not be adopted.** It is discontinued on pub.dev. `alchemist` (0.14.0 at time of search, MIT) is the maintained successor in the same style. Pin its version after checking compatibility with the pinned Flutter SDK **(verify)**.
3. **"Official `M3ESegmentedList` blueprint" does not exist in any source I found.** "Segmented Lists" and "card list" appear as component names in the community package `m3e_core`. Treat `M3ESegmentedList` as a *repository-defined* widget and label it "Custom Implementation Choice". I could not confirm that an `M3ECardList` exists in this repo **(verify)**.
4. **"35 iconic shapes"** comes from Material's blog article, which the README quotes. I found no verified Flutter API that exposes all 35. A community package (`material_new_shapes`) provides morphing polygon shapes. Mapping all 35 into a `ThemeExtension` requires the official shape list as a source first.
5. **"Typography Flex scales"**: I found no source for this term. The README states exact expressive type-token values are not assumed. Do not implement it until a source is cited.
6. **"15 baseline M3E features"**: the audit notes that Flutter's umbrella issue says fifteen components but lists fourteen. Reconcile against the live Material catalog before freezing scope.
7. **Spring motion values**: Material's motion physics are described by the repo only at topic level. No spring stiffness or damping values were retrieved. Mark them "Unspecified - Custom Implementation Choice" until sourced.
8. **`context.m3e.spacing`** is a *project-defined* extension, which is fine, but its values are not official Material tokens. Label them as repository choices.

---

## 3. The `material_ui` migration: what is verified

- Flutter's migration guide confirms the Material library is now a standalone package, `package:material_ui`, and that contributions to `package:flutter/material.dart` were **frozen starting in Flutter 3.44**.
- Import change: `package:flutter/material.dart` → `package:material_ui/material_ui.dart`; add with `flutter pub add material_ui`.
- Types are **not interchangeable** across the two imports. A file must not import both.
- Localization delegates moved into the new packages.
- `MaterialUiCompatibilityBridge` exists for third-party subtrees that still import the old library.
- Flutter's umbrella issue #168813 states that new M3E work happens in the new packages. The button-group and button M3E proposals (#184936, #184937) were Backlog at audit time, so **API existence must be verified per component against the pinned version**, not assumed.
- One community M3E package already requires `material_ui ^1.1.0` and Flutter ≥ 3.44.0.

**Migration risks to plan for**

- The repo's evidence ledger was gathered against the in-framework library. Every "API verified" row needs re-verification against the pinned `material_ui` version.
- Existing goldens will need regeneration and a documented reason for each diff.
- Third-party packages used by the sample may still import the old library (use the compatibility bridge or replace them).

---

## 4. Prioritized backlog

Priorities: **P0** blocks any production-ready claim, **P1** required for M3E alignment, **P2** required for platform completeness, **P3** polish.

### P0: Foundations and trust

- [ ] **Pin the toolchain.** Record Flutter, Dart, `material_ui` and `cupertino_ui` versions in `pubspec.yaml`, CI and docs. State the supported range.
- [ ] **Migrate the reference app to `material_ui`.** Single import per file; run `flutter analyze` clean; regenerate goldens; document each diff.
- [ ] **Re-verify the ledger against the pinned package.** Replace "reported by repository snapshot" with a re-run, dated check.
- [ ] **Raise evidence from E1 to E3** for every component, starting with the five M3E-new ones: button groups, split button, FAB menu, loading indicator, toolbars. Record anatomy, variants, states, dimensions and motion from the official page, or mark each missing value **"Unspecified - Custom Implementation Choice"**.
- [ ] **Build the token registry** (color roles, type scale, shape, elevation, spacing, motion). No value without a citation. This is the audit's stated gate before component contracts.
- [ ] **Resolve scope discrepancies:** the 14-vs-15 component count; the 38-row inventory's overlap rules; the missing dedicated bottom app bar row.
- [ ] **Wire CI.** Run `validate_docs.py`, `validate_links.py`, `mkdocs build --strict`, `flutter analyze` and `flutter test` on every pull request. Publish actual results.

### P1: M3E components and theming

- [ ] **`ThemeExtension` for M3E tokens** (shape, type, spacing, motion) with `copyWith`, `lerp`, light/dark variants and a documented source for each field.
- [ ] **Shape mapping:** source the official 35-shape list first, then implement. Document which shapes have no Flutter API.
- [ ] **Dedicated contracts and widgets** for: connected/standard button groups (not `SegmentedButton`), split button, FAB menu, loading indicator, toolbars, expressive app bars, extended FAB.
- [ ] **Segmented/card list pattern** as a clearly labeled custom component (see §2 item 3), including reorder and morph behavior only where a source or a documented project decision supports it.
- [ ] **Motion:** a documented spring-based motion layer with a reduced-motion fallback. Values must be sourced or labeled custom.
- [ ] **Deprecation audit:** list every component that uses a deprecated or migration-sensitive API and justify it (this is already an `AGENTS.md` rule).

### P1: Testing

- [ ] **Replace Ahem-font goldens** with real-font goldens using `alchemist` (or Flutter's built-in `matchesGoldenFile` with loaded fonts). Keep CI goldens deterministic across OSes.
- [ ] **State matrix tests** for each component: default, focus, pressed, selected, disabled, loading, error, expanded; include only states relevant to mobile input.
- [ ] **Text scale and locale matrix:** test the largest relevant platform text settings, plus optional project-defined 1.0 / 1.5 / 2.0 scale scenarios, long strings, RTL, and one non-Latin locale. The 2.0 scenario is not a universal platform maximum.
- [ ] **Accessibility tests:** semantics, minimum tap target (`kMinInteractiveDimension`), contrast checks via Flutter's `meetsGuideline` matchers, keyboard traversal.
- [ ] **`integration_test`** on at least one Android and one iOS mobile target, including phone/tablet form factors as available.

### P2: Mobile platforms (Android and iOS)

- [ ] **Confirm Android and iOS runner folders** exist in the reference app and build in CI **(verify)**.
- [ ] **Android:** edge-to-edge and system-bar handling, predictive back, dynamic color, large-screen and foldable behavior. Validate on real devices or emulators and record results.
- [ ] **iOS:** safe areas, back-swipe, text-scale and Dynamic Type behavior, haptics, and a documented decision on when to use `cupertino_ui` adaptive widgets versus Material.
- [ ] **Mobile platform pages** (`docs/platforms/android.md`, `docs/platforms/ios.md`): add a "tested / not tested" table with date, device, OS and Flutter version.
- [ ] **Responsive mobile recipes** for phone, tablet, foldable, orientation and multitasking constraints using `LayoutBuilder`. Cite relevant Material adaptive-layout guidance from `link_sources.md`.

### P2: AI-agent workflow (`AGENTS.md`)

- [ ] **Add a "no magic numbers" rule** (proposed text in §5).
- [ ] **Add an error-handling section** with failing and corrected examples (proposed in §5).
- [ ] **Remove the duplicated "Required completion note"** heading that currently appears twice.
- [ ] **Add a lint rule or script** that fails CI on literal `EdgeInsets`, `SizedBox` and radius numbers in `lib/` outside the token files.
- [ ] **Make `llms-full.txt` genuinely full** or document clearly that it is an index only (the audit flags that agents given only that file miss normative content).

### P3: Polish

- [ ] Fix the topic typo `accessiblity` in repository topics.
- [ ] Add a `docs/` page showing real Flutter screenshots next to the official Material images, clearly captioned.
- [ ] Add release tags, a versioned changelog, and a "tested against" badge.
- [ ] Track license terms for any image reuse (the README currently hotlinks Google-hosted images, which is the right default).

---

## 5. Proposed additions to `AGENTS.md`

### 5.1 Mandatory rule: no magic numbers

> **Layout values must come from tokens.** Do not write numeric literals for padding, margins, gaps, radii, icon sizes or breakpoints in widget code. Use `context.m3e.spacing`, `context.m3e.shape` or another declared token. If no token exists, add one to the token file with a source citation, or label it **"Unspecified - Custom Implementation Choice"**. Framework constants such as `kMinInteractiveDimension` are allowed.

```dart
// Not allowed
Padding(
  padding: const EdgeInsets.all(16),
  child: child,
)

// Allowed (token names are repository-defined; values are labeled custom unless sourced)
Padding(
  padding: EdgeInsets.all(context.m3e.spacing.medium),
  child: child,
)
```

### 5.2 Error-handling scenarios

**Scenario A: Row overflows ("RIGHT OVERFLOWED BY n PIXELS")**

```dart
// Failing: unbounded text inside a Row
Row(children: [Icon(Icons.info), Text(longLabel)])

// Resolution: give the text bounded space and a defined overflow behavior
Row(
  children: [
    const Icon(Icons.info),
    SizedBox(width: context.m3e.spacing.small),
    Expanded(
      child: Text(longLabel, maxLines: 2, overflow: TextOverflow.ellipsis),
    ),
  ],
)
```

**Scenario B: Truncation at large text scale**

```dart
// Failing: fixed height clips scaled text
SizedBox(height: 56, child: Text(label))

// Resolution: a minimum height that grows with content
ConstrainedBox(
  constraints: const BoxConstraints(minHeight: kMinInteractiveDimension),
  child: Text(label),
)
```

Required check: verify the widget at the largest relevant platform text settings. The project may additionally run a 2.0 scale scenario (for example, through `MediaQuery` or the test platform dispatcher) and confirm no overflow, clipping, or unreachable controls; 2.0 is a project test value, not a universal platform maximum.

**Scenario C: Controls crowd or wrap at narrow widths**

Prefer `Wrap` or an overflow pattern over shrinking tap targets below `kMinInteractiveDimension`. Document the chosen behavior in the component contract.

---

## 6. Definition of done (per component)

A component is "M3E-aligned" only when **all** of these are recorded:

1. Official source reviewed at **E3**, with date and scope.
2. Flutter API path stated (`material_ui` version) or "custom, because …".
3. Every applicable state tested, with unsupported states listed.
4. Text-scale, RTL and long-content tests pass.
5. Accessibility checks pass (semantics, target size, contrast, keyboard).
6. Tested on named Android and iOS mobile devices/simulators, or the gaps are reported.
7. Tokens used; no magic numbers.

Required commands (all must be run and their real output reported):

```bash
python -m pip install -r requirements.txt
python scripts/validate_docs.py
python scripts/validate_links.py
mkdocs build --strict

cd examples/flutter/reference_app
flutter pub get
flutter analyze
flutter test
flutter test integration_test   # only where devices are configured
```

---

## 7. Issue ledger (seed for `ROADMAP.md`)

| ID | Title | Priority | Done when |
|---|---|---|---|
| M3E-R01 | Pin Flutter / Dart / `material_ui` versions | P0 | Versions recorded in pubspec, CI, docs |
| M3E-R02 | Migrate reference app to `material_ui` | P0 | One Material import per file; analyze clean |
| M3E-R03 | Re-verify ledger against pinned package | P0 | Every API row dated and re-run |
| M3E-R04 | E1 → E3 review for the five M3E-new components | P0 | Contracts cite official pages; gaps labeled |
| M3E-R05 | Token registry | P0 | Every token cited or labeled custom |
| M3E-R06 | Reconcile 14-vs-15 component count | P0 | Inventory scope approved |
| M3E-R07 | CI for docs and Flutter checks | P0 | PRs blocked on failure |
| M3E-R08 | M3E `ThemeExtension` | P1 | Full field docs, `lerp` tested |
| M3E-R09 | Source and map the official shape list | P1 | List cited; unmapped shapes documented |
| M3E-R10 | Button group, split button, FAB menu widgets | P1 | Contracts, widgets, state tests |
| M3E-R11 | Loading indicator and toolbar widgets | P1 | Contracts, widgets, state tests |
| M3E-R12 | Expressive app bar and extended FAB | P1 | Contracts, widgets, large-text tests |
| M3E-R13 | Segmented/card list (custom) | P1 | Labeled custom; reorder behavior documented |
| M3E-R14 | Motion layer with reduced-motion support | P1 | Values sourced or labeled custom |
| M3E-R15 | Real-font golden suite with `alchemist` | P1 | Deterministic CI goldens |
| M3E-R16 | Accessibility and text-scale test matrix | P1 | Matrix green in CI |
| M3E-R17 | Responsive recipes without `AdaptiveScaffold` | P2 | Three breakpoints demonstrated |
| M3E-R18 | Android validation | P2 | Dated results table |
| M3E-R19 | iOS validation | P2 | Dated results table |
| M3E-R21 | `AGENTS.md` token and error-handling rules | P2 | Merged, lint script in CI |
| M3E-R22 | Make `llms-full.txt` complete or document its scope | P2 | Decision recorded |

---

## 8. Sources

- Repository: https://github.com/Abdiaziiz09/Flutter-M3E-Design (README, `AGENTS.md`, `link_sources.md`, Phase 0/1 audit, component ledger, testing and platform guides)
- Flutter: [Migrate to standalone material_ui and cupertino_ui](https://docs.flutter.dev/release/breaking-changes/material-ui-and-cupertino-ui)
- Flutter: [M3E umbrella issue #168813](https://github.com/flutter/flutter/issues/168813)
- pub.dev: [material_ui](https://pub.dev/packages/material_ui), [flutter_adaptive_scaffold (discontinued)](https://pub.dev/packages/flutter_adaptive_scaffold), [golden_toolkit (discontinued)](https://pub.dev/packages/golden_toolkit), [alchemist](https://pub.dev/packages/alchemist)
- Community M3E packages (implementation examples only, not specifications): [m3e_core](https://pub.dev/packages/m3e_core), [m3e_collection](https://pub.dev/packages/m3e_collection)
