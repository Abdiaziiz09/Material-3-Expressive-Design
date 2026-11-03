# Custom components

Extend Flutter only when the verified requirement cannot be met by an appropriate built-in widget, theme, or existing repository component. The components in this guide are implementation examples maintained in `examples/flutter/reference_app/lib/m3e/`; they are not an official Google specification, a separately published package, or a guarantee of M3 Expressive conformance.

## Current reference implementations

Use the [component snippet catalog](../ai-agent-guide/component-snippets.md) for source-linked usage examples. The implementation files are the source of truth for constructor signatures and behavior:

| Component | Source | Current implementation notes |
|---|---|---|
| `M3ESegmentedList` | [`m3e_segmented_list.dart`](https://github.com/Abdiaziiz09/Material-3-Expressive-Design/blob/main/examples/flutter/reference_app/lib/m3e/widgets/m3e_segmented_list.dart) | Takes `List<M3ESegmentedListItem>`. Non-reorderable items are composed in a `Column`; do not assume lazy rendering for a large collection. |
| `M3EAppBar` | [`m3e_app_bar.dart`](https://github.com/Abdiaziiz09/Material-3-Expressive-Design/blob/main/examples/flutter/reference_app/lib/m3e/widgets/m3e_app_bar.dart) | Title/subtitle are widgets. Responsive width behavior is project code, not an official component dimension. |
| `M3EConnectedButtonGroup` | [`m3e_button_group.dart`](https://github.com/Abdiaziiz09/Material-3-Expressive-Design/blob/main/examples/flutter/reference_app/lib/m3e/widgets/m3e_button_group.dart) | Selectable options using `items`, `selected`, and `onSelectionChanged`; it is not an independent-action toolbar. |
| `M3ESplitButton` | [`m3e_split_button.dart`](https://github.com/Abdiaziiz09/Material-3-Expressive-Design/blob/main/examples/flutter/reference_app/lib/m3e/widgets/m3e_split_button.dart) | Composes a primary action and menu trigger; verify target-platform focus, semantics, and hit targets. |
| `M3EAdaptiveScaffold` | [`m3e_adaptive_scaffold.dart`](https://github.com/Abdiaziiz09/Material-3-Expressive-Design/blob/main/examples/flutter/reference_app/lib/m3e/widgets/m3e_adaptive_scaffold.dart) | Uses project-specific width thresholds and composes standard Flutter navigation widgets. Use only when the app needs top-level destinations. |

No dedicated M3E card, navigation bar, or media-player component is asserted here. For a relevant component gap:

1. Verify the need and available Flutter API against the target SDK and source evidence.
2. Prefer a built-in Material widget if its verified behavior meets the requirement.
3. Otherwise build the narrowest app-specific composition, using project tokens where applicable and labeling unverified or custom decisions.
4. Validate accessibility, responsive behavior, reduced motion, and platform-specific states.

## Shapes and tokens

The repository defines shape and spacing values in its own theme extension. Check the [design-token registry](../foundations/design-token-registry.md) for evidence labels; these project values are not automatically official Material tokens. `M3EShapeDefinition.toBorder()` provides a Flutter `ShapeBorder`. The reference app does not provide a general-purpose `CustomClipper` for these shapes, so a `ClipPath` example requires a separately implemented and tested clipper.

See the [shape guide](../foundations/shape.md), [token registry](../foundations/design-token-registry.md), and [accessibility guidance](../foundations/accessibility.md) before adapting visual values or interaction behavior.
