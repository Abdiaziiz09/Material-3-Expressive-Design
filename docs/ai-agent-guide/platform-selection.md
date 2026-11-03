# Platform selection

This guide covers Android and iOS mobile apps only. Identify the supported phone, tablet, and foldable form factors before choosing components or navigation.

| Mobile target | Consider |
|---|---|
| Android phone | system bars and insets, back behavior, IME, display scaling, TalkBack, dynamic color only where supported |
| Android tablet/foldable | posture and hinge, orientation, split-screen/multi-window, navigation changes, large text; see [foldable guidance](../platforms/foldables.md) |
| iPhone | safe areas, platform navigation, VoiceOver, Dynamic Type, keyboard and system dialogs |
| iPad | safe areas, VoiceOver, Dynamic Type, orientation, multitasking and window resizing |

Treat this as a checklist, not a promise of feature support. Verify with Flutter's current [Android](https://docs.flutter.dev/platform-integration/android) and [iOS](https://docs.flutter.dev/platform-integration/ios) setup guides and the platform documentation.
