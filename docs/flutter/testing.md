# Flutter testing and visual validation

Flutter's official testing guidance describes unit, widget, and integration testing: [Testing Flutter apps](https://docs.flutter.dev/testing). Use the least expensive test that meaningfully covers the behavior and add integration/visual checks for system-level concerns.

## Recommended layers

- **Unit:** pure transformations, validation, layout decisions, and state logic.
- **Widget:** component states, semantics, callbacks, keyboard focus, text scaling, and theme variants.
- **Integration:** navigation flows and platform integration on target devices.
- **Visual:** screenshots at representative sizes, themes, and text scales; review diffs rather than treating pixel equality as a design oracle.

Flutter widget-test goldens have an important rendering limitation: fallback glyphs use the Ahem test font, so text appears as block glyphs in the committed PNGs. Goldens can flag geometry, color, and layout regressions in this renderer, but they do not validate real glyph typography, Android/iOS device rendering, parity between the two mobile platforms, or M3 Expressive visual conformance. Visual inspection of these fixtures supports only that no obvious fixture geometry clipping was observed under this renderer.

## Example commands

```bash
flutter analyze
flutter test
flutter test integration_test
```

The integration command requires integration tests and appropriate devices to be configured. Do not report it as passed if it was not run.

Also run `python scripts/validate_docs.py`, `python scripts/validate_links.py`, and `mkdocs build --strict` for documentation changes. Document the host OS, Flutter version, Android/iOS device or simulator, test results, and known gaps.
