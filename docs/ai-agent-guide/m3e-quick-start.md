# AI coding agent quick-start: implementing M3E in Flutter

This page is the **agent-neutral entry point** for any AI coding assistant assigned to build or modify an Android or iOS Flutter mobile app using Material 3 Expressive. Phone, tablet, and foldable layouts are in scope. Web and desktop apps are out of scope. The instructions do not depend on a particular model, vendor, editor, agent mode, or prompt-file format. Follow the repository's canonical documentation and the target project's actual SDK/package versions; do not assume that a vendor-specific instruction file is available.

## A staged workflow for a focused task

For substantial UI work, break the request into these phases. They are a workflow, not a requirement to stop for approval unless a product decision is ambiguous or consequential.

1. **Theme and scaffold:** establish the target platforms and versions; read the scope, token evidence, theme, and responsive guidance; inspect the target app before changing its scaffold.
2. **Core components:** map each user task to the [component decision matrix](../components/component-decision-matrix.md), then inspect the [component snippet catalog](component-snippets.md) and source implementation. Reuse an existing component only when its behavior and API fit the requirement.
3. **Review and refine:** check tokens, source claims, text scaling, accessibility, localization/RTL, responsive behavior, reduced motion, and platform-specific states with the [validation checklist](validation-checklist.md). Record what could not be tested.

Suggested prompts can be adapted to a coding agent without assuming it automatically reads any particular filename:

1. “Inspect the repository instructions, app versions, scope, theme and token evidence. Propose a target-specific scaffold and identify unknowns before changing UI.”
2. “Implement the requested screen using verified built-in or repository components where appropriate. Check their source and the pinned APIs; label application-specific choices and documented gaps.”
3. “Review the diff against the repository validation checklist, run the relevant checks, fix issues caused by this change, and report exact outcomes and remaining gaps.”

---

## Step 0: Understand what you are working with

Material 3 Expressive (M3E) is **not a separate framework**. It is a design direction layered on top of Material 3 that specifies how to use shapes, color, motion, and component hierarchy more expressively. You cannot achieve it by setting `useMaterial3: true` alone.

Classify every requirement before writing a line of code:

| Classification | What it means | How to implement |
|---|---|---|
| **Built-in** | A Flutter widget satisfies the requirement as-is | Use it directly; configure via theme |
| **Configurable** | A Flutter widget satisfies the requirement through its documented properties or theme | Set via `ThemeData` / component theme |
| **Custom (repo reference)** | A verified need is not met by the built-in; a repo implementation may be relevant | Inspect the repo widget and its tests; reuse only if its behavior fits. It is not conformance evidence. |
| **Custom (new gap)** | No built-in or repo widget satisfies it | Build a focused custom widget; label it "Custom Implementation Choice" |
| **Unverified** | Source or API evidence is insufficient | Do not assert support; flag it explicitly |

---

## Step 1: Read before building

Read these documents in order before writing any widget code:

1. `AGENTS.md` — repository rules and edge-case resolutions
2. `docs/getting-started/scope.md` — what M3E is and what it is not
3. `docs/reference/support-matrix.md` — which platforms are targeted
4. The relevant foundation page(s) for your task (color, shape, motion, typography, spacing)
5. The relevant component page(s) for your task (see component decision matrix below)

---

## Step 2: Bootstrap the theme

Apps that use this repository's custom widgets or tokens need the corresponding `M3EThemeExtension` configured. It is a project-defined extension, not a Flutter or Material requirement for every M3E-informed Flutter app. The extension is the source of truth for tokens defined by this repository; check the token registry's evidence label before treating a value as official Material guidance.

```dart
// Reference-app dependency: examples/flutter/reference_app/pubspec.yaml
// Check the target application's own dependency constraints and lockfile.
import 'package:material_ui/material_ui.dart';
import 'package:m3_expressive_reference_app/m3e/m3e.dart';

MaterialApp(
  theme: ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF6750A4),
      brightness: Brightness.light,
    ),
    extensions: [M3EThemeExtension.standardLight()],
  ),
  darkTheme: ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF6750A4),
      brightness: Brightness.dark,
    ),
    extensions: [M3EThemeExtension.standardDark()],
  ),
  themeMode: ThemeMode.system,
  home: const MyHomePage(),
)
```

Access all tokens anywhere in the widget tree via `context.m3e`:

