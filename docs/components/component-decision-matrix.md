# Component decision matrix

This page answers the question: **"Which Flutter widget do I use for this M3E design requirement?"**

Read this before composing any UI. It maps every common M3E design intent to its Flutter implementation path, evidence grade, and any custom repo widget.

> [!NOTE]
> Evidence grades: **E1** = Material page title/description confirmed. **E2** = Flutter API verified. **E3** = anatomy, states, and dimensions confirmed from source. **E4** = unverified / exploratory.

---

## How to use this matrix

1. Identify the design intent (what the user needs to do or understand).
2. Find the matching row.
3. Use the **Flutter widget** unless a **Repo widget** exists for an M3E gap.
4. Follow the implementation notes and linked pages.
5. If evidence is E1/E4, verify the source page before finalizing the design.

---

## Actions and buttons

| Design intent | Flutter widget | Repo widget | Evidence | Notes |
|---|---|---|---|---|
| Single primary action | `FilledButton` | — | E2 | Highest emphasis. One per primary task area. Fill: `colorScheme.primary`. |
| Secondary / tonal action | `FilledButton.tonal` | — | E2 | Second-tier emphasis. Fill: `colorScheme.secondaryContainer`. |
| Ghost / text-only action | `TextButton` | — | E2 | Lowest emphasis. Use in dialogs, alongside higher-emphasis buttons. |
| Outlined / medium action | `OutlinedButton` | — | E2 | Medium emphasis. Border: `colorScheme.outline`. |
| Icon-only action | `IconButton` (+ `.filled`, `.filledTonal`, `.outlined`) | — | E2 | Always set `tooltip` / `Semantics(label:)`. Follow platform tap-target guidance (Flutter cites 48×48 dp for Android and 44×44 pt for iOS); see [accessibility guidance](../foundations/accessibility.md). |
| Group of exclusive choices | `SegmentedButton<T>` | `M3EConnectedButtonGroup<T>` | E2; repo API is local | Select a built-in or repo implementation based on the verified requirement. The repo widget uses `items`, `selected: Set<T>`, `onSelectionChanged`, and `multiSelect`; inspect its source and semantics. |
| Group of independent actions | Compose with `Row` / `Wrap` + buttons | — | E2 | Keep independent actions as actions; do not give them selected-choice semantics. |
| Primary action + overflow menu | Compose `FilledButton` + `MenuAnchor` | `M3ESplitButton` | E1 | No stock Flutter split-button widget. Custom composition. |
| Floating primary action | `FloatingActionButton` | — | E2 | One FAB per screen. Reserve for the most contextually important action. |
| Floating action with label | `FloatingActionButton.extended` | — | E2 | Use when space allows; label improves discoverability. |
| FAB that opens multiple actions | Compose `FloatingActionButton` + `MenuAnchor` / overlay | — | E1 | No stock FAB-menu widget. Label animation, stagger, and reduced-motion are custom. |

### Button code patterns

