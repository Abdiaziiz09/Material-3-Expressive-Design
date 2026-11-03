# Responsive and adaptive design

Flutter distinguishes responsive layout (fitting content into available space) and adaptive design (choosing an appropriate usable interaction/layout). Its [official guide](https://docs.flutter.dev/ui/adaptive-responsive) covers varied mobile screens and input types.

## Decision process

1. Read actual constraints and safe areas.
2. Preserve task hierarchy and content order.
3. Select navigation and composition based on available space and interaction context.
4. Reflow or adapt rather than simply scaling a phone layout.
5. Test phone and tablet screen constraints, orientation, foldable postures, iPad multitasking, and text scaling where applicable.

There is no single breakpoint that is correct for every application. If a project adopts thresholds, document them as project decisions unless a cited official source explicitly prescribes them.
