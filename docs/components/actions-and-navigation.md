# Actions and navigation

For the checked Material source metadata, local Flutter API availability, state checklist, visual tests, and gaps for each row, see the [component verification ledger](../reference/component-verification-ledger.md).

| Design component | Flutter mapping (verify SDK API) | Expressive status and implementation note |
|---|---|---|
| Buttons | `FilledButton`, `OutlinedButton`, `TextButton`, `ElevatedButton` | Material button families exist; verify current M3E-specific variants, hierarchy, and state behavior in the [official buttons guidance](https://m3.material.io/components/buttons/overview). |
| Icon buttons | `IconButton`, `IconButton.filled`, `.filledTonal`, `.outlined` (availability is SDK-dependent) | Confirm constructor availability in the selected Flutter API. Provide semantic labels. [Official guide](https://m3.material.io/components/icon-buttons/overview). |
| FAB | `FloatingActionButton`, `FloatingActionButton.extended` | Standard Flutter mapping; expressive sizing/motion requirements need source verification. [Official guide](https://m3.material.io/components/floating-action-button/overview). |
| App bars/toolbars | `AppBar`, `SliverAppBar`, `Toolbar` patterns | Adapt actions and title placement to the mobile platform and available screen space. [App bars](https://m3.material.io/components/app-bars/overview). |
| Navigation bar | `NavigationBar` | Common phone mapping; choose based on mobile screen constraints, not platform name alone. [Guide](https://m3.material.io/components/navigation-bar/overview). |
| Navigation rail | `NavigationRail` | Often useful for larger widths; validate selection, labels, and keyboard use. [Guide](https://m3.material.io/components/navigation-rail/overview). |
| Navigation drawer | `NavigationDrawer`, `Drawer` | Verify modal/permanent behavior and responsive transitions. [Guide](https://m3.material.io/components/navigation-drawer/overview). |
| Tabs | `TabBar`, `TabBarView` | Use for peer content categories, not primary app navigation by default. [Guide](https://m3.material.io/components/tabs/overview). |

**States:** test enabled/disabled, selected where applicable, focus, pressed, loading if implemented, and external-keyboard behavior where supported. Check hover only if the mobile app supports a pointer. Do not claim a state or animation is required by Expressive without the component-specific source.

## Choosing among patterns

- Select a button style based on action priority and context; avoid multiple competing primary actions.
- Use an icon-only action only when its meaning is clear and its accessible name is supplied.
- Use a FAB for a contextually important creation/action when it is appropriate to the screen; it is not a mandatory element.
- Use tabs to switch peer views, and navigation components to move between app destinations.
- Choose among bar, rail, and drawer based on available space, content structure, and input mode. Any numerical threshold is a project decision unless the cited guidance specifies it.
- App bars and toolbars should preserve room for the page's actual task and should not overflow under localization or text scaling.

## Interaction and validation

Verify semantic labels, focus order, touch feedback, disabled behavior, and selected destination announcements; include external-keyboard or pointer behavior only when supported by the mobile app. Check destination labels and safe areas across phone/tablet sizes, orientation, and foldable postures. The official design pages provide component-specific anatomy; use them directly for measurements not recorded here.
