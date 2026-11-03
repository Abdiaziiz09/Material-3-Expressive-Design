# Design token registry

This page is the authoritative listing of every design token available to Flutter widgets in this repository. Tokens are accessed via `context.m3e` (the `M3EThemeExtension`).

**Evidence note:** values marked **Custom** are deliberate implementation choices made by this repository. They are not official Material token values, because no specific numeric value has been published by Google for those tokens at the time of this documentation. Values marked **Material guidance** are grounded in a cited Material source. Every value labeled Custom must be reconsidered and updated when an official source becomes available.

---

## How to access tokens

```dart
// In any widget build() method or helper that receives BuildContext:
final m3e = context.m3e;
final theme = Theme.of(context);
```

---

## 1. Spacing tokens (`context.m3e.spacing`)

Source: Material 3 uses an 8dp base grid with a 4dp micro-grid for fine adjustments.
Official reference: [Material spacing](https://m3.material.io/styles/spacing/overview)
Evidence: **Material guidance** (base grid principle) + **Custom** (exact scale mapping)

| Token | Value | Dart accessor | Typical use |
|---|---|---|---|
| `space2` | 2dp | `m3e.spacing.space2` | Fine alignment corrections; badge offsets |
| `space4` | 4dp | `m3e.spacing.space4` | Icon-to-label gap; chip inner spacing |
| `space8` | 8dp | `m3e.spacing.space8` | Tight padding between inline elements |
| `space12` | 12dp | `m3e.spacing.space12` | Compact list tile padding; dense card header |
| `space16` | 16dp | `m3e.spacing.space16` | Standard screen margin (compact); card padding |
| `space20` | 20dp | `m3e.spacing.space20` | Generous card padding; content grouping |
| `space24` | 24dp | `m3e.spacing.space24` | Section spacing; tablet content margins |
| `space32` | 32dp | `m3e.spacing.space32` | Major block separation; hero section gap |
| `space40` | 40dp | `m3e.spacing.space40` | Extra-large section spacing |
| `space48` | 48dp | `m3e.spacing.space48` | Project token for touch-target examples and mobile layout spacing |
| `space64` | 64dp | `m3e.spacing.space64` | Hero container padding; splash spacing |

### Pre-built EdgeInsets shortcuts

```dart
m3e.spacing.all4             // EdgeInsets.all(4)
m3e.spacing.all8             // EdgeInsets.all(8)
m3e.spacing.all12            // EdgeInsets.all(12)
m3e.spacing.all16            // EdgeInsets.all(16)  ← most common card padding
m3e.spacing.all20            // EdgeInsets.all(20)
m3e.spacing.all24            // EdgeInsets.all(24)
m3e.spacing.all32            // EdgeInsets.all(32)
m3e.spacing.horizontal16     // EdgeInsets.symmetric(horizontal: 16)
m3e.spacing.horizontal24     // EdgeInsets.symmetric(horizontal: 24)
m3e.spacing.vertical8        // EdgeInsets.symmetric(vertical: 8)
m3e.spacing.vertical12       // EdgeInsets.symmetric(vertical: 12)
m3e.spacing.vertical16       // EdgeInsets.symmetric(vertical: 16)
m3e.spacing.symmetricH16V8   // EdgeInsets.symmetric(h:16, v:8)  ← chip/button padding
m3e.spacing.symmetricH16V12  // EdgeInsets.symmetric(h:16, v:12) ← list tile padding
m3e.spacing.symmetricH24V16  // EdgeInsets.symmetric(h:24, v:16) ← section header
```

---

## 2. Shape tokens (`context.m3e.shapes`)

### 2a. Standard corner radius scale

Source: Material 3 shape scale
Official reference: [Material shape](https://m3.material.io/styles/shape/overview-principles)
Evidence: **Material guidance** (scale exists) + **Custom** (exact dp values; Material publishes the scale in the Material Theme Builder, not directly in prose docs)

| Token | Value | BorderRadius accessor | Typical use |
|---|---|---|---|
| `radiusNone` | 0dp | `m3e.shapes.borderNone` | Dividers, full-bleed images |
| `radiusExtraSmall` | 4dp | `m3e.shapes.borderExtraSmall` | Dense chips, small badges |
| `radiusSmall` | 8dp | `m3e.shapes.borderSmall` | Filled text fields, small buttons |
| `radiusMedium` | 12dp | `m3e.shapes.borderMedium` | Cards, menus, dialogs (smaller) |
| `radiusLarge` | 16dp | `m3e.shapes.borderLarge` | Modals, large cards, bottom sheets |
| `radiusExtraLarge` | 28dp | `m3e.shapes.borderExtraLarge` | Floating elements, search bars |
| `radiusFull` | 999dp | `m3e.shapes.borderFull` | Pills, chips, FABs |

Usage:

```dart
// As BorderRadius
Container(
  decoration: BoxDecoration(
    color: theme.colorScheme.surfaceContainerLow,
    borderRadius: m3e.shapes.borderLarge,   // BorderRadius.circular(16)
  ),
)

// As ShapeBorder (for Material widget)
Card(
  shape: RoundedRectangleBorder(
    borderRadius: m3e.shapes.borderMedium,
  ),
)
```

### 2b. 35 iconic M3E shapes

Source: Google Material 3 Expressive design kit
Evidence: **Custom** — these shapes are implemented by this repository based on the publicly described shape taxonomy. No Flutter SDK API exposes them natively. Each is a `M3EShapeDefinition` usable with `ClipPath` or as a `ShapeBorder`.

Access pattern: `context.m3e.shapes.<shapeName>` returns `M3EShapeDefinition`.

```dart
// As ClipPath
ClipPath(
  clipper: M3EShapeClipper(m3e.shapes.burst),
  child: yourWidget,
)

// As ShapeBorder
Material(
  shape: m3e.shapes.clover4Leaf.toBorder(),
  child: yourWidget,
)
```

| Shape ID | Category | Typical application |
|---|---|---|
| `arch` | Functional | Header containers, section frames |
| `arrow` | Functional | Directional callouts, tooltips |
| `badge` | Functional | Notification counts, status flags |
| `boom` | Dynamic | Flash-sale tags, alert indicators |
| `softBoom` | Dynamic | Softer urgency callouts |
| `burst` | Dynamic | Promotion badges, discount callouts |
| `softBurst` | Dynamic | Softer promotional accents |
| `circle` | Geometric | Avatars, dot indicators |
| `clover4Leaf` | Organic | Achievement badges, hero icons |
| `clover8Leaf` | Organic | Decorative accents, complex badges |
| `cookie4Sided` | Organic | Playful card accents |
| `cookie6Sided` | Organic | Playful tile containers |
| `cookie9Sided` | Organic | Playful avatar frames |
| `cookie12Sided` | Organic | Decorative illustration frames |
| `diamond` | Geometric | Stat tiles, category icons |
| `egg` | Organic | Soft hero illustrations |
| `flower` | Organic | Reward icons, celebration moments |
| `heart` | Organic | Favorites, like indicators |
| `hexagon` | Geometric | Tech/data category tiles |
| `roundedHexagon` | Geometric | Softer hexagonal tiles |
| `octagon` | Geometric | Warning/stop indicators |
| `oval` | Geometric | Landscape photo crops |
| `pentagon` | Geometric | Achievement levels |
| `pill` | Functional | Buttons, chips, single-line tags |
| `pixelCircle` | Technical | Retro/game-style icons |
| `pixelTriangle` | Technical | Retro/game-style indicators |
| `polygonTriangle` | Geometric | Direction indicators |
| `squircle` | Geometric | App icons, modern card containers |
| `roundedRectangle` | Functional | Standard cards and panels |
| `cutCornerRectangle` | Functional | High-tech / data-dense panels |
| `ribbon` | Functional | Labeling / annotation strips |
| `semiCircle` | Geometric | Toggle tabs, partial containers |
| `shield` | Functional | Security status, protection features |
| `star4Point` | Organic | Sparkle accents, featured highlights |
| `sunny` | Organic | Positive feedback, celebration |

---

## 3. Motion tokens (`context.m3e.motion`)

Source: Material 3 motion guidance
Official reference: [Material motion](https://m3.material.io/styles/motion/overview/how-it-works), [Easing and duration](https://m3.material.io/styles/motion/easing-and-duration/applying-easing-and-duration)
Evidence: **Material guidance** (spring motion direction, two-scheme distinction) + **Custom** (spring parameter values — mass, stiffness, damping — are not published by Google; labeled custom)

### Duration constants

| Token | Value | When to use |
|---|---|---|
| `durationFast` | 150ms | Micro-interactions: focus rings, hover highlight fades |
| `durationMedium` | 300ms | Standard state transitions: selected/unselected, expand/collapse |
| `durationSlow` | 500ms | Large container transforms, full-screen transitions |

### Curve constants

| Token | Flutter curve | When to use |
|---|---|---|
| `curveSpatialOvershoot` | `Curves.easeOutBack` | Positional springs with a slight bounce |
| `curveContainerMorph` | `Curves.fastOutSlowIn` | Container shape/size morphing |
| `curveEffectFade` | `Curves.easeOutCubic` | Fades, color shifts, elevation changes |

### Spring physics

**Spatial spring** — for position, size, and shape transitions (allows slight overshoot):

```dart
// Parameters (Custom Implementation Choice — not official Material values):
// Mass: 1.0 | Stiffness: 380.0 | Damping: 18.0
final spring = m3e.motion.createSpatialSpring(start: 0.0, end: 1.0);
controller.animateWith(spring);
```

**Effect spring** — for color, opacity, and elevation (critically damped, no overshoot):

```dart
// Parameters (Custom Implementation Choice — not official Material values):
// Mass: 1.0 | Stiffness: 500.0 | Damping: 35.0
final spring = m3e.motion.createEffectSpring(start: 0.0, end: 1.0);
controller.animateWith(spring);
```

**Decision guide — when to use which spring:**

| Transition type | Use spatial spring | Use effect spring |
|---|---|---|
| Element moves across screen | ✓ | |
| Container grows or shrinks | ✓ | |
| Shape morphs | ✓ | |
| Card expands | ✓ | |
| Color changes | | ✓ |
| Opacity / fade | | ✓ |
| Elevation change | | ✓ |
| Icon changes | | ✓ |

**Reduced motion — always required:**

```dart
final reduce = MediaQuery.of(context).disableAnimations;
final duration = reduce ? Duration.zero : m3e.motion.durationMedium;
final curve = reduce ? Curves.linear : m3e.motion.curveSpatialOvershoot;
```

---

## 4. Color tokens (Flutter `ColorScheme`)

Source: Material 3 color system
Official reference: [Material color roles](https://m3.material.io/styles/color/roles)
Evidence: **Material guidance** — `ColorScheme` roles are official. The mapping below is the Flutter API naming, which aligns with the M3 role names.

These are accessed via `Theme.of(context).colorScheme`, **not** via `context.m3e`. The `ColorScheme` is the official Flutter surface for color.

### Role reference

| ColorScheme property | M3 role | Use for |
|---|---|---|
| `primary` | Primary | Key components: FAB, prominent buttons, active states |
| `onPrimary` | On Primary | Text/icons on primary-colored surfaces |
| `primaryContainer` | Primary Container | Selected states, prominent container fills |
| `onPrimaryContainer` | On Primary Container | Text/icons on primary containers |
| `secondary` | Secondary | Less prominent components; filtering chips |
| `onSecondary` | On Secondary | Text/icons on secondary-colored surfaces |
| `secondaryContainer` | Secondary Container | Tonal button fills, tag backgrounds |
| `onSecondaryContainer` | On Secondary Container | Text/icons on secondary containers |
| `tertiary` | Tertiary | Contrasting accents to balance primary/secondary |
| `onTertiary` | On Tertiary | Text/icons on tertiary surfaces |
| `tertiaryContainer` | Tertiary Container | Contrasting accent fills |
| `onTertiaryContainer` | On Tertiary Container | Text/icons on tertiary containers |
| `surface` | Surface | Default background of screens and cards |
| `onSurface` | On Surface | Primary text and icons on surfaces |
| `surfaceVariant` | Surface Variant | Divider-adjacent subtle fills (deprecated, use containers below) |
| `onSurfaceVariant` | On Surface Variant | Secondary text; icons; placeholders on surfaces |
| `surfaceContainerLowest` | Surface Container Lowest | Page background on light themes |
| `surfaceContainerLow` | Surface Container Low | Card fill on light themes |
| `surfaceContainer` | Surface Container | Dialog, sheet fill (neutral mid) |
| `surfaceContainerHigh` | Surface Container High | Card fill on dark themes |
| `surfaceContainerHighest` | Surface Container Highest | Input field fills, dense containers |
| `outline` | Outline | TextField borders, card borders when contrast needed |
| `outlineVariant` | Outline Variant | Subtle dividers; borders at lower emphasis |
| `error` | Error | Error state text, icons, borders |
| `onError` | On Error | Text/icons on error-colored surfaces |
| `errorContainer` | Error Container | Filled error banners |
| `onErrorContainer` | On Error Container | Text/icons on error containers |
| `inverseSurface` | Inverse Surface | Snackbar/tooltip background |
| `onInverseSurface` | Inverse On Surface | Text on snackbar/tooltip |
| `inversePrimary` | Inverse Primary | Links/icons on inverse surfaces |

### State layer opacities (Flutter-standard, not M3E-specific)

These are applied automatically by Material widgets. For custom widgets:

| State | Opacity |
|---|---|
| Hover | 8% |
| Focus | 12% |
| Pressed | 12% |
| Dragged | 16% |

---

## 5. Typography (`context.m3e.typography` and `TextTheme`)

Source: Material 3 type scale
Official reference: [Material typography](https://m3.material.io/styles/typography/overview)
Evidence: **Material guidance** (role names and hierarchy) — access via both `Theme.of(context).textTheme` (standard Flutter) and `context.m3e.typography` (flex scale with variable font support).

### Standard role mapping

Always pick a role by **content purpose**, not by visual size:

| Role | Flutter accessor | Use for |
|---|---|---|
| `displayLarge` | `textTheme.displayLarge` | Hero numbers, large hero text |
| `displayMedium` | `textTheme.displayMedium` | Hero headlines on tablets and other large mobile screens |
| `displaySmall` | `textTheme.displaySmall` | Prominent page titles (large mobile viewports) |
| `headlineLarge` | `textTheme.headlineLarge` | Section headers on tablets and other large mobile screens |
| `headlineMedium` | `textTheme.headlineMedium` | App bar title (large layout), section headers |
| `headlineSmall` | `textTheme.headlineSmall` | Card titles, modal headers |
| `titleLarge` | `textTheme.titleLarge` | App bar title (standard); dialog title |
| `titleMedium` | `textTheme.titleMedium` | List item primary text; tab labels |
| `titleSmall` | `textTheme.titleSmall` | Dense list secondary text; metadata labels |
| `bodyLarge` | `textTheme.bodyLarge` | Long-form body text; descriptions |
| `bodyMedium` | `textTheme.bodyMedium` | Standard body text; secondary descriptions |
| `bodySmall` | `textTheme.bodySmall` | Captions; helper text; timestamps |
| `labelLarge` | `textTheme.labelLarge` | Button labels; prominent tags |
| `labelMedium` | `textTheme.labelMedium` | Navigation bar labels; chip labels |
| `labelSmall` | `textTheme.labelSmall` | Badge text; tooltip text |

---

## 6. Layout breakpoints

Evidence: **Custom Implementation Choice** — Material publishes breakpoint guidance at [Material breakpoints](https://m3.material.io/foundations/layout/breakpoints/overview), but no exact pixel values are mandated for all situations. These values are the repository's implementation decision.

| Breakpoint | Width range | Navigation pattern | Layout |
|---|---|---|---|
| Compact | < 720dp | `NavigationBar` (bottom) | Single column; full-width content |
| Medium | 720–1024dp | `NavigationRail` (side) | Two-column optional; 840dp max content |
| Expanded | > 1024dp | `NavigationDrawer` (side) | Multi-pane; 1200dp max content |

Usage in code:

```dart
LayoutBuilder(
  builder: (context, constraints) {
    final width = constraints.maxWidth;
    if (width < 720) {
      return const _CompactLayout();
    } else if (width < 1024) {
      return const _MediumLayout();
    }
    return const _ExpandedLayout();
  },
)
```
