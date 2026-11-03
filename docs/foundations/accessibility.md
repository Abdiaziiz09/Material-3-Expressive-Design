# Accessibility

Accessibility is part of the interface specification, not a final polish pass. Follow Material's [building for all user needs](https://m3.material.io/foundations/building-for-all/user-needs) guidance, Flutter's [accessibility documentation](https://docs.flutter.dev/ui/accessibility-and-internationalization/accessibility), and any accessibility standards applicable to the mobile app.

- Use semantic controls and meaningful labels; test with platform screen readers.
- Preserve text scaling and avoid truncating essential information.
- Verify foreground/background contrast, including custom and dynamic colors.
- Make focus visible and keyboard navigation complete where supported, including when users connect an external keyboard.
- Support touch, pointer, keyboard, and switch/assistive input as relevant.
- Do not rely only on color, motion, or shape to convey state.
- Ensure dialogs, menus, sheets, and validation errors announce and manage focus correctly.

## Touch targets and conformance criteria

Flutter's accessibility guidance recommends sufficiently large tap targets and cites platform recommendations of at least 48x48 dp for Android and 44x44 pt for iOS. Use the applicable target-platform guidance rather than treating one platform's units as universal. Verify the effective hit region, including when the visible icon or shape is smaller.

Do not treat a platform touch-target recommendation as proof of standards conformance. Platform recommendations and any applicable conformance criteria have different scopes; verify the exact requirements for the mobile product rather than treating one dimension as universal.

## Large text testing

Flutter text responds to platform text-size settings, but layouts still need enough room for the resulting text. Test the largest relevant text settings on each target platform and check wrapping, scrolling, action reachability, and focus order. A 200% text-scale run can be included as an additional project-defined test scenario; it is not a universal maximum or a substitute for checking platform settings.

## RTL and localization verification rubric

For every component and screen, verify the following:

- Bidirectional text flows correctly in RTL locales without overlapping or reversed alignment errors.
- Icons, status indicators, and navigation affordances remain readable and do not depend on left/right assumptions.
- Text fields, menus, dialogs, and drawers place leading/trailing actions in the correct reading direction.
- Focus order remains logical when the layout is mirrored and the platform switches to RTL.
- Large text, dense translations, and long labels still fit the container without clipping or hidden actions.
- Contrast remains acceptable when the design uses a custom color role or a dynamic scheme.

## Minimum acceptance checklist

- Semantics are present and stable for each interactive element.
- Hit targets remain usable at the target text scale and device size.
- Keyboard navigation covers all interactive controls and dialogs.
- State feedback remains clear without color alone.
- Screen-reader output names the action and its purpose without ambiguity.
- Reduced-motion and high-contrast modes are tested where supported.

Platform accessibility conventions differ; see each platform guide and run manual assistive-technology checks.
