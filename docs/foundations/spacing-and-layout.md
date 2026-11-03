# Spacing and layout

Material 3 defines layout using grids, spacing scales, breakpoints, and canonical layout patterns. This page documents the practical implementation rules for Flutter, the repository's token values, and the breakpoint decisions applied in the reference app.

Official references: [Layout overview](https://m3.material.io/foundations/layout/layout-overview/overview), [Grids and spacing](https://m3.material.io/foundations/layout/grids-spacing/overview), [Breakpoints](https://m3.material.io/foundations/layout/breakpoints/overview), [Canonical layouts](https://m3.material.io/foundations/layout/canonical-examples/overview)

---

## Spacing scale

Material 3 uses an 8dp base grid. The full spacing scale is accessed via `context.m3e.spacing`. **Never write raw numeric literals** — always use these tokens.

See the [design token registry](design-token-registry.md) for the full reference table. Quick reference:

| Token | Value | Primary use |
|---|---|---|
| `space4` | 4dp | Icon-to-label gap; badge offset |
| `space8` | 8dp | Tight padding; inline gap between elements |
| `space12` | 12dp | Compact list tile vertical padding |
| `space16` | 16dp | Standard card padding; compact screen margin |
| `space24` | 24dp | Section spacing; tablet content margin |
| `space32` | 32dp | Major block separation |
| `space48` | 48dp | Project token for touch-target examples and mobile layout spacing |

---

## Layout principles

### Use constraints, not device labels

Never use `Platform.isAndroid` or `Platform.isIOS` to determine layout. Use `LayoutBuilder` and screen-width constraints.

```dart
// WRONG
if (Platform.isAndroid) {
  return MobileLayout();
}

// CORRECT
LayoutBuilder(
  builder: (context, constraints) {
    if (constraints.maxWidth < 720) return const CompactLayout();
    if (constraints.maxWidth < 1024) return const MediumLayout();
    return const ExpandedLayout();
  },
)
```

### Never use fixed widths or heights

Fixed dimensions can break under text scaling, translation, Android split-screen, and iPad multitasking/resizing.

```dart
// WRONG
SizedBox(width: 320, child: content)        // breaks on narrow screens
SizedBox(height: 56, child: Text(label))    // may clip at large platform text settings

// CORRECT
ConstrainedBox(
  constraints: BoxConstraints(
    minHeight: kMinInteractiveDimension,  // framework-defined interactive dimension
    maxWidth: 400,                        // guided maximum, not fixed
  ),
  child: Text(label, softWrap: true),
)
```

### Prefer logical directional padding

Use `EdgeInsetsDirectional` for RTL correctness, or use the symmetric helpers from `m3e.spacing`.

```dart
// Layout-aware padding:
Padding(
  padding: EdgeInsetsDirectional.fromSTEB(
    context.m3e.spacing.space16,  // start
    context.m3e.spacing.space12,  // top
    context.m3e.spacing.space8,   // end
    context.m3e.spacing.space12,  // bottom
  ),
  child: child,
)
```

---

## Breakpoints

**Evidence:** Custom Implementation Choice — Material publishes breakpoint categories (compact / medium / expanded) with general guidelines. The exact pixel thresholds below are the repository's implementation decision, not official Material token values.

| Breakpoint | Width | Navigation | Content | Screen margin |
|---|---|---|---|---|
| Compact | < 720dp | `NavigationBar` (bottom) | Full width | `space16` (both sides) |
| Medium | 720–1024dp | `NavigationRail` (side) | Max 840dp | `space24` (both sides) |
| Expanded | > 1024dp | `NavigationDrawer` (side) | Max 1200dp | `space32`+ (both sides) |

### Implementing breakpoints

```dart
class _WindowSizeClass {
  const _WindowSizeClass._();

  static bool isCompact(BoxConstraints c) => c.maxWidth < 720;
  static bool isMedium(BoxConstraints c) => c.maxWidth >= 720 && c.maxWidth < 1024;
  static bool isExpanded(BoxConstraints c) => c.maxWidth >= 1024;
}
```

### Content max-width constraint

On tablets and other wide mobile screens, constrain readable content rather than stretching it edge-to-edge.

```dart
Center(
  child: ConstrainedBox(
    constraints: const BoxConstraints(maxWidth: 1200),
    child: Padding(
      padding: EdgeInsets.symmetric(
        horizontal: constraints.maxWidth > 1024
          ? context.m3e.spacing.space32
          : context.m3e.spacing.space16,
      ),
      child: content,
    ),
  ),
)
```

---

## Canonical layout patterns

### Single-column (compact)

Default for narrow viewports. All content in a single scrollable column.

```dart
Scaffold(
  appBar: M3EAppBar(title: 'Title'),
  bottomNavigationBar: NavigationBar(/* ... */),
  body: SafeArea(
    child: ListView(
      padding: context.m3e.spacing.all16,
      children: [...],
    ),
  ),
)
```

### List-detail (medium and expanded)

Show a list pane and a detail pane side by side. Fall back to single-column list on compact.

```dart
LayoutBuilder(builder: (context, constraints) {
  final m3e = context.m3e;
  if (constraints.maxWidth < 720) {
    return _ListScreen(onSelect: _navigate);
  }
  return Row(
    children: [
      SizedBox(
        width: 360,
        child: _ListPanel(onSelect: (item) => setState(() => _item = item)),
      ),
      VerticalDivider(width: 1, color: theme.colorScheme.outlineVariant),
      Expanded(
        child: _DetailPanel(item: _item),
      ),
    ],
  );
})
```

### Supporting pane (medium and expanded)

Primary content with a contextual supporting pane (filters, properties, table of contents).

```dart
LayoutBuilder(builder: (context, constraints) {
  final showPane = constraints.maxWidth >= 1024;
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(child: _PrimaryContent()),
      if (showPane) ...[
        SizedBox(width: context.m3e.spacing.space24),
        SizedBox(
          width: 280,
          child: _SupportingPane(),
        ),
      ],
    ],
  );
})
```

---

## Safe areas and system UI

```dart
// Always wrap scrollable content in SafeArea
SafeArea(
  child: ListView(
    padding: context.m3e.spacing.all16,
    children: [...],
  ),
)

// Bottom-inset-aware padding for content above NavigationBar
Padding(
  padding: EdgeInsets.only(
    bottom: MediaQuery.of(context).viewInsets.bottom
          + context.m3e.spacing.space16,
  ),
  child: child,
)
```

---

## RTL verification

All spacing, layout, and directional icons must work in RTL locales. Test with:

```dart
// Wrap in a Directionality widget for quick RTL testing:
Directionality(
  textDirection: TextDirection.rtl,
  child: MyScreen(),
)
```

Checklist:
- [ ] Icons that indicate direction (arrows, chevrons) flip correctly with `m3e.shapes.arrow`-style logic or `Icon(iconData, textDirection:)`.
- [ ] `start`/`end` insets use `EdgeInsetsDirectional` or symmetric values.
- [ ] Column/row order of primary and secondary content mirrors correctly.

---

## Verification checklist

- [ ] No raw `EdgeInsets.all(n)`, `SizedBox(width: n)`, or `Container(height: n)` with numeric literals outside token files.
- [ ] `LayoutBuilder` used for responsive decisions — not `Platform` checks.
- [ ] Content max-width constrained on expanded viewports.
- [ ] `SafeArea` applied to scrollable and form content.
- [ ] Largest relevant platform text settings — no clipped labels, overflow, or unreachable controls.
- [ ] Optional project-defined 200% text-scale scenario — no clipping or overflow.
- [ ] RTL locale — layout, icons, and text all mirror correctly.
- [ ] Narrow viewport (360dp) — nothing overflows or requires horizontal scroll.
