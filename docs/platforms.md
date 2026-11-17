# Android and iOS mobile

This repository covers Flutter apps on Android and iOS phones, tablets, and foldables. Flutter Material rendering is not identical to each operating system's native design implementation. Keep shared product intent while respecting platform navigation, accessibility, safe areas, and system integration.

## Android

- Follow current [Flutter Android setup](https://docs.flutter.dev/platform-integration/android) and target SDK requirements.
- Validate system bars/edge-to-edge, display cutouts, IME, back behavior, lifecycle, orientation, multi-window, and supported external input.
- Test TalkBack, font/display scaling, contrast, touch targets, and navigation on supported devices.
- Dynamic wallpaper color is Android-version and package/API dependent. Verify availability, permissions, fallback, and contrast; do not assume the same behavior on iOS.

## iOS

- Follow current [Flutter iOS setup](https://docs.flutter.dev/platform-integration/ios) and Apple's [Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/).
- Validate safe areas, status/home indicators, navigation gestures, system dialogs, keyboard/IME, and lifecycle.
- Test VoiceOver, Dynamic Type, contrast, orientation, and supported external keyboards on iPhone/iPad targets.
- Do not assume Android dynamic-color integration is available or equivalent on iOS.

## Tablets and foldables

Adapt to the app's actual available width and posture; do not merely scale a phone layout. A folded cover screen may need a compact composition, while an unfolded device may support a list/detail layout. These are app choices, not mandatory mappings or universal breakpoints.

- Recompose layouts as constraints/orientation change and preserve task state where the app architecture permits.
- Keep important controls and content away from obstructed hinge, fold, or cutout areas.
- Verify menus, dialogs, keyboard, focus, navigation, and large text across supported window sizes.
- Flutter `MediaQueryData.displayFeatures` is documented as Android-only. It is not a cross-platform hinge API and a missing feature list does not prove a device has no hinge.
- `DisplayFeatureSubScreen` is a focused layout aid, not a complete adaptive system. Check the API in the app's Flutter version.
- Treat iPad multitasking/resizing as available-space adaptation, not Android hinge/posture behavior.

## Device validation

Responsive behavior is required across every configuration the app claims to support. For each changed screen, identify the narrowest and widest supported available widths and test just below/at/above any app-specific layout breakpoint. Include orientation or window resizing, long/localized text and RTL, large text, keyboard/IME, and supported touch/keyboard/pointer input when relevant. Check that content remains reachable and there is no unintended overflow, clipping, or inaccessible action.

Record device/simulator, OS version, form factor, orientation, available size, locale, text settings, input mode, and accessibility tools used. Widget tests with varied constraints are useful but do not validate native permissions, OS behavior, fold posture, lifecycle, or actual screen-reader output.

If physical devices or simulators are unavailable, run the applicable layout/widget checks and clearly report that gap instead of claiming platform validation. Do not promise compatibility with every device; state the supported configurations and the ones actually tested.

## Platform sources

- Flutter [Android setup](https://docs.flutter.dev/platform-integration/android), [iOS setup](https://docs.flutter.dev/platform-integration/ios), and [adaptive/responsive guidance](https://docs.flutter.dev/ui/adaptive-responsive).
- Flutter [`MediaQueryData.displayFeatures`](https://api.flutter.dev/flutter/widgets/MediaQueryData/displayFeatures.html) and [`DisplayFeatureSubScreen`](https://api.flutter.dev/flutter/widgets/DisplayFeatureSubScreen-class.html).
- Android [foldable guidance](https://developer.android.com/develop/ui/compose/layouts/adaptive/foldables/learn-about-foldables); Compose-specific code is not Flutter API guidance.
- Apple [Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/).
