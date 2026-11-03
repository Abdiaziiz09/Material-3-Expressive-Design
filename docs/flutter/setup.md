# Flutter setup and version policy

This guide covers Flutter mobile apps for Android and iOS. Setup, plugins, OS behavior, and accessibility differ between the platforms. See [Flutter installation](https://docs.flutter.dev/get-started/install), [Android setup](https://docs.flutter.dev/platform-integration/android), and [iOS setup](https://docs.flutter.dev/platform-integration/ios).

## Requirements

- Use a currently supported stable Flutter release compatible with the app's dependencies and deployment targets.
- Record `flutter --version` in issue reports and validation results.
- Pin dependency constraints intentionally; do not copy version numbers from this documentation without checking pub.dev/API compatibility.
- Configure the Android SDK for Android builds and Xcode for iOS builds.

## Create and validate

```bash
flutter create my_app
cd my_app
flutter analyze
flutter test
```

Add Material theming only after checking [ThemeData configuration](theme-configuration.md). Build target setup instructions are maintained by Flutter and platform vendors; this repository does not replace them.