```dart
// Primary action
FilledButton(
  onPressed: onSave,
  child: const Text('Save'),
)

// Tonal secondary action
FilledButton.tonal(
  onPressed: onShare,
  child: const Text('Share'),
)

// Icon button — accessible
IconButton(
  onPressed: onEdit,
  tooltip: 'Edit',
  style: IconButton.styleFrom(
    minimumSize: Size.square(context.m3e.spacing.space48),
  ),
  icon: const Icon(Icons.edit_rounded),
)

// Connected button group (repo widget)
M3EConnectedButtonGroup<String>(
  items: const [
    M3EButtonItem<String>(
      value: 'list',
      icon: Icon(Icons.list_rounded),
      label: Text('List'),
    ),
    M3EButtonItem<String>(
      value: 'grid',
      icon: Icon(Icons.grid_view_rounded),
      label: Text('Grid'),
    ),
  ],
  selected: {selectedView},
  onSelectionChanged: (selection) {
    if (selection.isNotEmpty) {
      setState(() => selectedView = selection.single);
    }
  },
)

// Split button (repo widget)
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

These are API usage examples for the repository's implementation, not evidence that the components fully match an official Material specification. See the [component snippet catalog](../ai-agent-guide/component-snippets.md) and verify behavior against the target app and SDK.

---

## Navigation

| Design intent | Flutter widget | Repo widget | Evidence | Notes |
|---|---|---|---|---|
| Bottom navigation (compact screens) | `NavigationBar` | `M3EAdaptiveScaffold` | E2 | 3–5 top-level destinations. Auto-selected with adaptive scaffold. |
| Side rail (medium screens) | `NavigationRail` | `M3EAdaptiveScaffold` | E2 | Pair with `leading` widget for extended. Verify label visibility. |
| Drawer navigation (expanded screens) | `NavigationDrawer` | `M3EAdaptiveScaffold` | E2 | Supports modal and permanent variants. |
| Top tab navigation | `TabBar` + `TabBarView` | — | E2 | Peer content categories only; not primary app navigation. |
| Top app bar | `AppBar`, `SliverAppBar` | `M3EAppBar` | E2 | `M3EAppBar` adds expressive shortened bounds and headline hierarchy. |
| Large app bar that collapses | `SliverAppBar.large`, `SliverAppBar.medium` | — | E2 | Verify constructor availability in pinned SDK. |
| Back navigation | `Navigator.pop`, system back | — | E2 | Android: support predictive back gesture. iOS: support swipe-to-pop. |
| Breadcrumb / step navigation | Compose custom | — | E4 | No stock widget. Build with `Row` + `TextButton`. |

### Mobile phone/tablet navigation pattern

The tablet transition threshold is an app-specific decision, not an official Material breakpoint. Use a named project token and validate it against the supported phone/tablet form factors; do not copy a numeric threshold without evidence.

```dart
// Use M3EAdaptiveScaffold for the reference app's phone/tablet navigation:
M3EAdaptiveScaffold(
  selectedIndex: _selectedIndex,
  onDestinationSelected: (index) => setState(() => _selectedIndex = index),
  destinations: const [
    M3EDestination(label: 'Home', icon: Icon(Icons.home_outlined)),
    M3EDestination(label: 'Explore', icon: Icon(Icons.explore_outlined)),
    M3EDestination(label: 'Profile', icon: Icon(Icons.person_outlined)),
  ],
  body: _screens[_selectedIndex],
)

// Or manual LayoutBuilder approach:
LayoutBuilder(builder: (context, constraints) {
  final useTabletNavigation =
      constraints.maxWidth >= appResponsiveTokens.tabletNavigationBreakpoint;
  return Scaffold(
    bottomNavigationBar: useTabletNavigation ? null : NavigationBar(
      selectedIndex: _selectedIndex,
      onDestinationSelected: (i) => setState(() => _selectedIndex = i),
      destinations: _destinations,
    ),
    body: Row(children: [
      if (useTabletNavigation) NavigationRail(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (i) => setState(() => _selectedIndex = i),
        destinations: _railDestinations,
      ),
      Expanded(child: _screens[_selectedIndex]),
    ]),
  );
})
```

---

## Content and surfaces

| Design intent | Flutter widget | Repo widget | Evidence | Notes |
|---|---|---|---|---|
| Card / content container | `Card` or `Material` + `InkWell` | — | E2 | Use `colorScheme.surfaceContainerLow` fill. Shape via `m3e.shapes.borderLarge`. |
| Grouped list items (M3E style) | `ListView` + `ListTile` | `M3ESegmentedList` | E3 (custom) | `M3ESegmentedList` groups items with continuous border; replaces isolated cards. |
| Simple vertical list | `ListView`, `SliverList` | — | E2 | |
| Grid of items | `GridView`, `SliverGrid` | — | E2 | |
| Expandable / collapsible section | `ExpansionTile`, `ExpansionPanelList` | — | E2 | Animate expansion with `m3e.motion.curveContainerMorph`. |
| Image / media card | `Card` + `ClipRRect` or `ClipPath` | — | E2 | Use `m3e.shapes.borderLarge` on the clip. |
| Bottom sheet | `showModalBottomSheet`, `showBottomSheet` | — | E2 | Top corners: `m3e.shapes.borderExtraLarge`. |
| Alert dialog | `AlertDialog`, `showDialog` | — | E2 | Shape: `m3e.shapes.borderExtraLarge`. |
| Side sheet (modal) | `Scaffold.endDrawer` (approximate) | — | E1 | No dedicated side-sheet widget. `endDrawer` is not identical; label custom. |
| Snackbar | `SnackBar` via `ScaffoldMessenger` | — | E2 | Use `colorScheme.inverseSurface` fill. |
| Banner / inline notice | `MaterialBanner` | — | E2 | Persistent; use for requiring user action. |
| Tooltip | `Tooltip` | — | E2 | Set `message`; verify timing and RTL. |
| Badge | `Badge` | — | E2 | Dot (no label) or numbered. Always set semantics on parent. |

### Surface hierarchy — choose container level by emphasis

```dart
// Lowest emphasis: page background
Scaffold(backgroundColor: theme.colorScheme.surfaceContainerLowest)

