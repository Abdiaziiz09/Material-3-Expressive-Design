# Shape

Shape communicates grouping, hierarchy, and interaction. Material 3 documents shape guidance and tokens at [Material shape](https://m3.material.io/styles/shape/overview-principles). Flutter offers shapes through `ShapeBorder`, `OutlinedBorder`, `BorderRadius`, and component themes.

---

## Standard corner radius scale

Material 3 defines a corner radius scale. The values below are implemented in this repository as `M3EShapes` and accessed via `context.m3e.shapes`. They represent the Material radius scale as commonly published in the Material Theme Builder.

**Evidence:** Material guidance (scale exists and is named) + Custom (exact dp values — Material does not publish these in stable prose docs; labeled as custom until a canonical source is confirmed).

| Role | Token | Value | Typical component |
|---|---|---|---|
| None | `radiusNone` | 0dp | Dividers, full-bleed images |
| Extra small | `radiusExtraSmall` | 4dp | Dense chips, small tags |
| Small | `radiusSmall` | 8dp | Text fields, small buttons |
| Medium | `radiusMedium` | 12dp | Cards, menus |
| Large | `radiusLarge` | 16dp | Modal sheets, large cards |
| Extra large | `radiusExtraLarge` | 28dp | Search bars, floating elements |
| Full | `radiusFull` | 999dp | Pills, FABs, chips |

See [design token registry](design-token-registry.md) for the full reference including `BorderRadius` accessors and usage examples.

---

## The 35 iconic M3E shapes

The repository includes 35 custom `M3EShapeDefinition` objects inspired by the publicly described Material 3 Expressive shape taxonomy. Their `toBorder()` method can be used where Flutter accepts a `ShapeBorder`. The repository does not provide a general-purpose `CustomClipper` for using these definitions with `ClipPath`.

**Evidence:** Custom — based on the publicly described M3E shape taxonomy. No Flutter SDK API exposes these natively. Verify each shape's intended role against the [Material blog](https://m3.material.io/blog/building-with-m3-expressive) before applying to production.

| Category | Shapes | Usage guidance |
|---|---|---|
| **Organic** | `clover4Leaf`, `clover8Leaf`, `flower`, `heart`, `egg`, `oval`, `sunny`, `star4Point` | Celebration, achievement, personality accents. Use sparingly — one per focal area. |
| **Geometric** | `circle`, `hexagon`, `roundedHexagon`, `octagon`, `diamond`, `pentagon`, `squircle`, `semiCircle`, `polygonTriangle` | Structured tiles, category containers, stat displays. |
| **Dynamic** | `burst`, `softBurst`, `boom`, `softBoom` | Promotional emphasis, urgency indicators, discount tags. Reserve for active callouts. |
| **Functional** | `arch`, `arrow`, `badge`, `cookie4Sided`, `cookie6Sided`, `cookie9Sided`, `cookie12Sided`, `cutCornerRectangle`, `pill`, `pixelCircle`, `pixelTriangle`, `ribbon`, `roundedRectangle`, `shield` | Buttons, chips, data containers, security indicators. |

See [component decision matrix](../components/component-decision-matrix.md) for which shape to pick for each design pattern.

---

## Application rules

- **One expressive shape per focal area.** Use organic or dynamic shapes as focal accents, not as repeating grid elements or backgrounds.
- **Readable content area first.** Do not use a shape that clips content meaningfully unless the clip is intentional (e.g. a circle avatar crop).
- **Nested surfaces.** Calculate inner geometry from the available padding and clipping requirements. Do not repeat the parent radius without adjusting for inset.
- **Hit testing.** When clipping with `ClipPath`, the interactive hit region matches the rectangular bounding box by default. If a non-rectangular touch boundary is needed, override `HitTestBehavior` or use a `CustomClipper` that also handles hit testing.
- **Reduced motion.** If an app implements shape morphing, follow the platform reduced-motion setting and provide a static end-state fallback. The repository shape definitions are static and do not implement a morphing widget.

---

## Flutter implementation

```dart
// ── Standard rounded corner ──────────────────────────────────────────────────
Container(
  decoration: BoxDecoration(
    color: theme.colorScheme.surfaceContainerLow,
    borderRadius: context.m3e.shapes.borderLarge,  // BorderRadius.circular(16)
  ),
)

// ── Card shape via Material ───────────────────────────────────────────────────
Card(
  shape: RoundedRectangleBorder(
    borderRadius: context.m3e.shapes.borderMedium,  // BorderRadius.circular(12)
  ),
  child: Padding(
    padding: context.m3e.spacing.all16,
    child: child,
  ),
)

// ── Repository shape as ShapeBorder ──────────────────────────────────────────
Material(
  shape: context.m3e.shapes.squircle.toBorder(),
  clipBehavior: Clip.antiAlias,
  color: theme.colorScheme.surfaceContainerLow,
  child: Padding(
    padding: context.m3e.spacing.all16,
    child: child,
  ),
)
```

---

## Verification checklist

- [ ] Corner shapes are consistent with component intent — not applied decoratively without purpose.
- [ ] Text and icon content is not clipped by the shape.
- [ ] Nested containers have correct inner radii (outer radius minus padding).
- [ ] Focus indicator is visible outside or inside the shape boundary (check `FocusDecoration` behavior).
- [ ] Touch target remains usable and follows target-platform guidance (Flutter cites 48×48 dp for Android and 44×44 pt for iOS), even when the visible shape is non-rectangular. See [accessibility guidance](accessibility.md).
- [ ] Shape morphing uses `m3e.motion.createSpatialSpring()` and has a `Duration.zero` reduced-motion fallback.
