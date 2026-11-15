# Component guidance

This is a component selection aid, not a custom widget library. A Flutter widget's existence does not establish that it matches a particular M3 Expressive component or its current design details. Check the current Material component page for design intent and the target Flutter SDK for actual API behavior.

## Choose by user task

| User task | Flutter starting point | Verify |
|---|---|---|
| Primary or secondary action | `FilledButton`, `FilledButton.tonal`, `OutlinedButton`, `TextButton` | Action hierarchy, variants, states, label, and target SDK |
| Icon-only action | `IconButton` | Tooltip/semantics, tap area, focus and disabled state |
| Mutually exclusive choices | `SegmentedButton<T>` | Selection cardinality, semantics, and version-specific API |
| Independent adjacent commands | Compose individual buttons | Do not give commands selection/radio semantics |
| App-level destinations | `NavigationBar`, `NavigationRail`, or `NavigationDrawer` | Real destination structure, available width, selection, and platform navigation |
| Peer content views | `TabBar` and `TabBarView` | Tabs are not automatically app-level navigation |
| Grouped content | `Card`, `ListTile`, `ListView`, or a custom composition | Use only where grouping helps; use lazy builders for large lists |
| Search and filtering | `SearchBar`, `SearchAnchor`, text fields, chips | Query, suggestions, empty/loading/error states, keyboard and semantics |
| Data input | `TextField`, `Checkbox`, `Radio`, `Switch`, `Slider`, pickers | Labels, validation, selection behavior, keyboard, locale, accessibility |
| Menus and related actions | `MenuAnchor`, `DropdownMenu`, `PopupMenuButton` | Focus, dismissal, placement, and related menu behavior |
| Dialogs, sheets, transient feedback | `showDialog`, `showModalBottomSheet`, `SnackBar` | Focus/dismissal, screen fit, scroll, announcements, and persistence of critical messages |
| Progress and status | `CircularProgressIndicator`, `LinearProgressIndicator`, `Badge` | Determinate status, semantics, and whether a dedicated expressive variant is documented |

These are API starting points only. Check availability and behavior in the target app's pinned Flutter version.

## Components with no assumed one-to-one mapping

Material guidance includes concepts such as button groups, split buttons, FAB menus, side sheets, and loading indicators. Do not assume a nearby Flutter widget is equivalent:

- **Button groups:** distinguish mutually exclusive/multiple selection from independent actions.
- **Split button:** keep the primary command separate from its menu trigger. A composed button/menu is app code, not automatically a stock split-button.
- **FAB menu:** implement only when it benefits the task; define labels, focus, dismissal, collision handling, and reduced motion.
- **Side sheet:** a scaffold drawer is not proof of side-sheet equivalence. Verify modal/non-modal behavior and layout.
- **Loading indicator:** use the documented Flutter capability unless current design evidence requires a tested custom composition.

Do not force a card, navigation, or expressive shape into a screen without a user/task need. Do not label baseline Material widgets deprecated or forbidden for M3E without an applicable authoritative source.

## Example: separate primary and menu actions

```dart
import 'package:flutter/material.dart';

class ExportActions extends StatelessWidget {
  const ExportActions({
    super.key,
    required this.onExport,
    required this.onExportAs,
  });

  final VoidCallback onExport;
  final VoidCallback onExportAs;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FilledButton(
          onPressed: onExport,
          child: const Text('Export'),
        ),
        MenuAnchor(
          menuChildren: [
            MenuItemButton(
              onPressed: onExportAs,
              child: const Text('Export as'),
            ),
          ],
          builder: (context, controller, child) => IconButton(
            tooltip: 'More export options',
            onPressed: () => controller.open(),
            icon: const Icon(Icons.arrow_drop_down),
          ),
        ),
      ],
    );
  }
}
```

This is an illustrative Flutter composition. Confirm imports and API signatures in the target app.

## Screen composition patterns

These are task-oriented starting points, not canonical M3E templates:

- **Onboarding:** short hierarchy, optional illustration, one primary action, clear skip/secondary path.
- **Search/discovery:** query, filters where useful, results, and explicit empty/loading/error states.
- **Feed or library:** scannable list or grid, consistent metadata, and unambiguous per-item actions.
- **Profile/settings:** grouped identity/preferences with explicit labels and deliberate treatment of destructive actions.
- **Messaging:** readable message groups, accessible composer, keyboard/IME handling, and safe-area behavior.
- **Notifications:** distinguish persistent important status from transient confirmation.

For every pattern, adapt content to the user's task and validate text scale, localization, RTL, semantics, navigation, and screen constraints.

## Component validation

For each used state, test the relevant enabled/disabled, selected, focused, pressed, open/closed, loading, error, and dismissal behaviors. Test hover only if the mobile app supports pointer input. Compare against the current official component source; do not derive exact geometry, timing, or colors from a compressed reference image.

Primary sources: [buttons](https://m3.material.io/components/buttons/overview), [button groups](https://m3.material.io/components/button-groups/overview), [navigation](https://m3.material.io/components/navigation-bar/overview), [cards](https://m3.material.io/components/cards/overview), [lists](https://m3.material.io/components/lists/overview), [chips](https://m3.material.io/components/chips/overview), [menus](https://m3.material.io/components/menus/overview), and [side sheets](https://m3.material.io/components/side-sheets/overview).
