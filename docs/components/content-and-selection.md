# Content, selection, and containment

For the checked Material source metadata, local Flutter API availability, state checklist, visual tests, and gaps for each row, see the [component verification ledger](../reference/component-verification-ledger.md).

| Design component | Flutter mapping | Implementation notes |
|---|---|---|
| Cards | `Card`, `Material`, custom composition | Use cards only where grouping or interaction hierarchy benefits; don't assume every card needs elevation. [Material cards](https://m3.material.io/components/cards/overview). |
| Lists | `ListTile`, `ListView`, custom rows | Preserve accessible row semantics and responsive density. [Lists](https://m3.material.io/components/lists/overview). |
| Chips | `Chip`, `InputChip`, `ChoiceChip`, `FilterChip`, `ActionChip` | Choose by selection/action semantics; verify selection state and label semantics. [Chips](https://m3.material.io/components/chips/overview). |
| Checkboxes/radio/switch | `Checkbox`, `Radio`, `Switch` | Use for the matching selection model; preserve labels and focus behavior. [Checkbox](https://m3.material.io/components/checkbox/overview), [radio](https://m3.material.io/components/radio-button/overview), [switch](https://m3.material.io/components/switch/overview). |
| Segmented controls | `SegmentedButton` | Check Flutter API and selection cardinality; the design source includes variants beyond simple toggles. [Guide](https://m3.material.io/components/segmented-buttons/overview). |
| Menus | `MenuAnchor`, `DropdownMenu`, `PopupMenuButton` | Prefer documented Flutter APIs appropriate to the interaction; check keyboard and focus handling. [Material menus](https://m3.material.io/components/menus/overview). |
| Carousel | `CarouselView` | API and behavior vary by Flutter release; check current API and accessibility. [Guide](https://m3.material.io/components/carousel/overview). |

Avoid nesting interactive controls without defined semantics and focus order. Test selected, unselected, disabled, focused, and pressed states when applicable; test hover only when the mobile app supports a pointer.

## Use and validation

- Use a card when it groups related content or provides a meaningful interactive surface; do not wrap every element in a card by default.
- Choose a chip by action/selection role. Expose selected state semantically and ensure users can identify the selected value without color alone.
- Use a list row to expose a clear primary label and optional supporting/action content. Keep the whole hit region and nested actions unambiguous.
- Checkbox supports independent choices, radio supports one choice in a group, and switch communicates an on/off setting; follow each component's official usage guidance.
- Test selection changes, disabled state, focus, supported external-keyboard operation, large text, and long/localized labels.
- On tablets and foldables, avoid stretched, overly dense content; use constraints and task-appropriate composition rather than a universal card width.
