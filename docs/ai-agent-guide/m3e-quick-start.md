# AI coding agent quick-start: implementing M3E in Flutter

This page is the **agent-neutral entry point** for any AI coding assistant assigned to build or modify an Android or iOS Flutter mobile app using Material 3 Expressive. Phone, tablet, and foldable layouts are in scope. Web and desktop apps are out of scope. The instructions do not depend on a particular model, vendor, editor, agent mode, or prompt-file format. Follow the repository's canonical documentation and the target project's actual SDK/package versions; do not assume that a vendor-specific instruction file is available.

---

## Step 0: Understand what you are working with

Material 3 Expressive (M3E) is **not a separate framework**. It is a design direction layered on top of Material 3 that specifies how to use shapes, color, motion, and component hierarchy more expressively. You cannot achieve it by setting `useMaterial3: true` alone.

Classify every requirement before writing a line of code:

| Classification | What it means | How to implement |
|---|---|---|
| **Built-in** | A Flutter widget satisfies the requirement as-is | Use it directly; configure via theme |
| **Configurable** | A Flutter widget satisfies the requirement through its documented properties or theme | Set via `ThemeData` / component theme |
| **Custom (documented gap)** | No built-in satisfies the M3E requirement; repo has a reference widget | Use the repo widget from `lib/m3e/widgets/`; read its docstring |
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
import 'lib/m3e/m3e.dart'; // project token extension

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

See the [full component decision matrix](../components/component-decision-matrix.md) for detailed guidance. Quick reference:

| Design intent | Flutter widget | M3E repo widget | Notes |
|---|---|---|---|
| Primary action | `FilledButton` | — | Use `colorScheme.primary` fill |
| Secondary action | `FilledButton.tonal` | — | Lower emphasis than primary |
| Tertiary / ghost | `TextButton`, `OutlinedButton` | — | Lowest emphasis |
| Group of related actions | `SegmentedButton` (exclusive) | `M3EConnectedButtonGroup` | Not interchangeable |
| Primary + overflow menu | Compose `FilledButton` + `MenuAnchor` | `M3ESplitButton` | No stock split-button widget |
| App bar | `AppBar`, `SliverAppBar` | `M3EAppBar` | M3EAppBar adds responsive bounds |
| Bottom navigation (compact) | `NavigationBar` | `M3EAdaptiveScaffold` | Auto-switches to rail/drawer |
| Side navigation (medium+) | `NavigationRail` | `M3EAdaptiveScaffold` | |
| Full navigation (expanded) | `NavigationDrawer` | `M3EAdaptiveScaffold` | |
| Grouped list items | `ListView` + `ListTile` | `M3ESegmentedList` | Use segmented for expressive grouping |
| Floating primary action | `FloatingActionButton` | — | FAB menu requires custom composition |
| Confirmation badge | `Badge` | — | Flutter API verified |
| Content separator | `Divider` | — | Use spacing first; divider only for meaningful boundaries |

---

## Step 5: Apply expressive shapes

Use iconic shapes deliberately. They communicate personality and emphasis — not decoration.

```dart
// Clip a widget to an expressive shape
ClipPath(
  clipper: M3EShapeClipper(context.m3e.shapes.clover4Leaf),
  child: Container(
    width: m3e.spacing.space64,
    height: m3e.spacing.space64,
    color: theme.colorScheme.primaryContainer,
    child: Icon(Icons.star_rounded, color: theme.colorScheme.onPrimaryContainer),
  ),
)

// Use a shape as a Material border
Material(
  shape: context.m3e.shapes.squircle.toBorder(),
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

Use spring physics for interactive motion. Use duration constants for simple state transitions.

```dart
// Spatial spring: positional movement, size changes, morphing shapes
// → Use when something moves across the screen or grows/shrinks in response to user input
AnimationController controller = AnimationController(vsync: this);
final sim = context.m3e.motion.createSpatialSpring(start: 0.0, end: 1.0);
controller.animateWith(sim);

// Effect spring: color, opacity, elevation changes
// → Use when a surface fades in, changes color, or changes elevation
final effectSim = context.m3e.motion.createEffectSpring(start: 0.0, end: 1.0);

// Simple state transitions without spring physics
AnimatedContainer(
  duration: context.m3e.motion.durationFast,   // 150ms
  curve: context.m3e.motion.curveEffectFade,   // easeOutCubic
  color: isSelected
    ? theme.colorScheme.secondaryContainer
    : theme.colorScheme.surfaceContainerLow,
)
```

**Always provide a reduced-motion fallback:**

```dart
final reduceMotion = MediaQuery.of(context).disableAnimations;
final duration = reduceMotion
  ? Duration.zero
  : context.m3e.motion.durationMedium;
```

---

## Step 7: Build responsive layout

Use `LayoutBuilder` to detect viewport width. Never use `Platform` checks as a proxy for screen size.

```dart
// Repo breakpoints (Implementation recommendation — not official M3 token)
// compact:  width < 720dp   → NavigationBar  + single-column
// medium:   720–1024dp      → NavigationRail + two-column
// expanded: width > 1024dp  → NavigationDrawer + multi-pane

LayoutBuilder(
  builder: (context, constraints) {
    if (constraints.maxWidth < 720) {
      return _CompactLayout(child: body);
    } else if (constraints.maxWidth < 1024) {
      return _MediumLayout(child: body);
    } else {
      return _ExpandedLayout(child: body);
    }
  },
)
```

Or use the repo's `M3EAdaptiveScaffold` which handles this automatically.

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