// Low emphasis: card on light theme
Container(color: theme.colorScheme.surfaceContainerLow)

// Mid emphasis: dialog, bottom sheet
Container(color: theme.colorScheme.surfaceContainer)

// High emphasis: input fill, dense container
Container(color: theme.colorScheme.surfaceContainerHigh)
```

---

## Input and selection

| Design intent | Flutter widget | Repo widget | Evidence | Notes |
|---|---|---|---|---|
| Text input | `TextField`, `TextFormField` | — | E2 | Fill: `colorScheme.surfaceContainerHighest`. Focused border: `colorScheme.primary`. |
| Dropdown select | `DropdownMenu<T>` | — | E2 | Prefer over legacy `DropdownButton` for M3 apps. |
| Search input | `SearchBar`, `SearchAnchor` | — | E2 | Shape: `m3e.shapes.borderFull`. |
| Checkbox | `Checkbox`, `CheckboxListTile` | — | E2 | Test checked, unchecked, indeterminate, and disabled. |
| Radio | `Radio`, `RadioListTile` | — | E2 | Always group under a single label with `Semantics(groupId:)`. |
| Toggle / switch | `Switch`, `SwitchListTile` | — | E2 | Verify accessibility announcement of on/off state. |
| Slider | `Slider`, `RangeSlider` | — | E2 | Discrete or continuous. Verify touch target and label. |
| Date picker | `showDatePicker` | — | E2 | Use `DatePickerTheme` for M3 styling. |
| Time picker | `showTimePicker` | — | E2 | Dial and input modes. Verify locale conventions. |
| Chip | `FilterChip`, `ChoiceChip`, `InputChip`, `ActionChip` | — | E2 | Each chip type has a distinct semantic role — do not interchange. |

### Text field code pattern

```dart
TextField(
  decoration: InputDecoration(
    filled: true,
    fillColor: theme.colorScheme.surfaceContainerHighest,
    labelText: 'Email address',
    border: OutlineInputBorder(
      borderRadius: m3e.shapes.borderSmall,
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: m3e.shapes.borderSmall,
      borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
    ),
  ),
)
```

---

## Feedback and status

| Design intent | Flutter widget | Repo widget | Evidence | Notes |
|---|---|---|---|---|
| Progress — indeterminate | `CircularProgressIndicator`, `LinearProgressIndicator` | — | E2 | Use for unknown durations. Color: `colorScheme.primary`. |
| Progress — determinate | `CircularProgressIndicator(value:)`, `LinearProgressIndicator(value:)` | — | E2 | Show percentage when known. |
| Loading indicator (M3E spinner) | Compose with `CircularProgressIndicator` | — | E1 | M3E may specify an updated spinner; verify against source. |
| Error state | Inline error text, `errorText` on `InputDecoration`, error dialog | — | E2 | Use `colorScheme.error` and `colorScheme.onError`. |
| Success / confirmation | `SnackBar` with icon, `AlertDialog` | — | E2 | Transient: snackbar. Blocking: dialog. |
| Divider | `Divider`, `VerticalDivider` | — | E2 | Use spacing first; divider only for meaningful content boundaries. |

---

## Layout composition

| Layout pattern | Flutter approach | Repo widget | Evidence | Notes |
|---|---|---|---|---|
| Single-column content | `Column` + `SingleChildScrollView` | — | E2 | Compact default. Max width: full. |
| List-detail (master-detail) | `LayoutBuilder` + `Row` split | — | E2 | Show list + detail pane at ≥720dp. |
| Supporting pane | `Row` with `Flexible` children | — | E2 | Primary content + contextual side pane. |
| Responsive adaptive scaffold | `LayoutBuilder` + Nav widgets | `M3EAdaptiveScaffold` | E3 | See navigation section. |
| Masonry / staggered grid | `flutter_staggered_grid_view` (community) | — | E4 | Third-party; verify maintenance and compatibility before adopting. |

### List-detail pattern

```dart
LayoutBuilder(builder: (context, constraints) {
  final isWide = constraints.maxWidth >= 720;
  return Row(
    children: [
      if (isWide)
        SizedBox(
          width: 360,
          child: _ListPanel(
            onItemSelected: (item) => setState(() => _selected = item),
          ),
        ),
      Expanded(child: _DetailPanel(item: _selected)),
    ],
  );
})
```

---

## Expressive visual emphasis

These are M3E-specific patterns. Use deliberately — one per screen section, not as background decoration.

| Expressive intent | Approach | Notes |
|---|---|---|
| Hero achievement / reward | `ShapeDecoration` using a verified shape border | Select a supported shape and content treatment for the target app. |
| Promotional / discount tag | `ShapeDecoration` using a verified shape border | Confirm the shape taxonomy and role in an applicable source. |
| App icon / avatar | Platform-appropriate image shape or `ShapeDecoration` | Do not infer platform app-icon requirements from a shape name. |
| Featured card accent | `m3e.shapes.roundedRectangle.toBorder()` | Large radius (24–28dp) on `surfaceContainerLow` |
| Category filter chip | `ChoiceChip` + custom shape | `m3e.shapes.borderFull` (pill) |
| Security / trust indicator | `ShapeDecoration` using a verified shape border | Use semantic color roles and a non-color status cue. |

```dart
// Repository shape definitions expose ShapeBorder conversion.
// The repository does not provide an M3E CustomClipper.
DecoratedBox(
  decoration: ShapeDecoration(
    color: theme.colorScheme.primaryContainer,
    shape: m3e.shapes.clover4Leaf.toBorder(),
  ),
  child: Padding(
    padding: m3e.spacing.all16,
    child: Icon(
      Icons.emoji_events_rounded,
      size: m3e.spacing.space32,
      color: theme.colorScheme.onPrimaryContainer,
    ),
  ),
)
```

---

## Accessibility requirements (all components)

These requirements apply to every widget in the matrix above without exception:

| Requirement | Implementation |
|---|---|
| Touch target | Follow the relevant platform guidance (Flutter cites 48×48 dp for Android and 44×44 pt for iOS); see [accessibility guidance](../foundations/accessibility.md). Verify any separate conformance requirements that apply to the mobile app. |
| Semantic label on icon-only controls | `IconButton(tooltip: ...)` or `Semantics(label: ..., child: ...)` |
| Text scaling | Never use fixed-height containers for text. Use `ConstrainedBox(minHeight:)` |
| Contrast | Use semantic `ColorScheme` pairs; verify custom overrides with a contrast checker |
| Focus traversal | Test with keyboard; ensure logical reading order via `FocusTraversalGroup` |
| Reduced motion | Wrap all animations with `MediaQuery.of(context).disableAnimations` check |
| RTL | Use `EdgeInsetsDirectional`, `TextDirection`-aware layout, test with `Directionality(textDirection: TextDirection.rtl)` |
| Screen reader | Test with TalkBack (Android) and VoiceOver (iOS); verify all announcements are meaningful |
