# Custom components

Extend Flutter only when the component requirements cannot be met by verified built-in widgets and themes. This document details the custom Material 3 Expressive (M3E) reference components implemented in `examples/flutter/reference_app/lib/m3e/widgets/`.

---

## 1. Component Strategy

1. **Identify the Visual and Interaction Gap**: Verify that the required M3E component behavior is not provided by the baseline Flutter SDK.
2. **Compose Standard Primitives**: Prefer combining existing Flutter widgets (`Material`, `InkWell`, `Semantics`, `LayoutBuilder`, and spring animation primitives) rather than forking or copying framework internals.
3. **Bind to Semantic Tokens**: Every component must source its visual parameters from `ColorScheme`, `context.m3e.spacing`, and `context.m3e.shapes`. Zero magic numbers are permitted.
4. **Preserve Accessibility**: Follow the relevant platform touch-target guidance (Flutter's guide cites 48x48 dp for Android and 44x44 pt for iOS), preserve text at large platform scale settings, and support bidirectional layout (RTL). Verify any separate accessibility-conformance requirements that apply to the mobile app; see [accessibility guidance](../foundations/accessibility.md).
5. **Spring Physics**: Use `M3EMotion.createSpatialSpring()` and `M3EMotion.createEffectSpring()` for state transitions instead of linear or ease-in-out curves.

---

## 2. Implemented Reference Widgets

### 2.1 M3ESegmentedList

Replaces disconnected card collections with a unified, segmented container that groups related items within a continuous perimeter border and subtle dividers, supporting spring morphing physics during selection and state changes.

```dart
import 'package:material_ui/material_ui.dart';
import 'package:reference_app/m3e/m3e.dart';

M3ESegmentedList<String>(
  items: const ['Item 1', 'Item 2', 'Item 3'],
  itemBuilder: (context, item, index, isFirst, isLast) {
    return ListTile(
      title: Text(item),
      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
      onTap: () {},
    );
  },
)
```

- **Key Characteristics**:
  - Rounds top corners with `borderLarge` (16dp) for the first item.
  - Rounds bottom corners with `borderLarge` for the last item.
  - Inserts subtle `surfaceContainerHighest` dividers between adjacent entries.
  - Enforces intrinsic height measurement to avoid clipping during text scaling.

---

### 2.2 M3EAppBar

An expressive top app bar featuring shortened responsive bounds, prominent headline typography, and clear action separation with accessible touch targets.

```dart
import 'package:material_ui/material_ui.dart';
import 'package:reference_app/m3e/m3e.dart';

M3EAppBar(
  title: 'Dashboard Overview',
  subtitle: 'Material 3 Expressive Reference',
  actions: [
    IconButton(
      onPressed: () {},
      icon: const Icon(Icons.notifications_outlined),
    ),
  ],
)
```

- **Key Characteristics**:
  - Implements `PreferredSizeWidget` with responsive height scaling.
  - Supports subtitles and badges.
  - Action buttons preserve the applicable platform-recommended touch target.

---

### 2.3 M3EConnectedButtonGroup

A segmented group of action buttons that share a continuous outer perimeter and inner dividers. It provides three discrete density levels:
- `compact`: Dense toolbars and compact viewports (height: 36dp).
- `standard`: Standard touch density (height: 44dp).
- `comfortable`: Expanded layout for tablets (height: 52dp).

```dart
import 'package:material_ui/material_ui.dart';
import 'package:reference_app/m3e/m3e.dart';

M3EConnectedButtonGroup<int>(
  selectedIndex: 0,
  density: M3EButtonDensity.standard,
  onSelected: (index) {
    // Handle selection change
  },
  items: const [
    M3EButtonItem(icon: Icons.view_day_rounded, label: 'Day'),
    M3EButtonItem(icon: Icons.view_week_rounded, label: 'Week'),
    M3EButtonItem(icon: Icons.calendar_month_rounded, label: 'Month'),
  ],
)
```

---

### 2.4 M3ESplitButton

An expressive dual-action button combining a primary action button and an adjacent dropdown menu trigger, separated by a thin vertical divider within a cohesive outer shape.

```dart
import 'package:material_ui/material_ui.dart';
import 'package:reference_app/m3e/m3e.dart';

M3ESplitButton(
  label: 'Save Project',
  icon: Icons.save_rounded,
  onPrimaryPressed: () {
    // Primary save action
  },
  onTrailingPressed: () {
    // Open secondary export / save-as options menu
  },
)
```

---

### 2.5 M3EAdaptiveScaffold

A responsive layout container using `LayoutBuilder` that automatically transitions between navigation patterns across screen breakpoints:
- **Mobile (< 720dp)**: Bottom `NavigationBar`.
- **Tablet (720dp - 1024dp)**: Lateral `NavigationRail`.
- **Expanded mobile/tablet width (> 1024dp)**: `NavigationDrawer`. The breakpoint is a project-defined layout choice, not a universal Material requirement.

```dart
import 'package:material_ui/material_ui.dart';
import 'package:reference_app/m3e/m3e.dart';

M3EAdaptiveScaffold(
  currentIndex: 0,
  onNavigationChanged: (index) {},
  destinations: const [
    NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
    NavigationDestination(icon: Icon(Icons.dashboard_outlined), label: 'Components'),
    NavigationDestination(icon: Icon(Icons.settings_outlined), label: 'Settings'),
  ],
  body: const Center(child: Text('Screen Content')),
)
```

---

## 3. The 35 Canonical M3E Shapes

All 35 canonical expressive shapes are available directly through `context.m3e.shapes`:

| Shape Category | Token Name | Typical Application |
| :--- | :--- | :--- |
| **Organic** | `clover4Leaf`, `clover8Leaf`, `flower`, `sunny` | Badges, achievements, avatars, hero callouts |
| **Geometric** | `squircle`, `hexagon`, `octagon`, `diamond` | Feature cards, category filters, stat containers |
| **Dynamic** | `burst`, `softBurst`, `boom`, `softBoom` | Promotional tags, urgency indicators, discounts |
| **Functional** | `pill`, `cutCornerRectangle`, `shield` | Primary buttons, security statuses, search bars |

```dart
// Example using ClipPath with M3E Shape:
ClipPath(
  clipper: M3EShapeClipper(context.m3e.shapes.burst),
  child: Container(
    width: 64,
    height: 64,
    color: Theme.of(context).colorScheme.primaryContainer,
    child: const Icon(Icons.local_offer_rounded),
  ),
)
```
