# Support and implementation matrix

Use the same status vocabulary as the [component coverage matrix](component-coverage.md) and [verification ledger](component-verification-ledger.md): **API verified** means an API exists in the recorded local Flutter SDK, not that it conforms visually to Material guidance; **Composition only** means the need is assembled from primitives rather than a dedicated widget; **No direct API** means no equivalent stock widget is asserted; **Platform-dependent** means actual target integration/rendering must be checked; **Unverified** means the behavior or evidence is incomplete.

## Foundation and capability

| Capability | Flutter baseline | M3 Expressive interpretation | Notes |
|---|---|---|---|
| Material 3 theming | **API verified** | Not equivalent to all M3E guidance | `ThemeData.useMaterial3`; verify the chosen SDK and source version. |
| Semantic colors | **API verified** | Map roles and verify schemes | `ColorScheme`; exact current M3E palette must be independently sourced. |
| Typography | **API verified** | Role mapping possible; exact E variants not assumed | `TextTheme`; test scaling and fonts. |
| Standard components | **API verified** per component | Per-component expressive status varies | Check the component verification ledger; no universal E variant claim. |
| Expressive shape morphing | **Composition only / unverified** | Potential component-specific need | Verify design source, accessibility, and performance. |
| Dynamic color | **Platform-dependent** | Optional; no universal support | Package/OS-specific; test fallback and contrast. |
| Responsive/adaptive UI | **API verified** for layout primitives; **Composition only** for app behavior | Application decision required | Use constraints and task context, not a presumed universal breakpoint. |
| Accessibility | **Platform-dependent** | Required quality criterion | Test actual assistive technologies and targets. |

## Target platforms

| Target | Flutter target | System/native integration | Input and layout validation | M3E fidelity claim |
|---|---|---|---|---|
| Android mobile | **Platform-dependent**; confirm current OS matrix | Android system UI and plugin-dependent | touch, system bars, back, IME, TalkBack, rotation, tablets, foldables, multi-window | Per-app verification |
| iOS mobile | **Platform-dependent**; confirm current OS matrix | iOS system UI and plugin-dependent | touch, safe areas, VoiceOver, Dynamic Type, orientation, iPad multitasking | Per-app verification |

## Platform behavioral adaptation matrix

This matrix documents the implementation questions that must be resolved before claiming a design is "Expressive" on a given target.

| Platform | Primary interaction model | Required validation | Typical risk pattern | Decision rule |
|---|---|---|---|---|
| Android mobile | touch + Android system UI + TalkBack | system bars, IME, back navigation, text/display scaling, rotation, tablets, foldables | content is obscured by insets or IME; layouts fail in split-screen or on foldables | follow Android navigation and safe-area behavior; validate on supported phone and large-screen devices |
| iOS mobile | touch + iOS system UI + VoiceOver | safe areas, Dynamic Type, navigation gestures, orientation, iPad multitasking | labels clip or navigation actions become unreachable as size classes change | respect iOS navigation and reading direction; validate on supported iPhone and iPad devices |

This matrix is deliberately qualitative and should be used alongside the [Android and iOS platform guides](../platforms/index.md) and the [visual checklist](../ai-agent-guide/validation-checklist.md). It does not claim universal or identical Material rendering across OS versions or device form factors.
