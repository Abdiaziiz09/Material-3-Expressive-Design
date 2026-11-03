# Android mobile

This guide covers Android phone, tablet, and foldable apps. Flutter renders Material widgets within its app surface; do not assume it automatically adopts every Android system or native Material implementation behavior.

- Follow Flutter's [Android setup](https://docs.flutter.dev/platform-integration/android) and target SDK guidance.
- Account for system bars, edge-to-edge behavior, display cutouts, keyboard/IME, back navigation, and lifecycle.
- Dynamic wallpaper color is OS-version dependent; verify API and plugin support, permissions, fallback, and contrast.
- Test touch, TalkBack, font/display scaling, rotation, multi-window, tablets, and foldables.
- Check app lifecycle and system UI configuration against the currently supported Android documentation.

For hinge, posture, and Android-only Flutter display-feature APIs, see the [foldable guide](foldables.md). Use Material guidance for shared component design and Android guidance for OS integration. Test on representative Android versions and phone/tablet/foldable form factors.
