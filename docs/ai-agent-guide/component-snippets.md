# Flutter component snippet catalog

This catalog helps any AI coding agent find reusable code in the repository without relying on vendor-specific prompt files. It points to the source files in the Flutter reference app so the implementation remains the source of truth instead of being copied into a second, drifting snippet library.

> **Scope and evidence:** Widgets in `examples/flutter/reference_app/lib/m3e/` are repository-authored examples. They are not a published Flutter package, an official Google implementation, or proof of M3 Expressive conformance. The examples below use APIs available in this repository's reference app; verify the target project's Flutter and package versions before adapting them.

## Find an existing implementation

| Need | Reference implementation | Notes |
|---|---|---|
| App bar with title, optional subtitle, and actions | [`M3EAppBar`](https://github.com/Abdiaziiz09/Material-3-Expressive-Design/blob/main/examples/flutter/reference_app/lib/m3e/widgets/m3e_app_bar.dart) | Inspect responsive bounds and defaults before reuse. |
| Connected selectable choices | [`M3EConnectedButtonGroup`](https://github.com/Abdiaziiz09/Material-3-Expressive-Design/blob/main/examples/flutter/reference_app/lib/m3e/widgets/m3e_button_group.dart) | Uses a `Set<T>` selection API; this is not Flutter's `SegmentedButton` API. |
| Grouped tappable list | [`M3ESegmentedList`](https://github.com/Abdiaziiz09/Material-3-Expressive-Design/blob/main/examples/flutter/reference_app/lib/m3e/widgets/m3e_segmented_list.dart) | Current non-reorderable implementation composes `ListTile`s. Verify list size and performance for the target screen. |
| Primary action with menu trigger | [`M3ESplitButton`](https://github.com/Abdiaziiz09/Material-3-Expressive-Design/blob/main/examples/flutter/reference_app/lib/m3e/widgets/m3e_split_button.dart) | Repository composition; verify hit targets, focus, and menu behavior for the target platform. |
| Adaptive navigation scaffold | [`M3EAdaptiveScaffold`](https://github.com/Abdiaziiz09/Material-3-Expressive-Design/blob/main/examples/flutter/reference_app/lib/m3e/widgets/m3e_adaptive_scaffold.dart) | Composes Flutter navigation widgets using project-specific width thresholds. Use only when the app has real top-level destinations; validate those thresholds and layouts. |
| Theme extension and tokens | [`M3EThemeExtension`](https://github.com/Abdiaziiz09/Material-3-Expressive-Design/blob/main/examples/flutter/reference_app/lib/m3e/theme/m3e_theme_extension.dart), [`M3ESpacing`](https://github.com/Abdiaziiz09/Material-3-Expressive-Design/blob/main/examples/flutter/reference_app/lib/m3e/theme/m3e_spacing.dart), [`M3EShapes`](https://github.com/Abdiaziiz09/Material-3-Expressive-Design/blob/main/examples/flutter/reference_app/lib/m3e/theme/m3e_shapes.dart), [`M3EMotion`](https://github.com/Abdiaziiz09/Material-3-Expressive-Design/blob/main/examples/flutter/reference_app/lib/m3e/theme/m3e_motion.dart) | Consult the [token registry](../foundations/design-token-registry.md) for values and evidence labels. |
| Complete composed app example | [`Melo library`](https://github.com/Abdiaziiz09/Material-3-Expressive-Design/blob/main/examples/flutter/reference_app/lib/screens/library_screen.dart), [`Melo player`](https://github.com/Abdiaziiz09/Material-3-Expressive-Design/blob/main/examples/flutter/reference_app/lib/screens/player_screen.dart) | Application-specific gallery and playback flows; not general-purpose component specifications. |

There is no dedicated M3E card or media-player widget in this reference app. Do not create or claim one based on screenshots or naming alone. A Flutter Material component may be appropriate when its verified behavior meets the requirement; a custom composition should be narrowly scoped and clearly labeled.

## Usage examples

These examples assume the reference app's local package and its `M3EThemeExtension` are available:

```dart
import 'package:material_ui/material_ui.dart';
import 'package:m3_expressive_reference_app/m3e/m3e.dart';
```

### App bar

```dart
Scaffold(
  appBar: M3EAppBar(
    title: const Text('Library'),
    subtitle: const Text('Your saved videos'),
    actions: [
      IconButton(
        tooltip: 'Refresh library',
        onPressed: onRefresh,
        icon: const Icon(Icons.refresh_rounded),
      ),
    ],
  ),
  body: body,
)
```

### Connected choice group

Keep the selected value in the parent state. Use stable values rather than labels as the state model:

```dart
M3EConnectedButtonGroup<String>(
  items: const [
    M3EButtonItem<String>(
      value: 'watch',
      label: Text('Watch'),
      icon: Icon(Icons.play_arrow_rounded),
    ),
    M3EButtonItem<String>(
      value: 'listen',
      label: Text('Listen only'),
      icon: Icon(Icons.headphones_rounded),
    ),
  ],
  selected: {selectedMode},
  onSelectionChanged: (selection) {
    if (selection.isNotEmpty) {
      setState(() => selectedMode = selection.single);
    }
  },
)
```

This is the repository widget's selection behavior, not a claim that it matches a particular official component specification. Verify its accessibility and interaction behavior in the source and tests.

### Split button

The repo component combines a primary action with a separate menu trigger:

```dart
M3ESplitButton(
  label: const Text('Export'),
  icon: const Icon(Icons.upload_rounded),
  onPressed: onExport,
  menuChildren: [
    MenuItemButton(
      onPressed: onExportAs,
      child: const Text('Export as'),
    ),
  ],
)
```

### Adaptive scaffold

Use this only when the app has real top-level destinations. Its responsive thresholds are project-specific; inspect the source and test the target form factors before adopting them:

```dart
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

### Segmented list

```dart
M3ESegmentedList(
  padding: context.m3e.spacing.all16,
  items: videos
      .map(
        (video) => M3ESegmentedListItem(
          id: video.id,
          leading: const Icon(Icons.movie_outlined),
          title: Text(video.title),
          subtitle: Text('${video.duration}'),
          onTap: () => openVideo(video),
        ),
      )
      .toList(growable: false),
)
```

Use it only when grouped list treatment fits the content. The current implementation builds a `Column` for non-reorderable items, so it is not automatically suitable for a large or unbounded collection.

## Before copying or adapting

- Read the selected widget's implementation and tests; a catalog entry is a pointer, not evidence of full conformance.
- Check constructor names, imports, and dependencies in the target project's pinned Flutter SDK and lockfile.
- Keep project token values distinct from official Material guidance; cite the evidence ledger and token registry.
- Prefer Flutter Material widgets when they satisfy the verified requirement. Do not force a custom widget or navigation pattern where it does not fit.
- Test accessibility, text scaling, RTL, reduced motion, responsive states, and platform behavior applicable to the target app.
- Follow the [implementation workflow](implementation-workflow.md) and complete the [validation checklist](validation-checklist.md).
