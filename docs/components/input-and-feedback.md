# Input and feedback

For the checked Material source metadata, local Flutter API availability, state checklist, visual tests, and gaps for each row, see the [component verification ledger](../reference/component-verification-ledger.md).

| Design component | Flutter mapping | Implementation notes |
|---|---|---|
| Text fields | `TextField`, `TextFormField`, `InputDecoration` | Labels, errors, helper text, keyboard type, and validation must remain accessible. [Guide](https://m3.material.io/components/text-fields/overview). |
| Search | `SearchBar`, `SearchAnchor` | Validate filtering, empty/loading states, suggestions, and keyboard interaction. [Guide](https://m3.material.io/components/search/overview). |
| Slider | `Slider`, `RangeSlider` | Expose current value and keyboard/semantics behavior. [Guide](https://m3.material.io/components/sliders/overview). |
| Dialogs | `AlertDialog`, `Dialog`, `showDialog` | Manage focus, dismissal, and actions; adapt size to mobile screen constraints and content. [Guide](https://m3.material.io/components/dialogs/overview). |
| Bottom sheets | `BottomSheet`, `showModalBottomSheet` | Adapt sheet height, scrolling, and dismissal to mobile content and available screen space. [Guide](https://m3.material.io/components/bottom-sheets/overview). |
| Progress | `CircularProgressIndicator`, `LinearProgressIndicator` | Communicate determinate/indeterminate status semantically. [Guide](https://m3.material.io/components/progress-indicators/overview). |
| Loading indicator | Flutter `CircularProgressIndicator`; custom only if verified shape/motion differs | Do not claim an expressive loading indicator exists in Flutter Material by default. [Material reference](https://m3.material.io/components/loading-indicator/overview). |
| Snackbar | `ScaffoldMessenger`, `SnackBar` | Keep duration/actions and announcements usable; provide a persistent alternative for critical information. [Guide](https://m3.material.io/components/snackbar/overview). |
| Tooltip | `Tooltip` | Must not be the sole source for essential instructions; verify touch and semantics behavior. [Guide](https://m3.material.io/components/tooltips/overview). |
| Date picker | `showDatePicker`, `DatePickerDialog` | Verify locale, calendar conventions, date constraints, and platform expectations. [Guide](https://m3.material.io/components/date-pickers/overview). |

For each control, verify all relevant states and test validation, assistive technology, text scaling, touch input, and external-keyboard behavior where supported.

## Use and validation

- Associate labels and error messages with their fields; preserve input during correction and expose validation in semantics.
- Keep search query, suggestions, empty state, loading, and result selection understandable to keyboard and screen-reader users.
- Expose slider values and meaningful bounds, and do not use a slider where direct precise entry is the better control.
- Dialogs and sheets must have a clear dismissal/action model, focus handling, and a layout that fits the available phone/tablet screen.
- Use progress only when it communicates actual work; provide determinate progress where meaningful.
- Transient feedback must not be the only way users receive critical information; provide an accessible persistent status when needed.
- Verify picker localization, calendar conventions, allowed ranges, external-keyboard behavior where supported, and narrow-screen overflow.

Material component pages define design behavior; the Flutter widgets define implementation capabilities. Where those differ, document and test the gap rather than silently simulating compliance.