```dart
final m3e = context.m3e;        // M3EThemeExtension
final theme = Theme.of(context); // Flutter ThemeData

// Spacing
m3e.spacing.space16              // 16.0
m3e.spacing.all16                // EdgeInsets.all(16.0)
m3e.spacing.symmetricH16V8       // EdgeInsets.symmetric(h:16, v:8)

// Shapes (corner radii)
m3e.shapes.radiusMedium          // 12.0
m3e.shapes.borderLarge           // BorderRadius.circular(16.0)

// Shapes (iconic M3E shapes — use as ClipPath or ShapeDecoration)
m3e.shapes.clover4Leaf           // M3EShapeDefinition
m3e.shapes.squircle
m3e.shapes.burst

// Motion
m3e.motion.durationFast          // Duration(milliseconds: 150)
m3e.motion.curveSpatialOvershoot // Curves.easeOutBack
m3e.motion.createSpatialSpring() // SpringSimulation (positional transitions)
m3e.motion.createEffectSpring()  // SpringSimulation (color/opacity transitions)

// Colors — always from ColorScheme, never hardcoded
theme.colorScheme.primary
theme.colorScheme.onPrimary
theme.colorScheme.surfaceContainerLow
theme.colorScheme.surfaceContainerHigh
```

---

## Step 3: Apply the core rules

These rules are always active. Violating any one of them produces a non-compliant implementation.

### Rule 1: No magic numbers

Never write raw numeric literals for layout values. Always use tokens.

```dart
// WRONG
Padding(padding: const EdgeInsets.all(16.0), child: child)
BorderRadius.circular(12.0)
SizedBox(height: 48)

// CORRECT
Padding(padding: m3e.spacing.all16, child: child)
BorderRadius.circular(m3e.shapes.radiusMedium)
SizedBox(height: m3e.spacing.space48)
```

Use named project tokens for design dimensions. For framework-defined behavioral constraints, prefer the relevant Flutter constants over duplicating their numeric values. A project token is a local implementation choice, not automatically an official Material token.

### Rule 2: Use semantic colors

Never hardcode hex or Color() values in widget code. Map to ColorScheme roles.

```dart
// WRONG
Container(color: const Color(0xFF6750A4))

// CORRECT
Container(color: theme.colorScheme.primary)
```

### Rule 3: Preserve usable touch targets

Follow the target platform's tap-target guidance (Flutter cites 48×48 dp for Android and 44×44 pt for iOS); see [touch-target guidance](../foundations/accessibility.md). The token-based 48×48 example below is a project choice and should not be treated as universal across platforms. Check any separate accessibility-conformance requirements that apply to the mobile app.
```dart
// WRONG
GestureDetector(child: SizedBox(width: 28, height: 28, child: Icon(Icons.close)))

// CORRECT
IconButton(
  onPressed: onTap,
  style: IconButton.styleFrom(
    minimumSize: Size.square(m3e.spacing.space48),
  ),
  icon: const Icon(Icons.close_rounded),
)
```

### Rule 4: No fixed heights on text containers

Preserve text at large platform scale settings. A 200% scale can be an additional project-defined test scenario, not a universal platform maximum. Use content-driven height or `ConstrainedBox` with `minHeight`, not fixed heights that clip text.

```dart
// WRONG
SizedBox(height: 56, child: Text(label))

// CORRECT
ConstrainedBox(
  constraints: BoxConstraints(minHeight: m3e.spacing.space48),
  child: Text(label, softWrap: true),
)
```

### Rule 5: Unbounded text must always be wrapped in Expanded or Flexible

```dart
// WRONG — RenderFlex overflow
Row(children: [Icon(Icons.info), Text(veryLongLabel)])

// CORRECT
Row(children: [
  const Icon(Icons.info),
  SizedBox(width: m3e.spacing.space8),
  Expanded(child: Text(veryLongLabel, maxLines: 2, overflow: TextOverflow.ellipsis)),
])
```

---

## Step 4: Choose the right component

See the [full component decision matrix](../components/component-decision-matrix.md) for detailed guidance and the [component snippet catalog](component-snippets.md) for source-linked usage examples. The table is a starting point, not a mandate to use a custom component:

| Design intent | Flutter widget | M3E repo widget | Notes |
|---|---|---|---|
| Primary action | `FilledButton` | — | Use `colorScheme.primary` fill |
| Secondary action | `FilledButton.tonal` | — | Lower emphasis than primary |
| Tertiary / ghost | `TextButton`, `OutlinedButton` | — | Lowest emphasis |
| Group of exclusive choices | `SegmentedButton` | `M3EConnectedButtonGroup` | The repo widget is a separate implementation; inspect its selection and semantics API. |
| Independent actions | Row/Wrap of buttons | — | Do not model independent actions as selected choices. |
| Primary + overflow menu | Compose `FilledButton` + `MenuAnchor` | `M3ESplitButton` | No stock split-button widget |
| App bar | `AppBar`, `SliverAppBar` | `M3EAppBar` | M3EAppBar adds responsive bounds |
| Bottom/side/drawer navigation | `NavigationBar`, `NavigationRail`, `NavigationDrawer` | `M3EAdaptiveScaffold` | Use only for real top-level destinations; validate the repo scaffold's project-specific thresholds. |
| Grouped list items | `ListView` + `ListTile` | `M3ESegmentedList` | Use segmented for expressive grouping |
| Floating primary action | `FloatingActionButton` | — | FAB menu requires custom composition |
| Confirmation badge | `Badge` | — | Flutter API verified |
| Content separator | `Divider` | — | Use spacing first; divider only for meaningful boundaries |

