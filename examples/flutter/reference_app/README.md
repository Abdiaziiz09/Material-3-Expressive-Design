# Flutter reference example

This small app demonstrates Flutter Material 3 theming, system light/dark selection, and project-specific adaptive navigation for Android and iOS mobile layouts, including phones and tablets. It is a compilable reference for the documentation, not a claim of complete Material 3 Expressive fidelity.

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

These images are linked from Google-hosted Material pages and are not copied into the repository. No Android/iOS device screenshots of the sample app are published yet. Its committed widget-test goldens use a test font and are regression fixtures, not suitable visual references; see the [testing guide](../../../docs/flutter/testing.md) and [full visual-reference gallery](../../../docs/reference/visual-reference-gallery.md).

## Run and validate

```bash
flutter pub get
flutter devices
flutter run -d DEVICE_ID
flutter analyze
flutter test
```

Use `flutter devices` to find `DEVICE_ID`. iOS builds require Xcode on macOS. The example's navigation adapts at locally chosen width thresholds. Those values are implementation decisions for this sample, not Material breakpoint tokens. Replace them with project-specific, tested behavior in production. Validate on the Android and iOS versions and phone/tablet form factors your app supports.
