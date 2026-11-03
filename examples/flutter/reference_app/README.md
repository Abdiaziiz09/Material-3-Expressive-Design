# Melo — Flutter mobile video music player

Melo is an English-language Flutter app for browsing videos saved in a device's photo library, watching them, or listening to their audio with the video hidden. It demonstrates a source-traceable Material 3 Expressive-inspired mobile interface; it is not an official Material specification or a claim of complete conformance.

The library and player use the repository's `M3EAppBar`, `M3ESegmentedList`, `M3EConnectedButtonGroup`, and theme tokens where they fit. Video playback, permission handling, and the audio-only presentation are app-specific compositions because the repository does not provide a complete media-player component. Standard Flutter Material controls remain in use where no matching M3E component is available.

## Permissions and privacy

- The app checks whether video-library access was already granted. It asks for permission only after the user selects **Allow video access**.
- Android requests video access only. Android 14+ selected-video access is supported; iOS limited-library access can be updated from the app.
- iOS explains the request in its system dialog: “Allow Melo to find and play videos from your library.”
- Melo reads videos locally and does not upload them. Search filters the videos currently loaded in the library; use **Load more videos** to continue through a large library.
- **Listen only** hides the video while it plays. Playback pauses when the app is backgrounded; background audio is not implemented.

The generated Android and iOS host projects are included because gallery permissions and local video playback require native mobile integration. iOS builds require Xcode on macOS.

## Run and validate

From this directory:

```bash
flutter pub get
flutter devices
flutter run -d DEVICE_ID
flutter analyze
flutter test
```

Video-library access and native playback should be checked on target Android and iOS devices. This environment has no physical mobile device; emulator and iOS validation results should be recorded separately.

## Design and visual references

## Visual references

These official Material images give AI coding agents and readers visual context for the design guidance. They are **design references**, not screenshots of this Flutter sample, Flutter API specifications, or proof of conformance. Follow each source page for context; do not infer exact tokens, dimensions, motion, or platform behavior from an image.

### Material 3 Expressive

[![Official Material 3 Expressive app and component examples](https://firebasestorage.googleapis.com/v0/b/design-spec/o/projects%2Fm3%2Fimages%2Fmoia5ltu-blog12.png?alt=media)](https://m3.material.io/blog/building-with-m3-expressive)

*Official Material example. [Read the source article](https://m3.material.io/blog/building-with-m3-expressive).*

### Buttons

[![Four button changes in the Expressive update](https://firebasestorage.googleapis.com/v0/b/design-spec/o/projects%2Fgoogle-material-3%2Fimages%2Fmmm1tos0-03.png?alt=media)](https://m3.material.io/components/buttons/overview)

*Official Material image. [Read the buttons guidance](https://m3.material.io/components/buttons/overview).*

### Navigation bar

[![Material 3 Expressive navigation bar compared with the baseline navigation bar](https://firebasestorage.googleapis.com/v0/b/design-spec/o/projects%2Fgoogle-material-3%2Fimages%2Fmae7qe43-02.png?alt=media)](https://m3.material.io/components/navigation-bar/overview)

*Official Material image. [Read the navigation bar guidance](https://m3.material.io/components/navigation-bar/overview).*

### Cards and chips

[![Three Material card variants](https://firebasestorage.googleapis.com/v0/b/design-spec/o/projects%2Fgoogle-material-3%2Fimages%2Flwuilyza-1.png?alt=media)](https://m3.material.io/components/cards/overview)

*Official Material card image. [Read the cards guidance](https://m3.material.io/components/cards/overview).*

[![Four Material chip variants](https://firebasestorage.googleapis.com/v0/b/design-spec/o/projects%2Fgoogle-material-3%2Fimages%2Flzthj7vk-1.png?alt=media)](https://m3.material.io/components/chips/overview)

*Official Material chip image. [Read the chips guidance](https://m3.material.io/components/chips/overview).*

These images are linked from Google-hosted Material pages and are not copied into the repository. Using the repository's widgets and project tokens is not proof of M3 Expressive conformance. See the [testing guide](../../../docs/flutter/testing.md) and [full visual-reference gallery](../../../docs/reference/visual-reference-gallery.md). Validate on the Android and iOS versions and phone/tablet form factors your app supports.