The Flutter widgets in this table are implementation options, not automatically M3 Expressive components. Verify the applicable Material guidance, target Flutter API, and component evidence. Do not label baseline widgets “deprecated for M3E” unless an authoritative source explicitly deprecates them.

---

## Step 5: Apply expressive shapes

Use iconic shapes deliberately. They communicate personality and emphasis — not decoration.

```dart
// Use a repository shape definition as a Flutter ShapeBorder.
// The shape's source/evidence and suitability must still be verified.
Material(
  shape: m3e.shapes.squircle.toBorder(),
  color: theme.colorScheme.surfaceContainerLow,
  child: Padding(
    padding: m3e.spacing.all16,
    child: child,
  ),
)
```

Shape selection guidance:

| Shape group | Examples | When to use |
|---|---|---|
| **Pill / rounded** | `pill`, `radiusFull` | Chips, buttons, single-item callouts |
| **Container shapes** | `squircle`, `roundedRectangle` | Cards, modals, bottom sheets |
| **Organic accents** | `clover4Leaf`, `flower`, `sunny` | Achievement badges, hero illustrations, avatars |
| **Dynamic / burst** | `burst`, `boom`, `softBurst` | Discount tags, urgency indicators, promotional callouts |
| **Functional / strong** | `shield`, `pill`, `hexagon` | Security status, stat tiles, category filters |

Use organic/burst shapes sparingly — reserve for one focal point per screen, not as a background pattern.

---

## Step 6: Apply motion

Choose motion only when supported by the applicable design source and product behavior. `M3EMotion` values are repository-defined implementation choices, not universal Material requirements. Respect the platform reduced-motion setting.

```dart
final motion = context.m3e.motion;
final duration = MediaQuery.of(context).disableAnimations
    ? Duration.zero
    : motion.durationFast;

AnimatedContainer(
  duration: duration,
  curve: motion.curveEffectFade,
  color: isSelected
      ? theme.colorScheme.secondaryContainer
      : theme.colorScheme.surfaceContainerLow,
)
```

---

## Step 7: Build responsive layout

Use `LayoutBuilder` to respond to available constraints. Never use `Platform` checks as a proxy for screen size. Do not copy unverified numeric breakpoints into app code; choose and document app-specific thresholds, or inspect the repository scaffold's source and test its behavior on the target layouts.

```dart
// See the source-linked M3EAdaptiveScaffold example and inspect its
// project-specific layout thresholds before adapting it.
M3EAdaptiveScaffold(
  selectedIndex: selectedIndex,
  onDestinationSelected: onDestinationSelected,
  destinations: const [
    M3EDestination(label: 'Home', icon: Icon(Icons.home_outlined)),
    M3EDestination(label: 'Library', icon: Icon(Icons.video_library_outlined)),
  ],
  appBar: const M3EAppBar(title: Text('Media')),
  body: body,
)
```

---

## Step 8: Verify before submitting

Run every check below and record the actual output. Do not report "passed" without running.

```bash
# From repository root
python scripts/validate_docs.py
python scripts/validate_links.py

# From the reference app directory
cd examples/flutter/reference_app
flutter analyze
flutter test
```

Then manually verify:

- [ ] Light theme renders correctly
- [ ] Dark theme renders correctly
- [ ] Text scale 1.5× — no clipping, no overflow
- [ ] Largest relevant platform text settings — no clipping, overflow, or unreachable controls
- [ ] Optional project-defined 200% text-scale scenario — no clipping or overflow
- [ ] Narrow viewport (360dp) — no overflow, all controls reachable
- [ ] Wide viewport (1200dp) — navigation and layout adapt correctly
- [ ] RTL locale — layout mirrors correctly
- [ ] Touch targets follow the applicable target-platform guidance
- [ ] Screen reader announces interactive elements meaningfully
- [ ] Reduced motion — no animations, state changes are still visible

---

## Step 9: Report your work

Every implementation submission must include:

```
## Summary

**Files changed:** list every .dart and .md file
**Flutter version:** (output of `flutter --version`)
**material_ui version:** (from pubspec.lock)
**Platforms tested:** list what was tested and on what device/emulator
**Commands run:** paste actual output of flutter analyze, flutter test, validate_docs.py
**Tokens used:** confirm no magic numbers; list any labeled custom choices
**Known gaps:** anything unverified, untested, or requiring further source review
**Accessibility:** what was checked and with what tool
```
