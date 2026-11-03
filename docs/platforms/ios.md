# iOS mobile

This guide covers iPhone and iPad apps. Flutter's Material widgets can be used on iOS, but system integration and user expectations differ from Android.

- Follow Flutter's [iOS setup](https://docs.flutter.dev/platform-integration/ios) and Apple's current Human Interface Guidelines.
- Check safe areas, status/home indicators, keyboard behavior, back/navigation affordances, and system dialogs.
- Dynamic color availability and integration are not equivalent to Android wallpaper color; verify the selected plugin/API and provide fallback.
- Test VoiceOver, Dynamic Type/text scaling, supported external keyboards, orientation, and iPad multitasking/resizing.
- Make an intentional choice between Material-styled controls and platform-native integration; do not mix conventions unpredictably.

Validate on physical iPhone/iPad devices or simulators running iOS versions supported by the application.
