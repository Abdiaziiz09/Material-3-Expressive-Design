# Instructions for AI coding agents

Use this repository as an independent implementation reference, not as an official specification or a guarantee of conformance.

## Agent-neutral usage

This file is the repository's canonical agent guidance, but agent products differ in which instruction files they discover automatically. Do not claim that Cursor, Continue, VS Code, or another agent will automatically load `AGENTS.md`. When an agent does not discover it, point the agent to this file or configure that agent's own instruction mechanism to reference it; keep the substantive shared guidance here rather than requiring a vendor-specific rules file.

Use the [component snippet catalog](docs/ai-agent-guide/component-snippets.md) as a map to the reference app's current implementations. Those widgets and examples are repository-authored implementation references, not official Google specifications or guaranteed M3E-conformant components. Inspect their source and verify their APIs against the target Flutter/package versions before reuse.

Write repository-authored documentation and agent instructions in English. Preserve the target application's requested user-facing language separately.

## Before changing UI

1. Read [scope and terminology](docs/getting-started/scope.md), [support matrix](docs/reference/support-matrix.md), and the applicable sections of this guide.
2. Identify the target as an Android or iOS Flutter mobile app, including its phone/tablet/foldable form factors, Flutter version, viewport/orientation behavior, touch and any supported external input, localization/RTL needs, and accessibility requirements. Web and desktop are out of scope for this repository.
3. Read the relevant foundation and component pages, then check their primary-source references and version notes.
4. Separate official M3 guidance from Flutter API facts and this repository's implementation recommendations.
5. For component scope and evidence status, consult the [38-entry inventory](docs/reference/m3e-master-component-inventory.csv), [source-evidence ledger](docs/reference/m3e-source-evidence-ledger.csv), and [Phase 0/1 audit](docs/reference/m3e-phase0-1-audit.md). Do not treat a listed API or a documentation-readiness score as proof of M3E conformance.

## Implementation rules

- Do not equate `useMaterial3: true` with full M3 Expressive implementation.
- Reuse Flutter Material widgets when verified behavior meets the requirement. Build custom widgets only for a documented gap.
- Do not ban Flutter's built-in Material widgets as a blanket rule. Select a built-in or repository component based on the verified requirement and evidence; the presence of a similarly named M3E component does not make it appropriate for every screen.
- Do not label a Flutter Material widget deprecated for M3E, or prohibit it, unless an applicable authoritative source says so. A baseline Material widget is not automatically M3E; identify its evidence and use it only when its verified behavior meets the requirement. If an explicit expressive requirement is unsupported, document the gap and the chosen fallback/custom composition rather than silently claiming parity or stopping unrelated work.
- Do not invent a repository M3E component where none exists. In particular, do not force navigation, card, or other component patterns into an app that does not need them; use a documented application-specific composition when there is a verified gap.
- Prefer semantic `ColorScheme` roles and theme configuration over scattered hard-coded colors.
- Do not invent design tokens, dimensions, timing, state behavior, or support claims. Label application-specific decisions.
- Respect text scaling, semantic labels, keyboard/focus behavior, contrast, pointer and touch input, responsive layouts, and RTL.
- Test relevant component states and each available target platform. Report what was not tested.
- Never claim full compliance without a defined scope, source evidence, and visual/accessibility validation.
- Before removing existing guidance or examples, identify the exact material and rationale for the maintainer and wait for approval; prefer precise evidence labels or corrections when removal is not necessary.

## Strict Token Enforcement (Zero Magic Numbers)

> [!IMPORTANT]
> **Strict Operational Rule**: AI agents and developers are **strictly forbidden** from writing raw numeric values ("Magic Numbers") for margins, paddings, layout bounds, border radii, or animation durations.
>
> Use the repository's named tokens via `context.m3e` or `M3EThemeExtension` for layout and styling parameters. These are project-defined values unless the token registry explicitly records authoritative Material evidence; do not present project tokens as official Material requirements.

1. **Spacing & Insets**:
   - Always use `context.m3e.spacing.*` tokens or predefined insets:
     - Spacing scale: `space4`, `space8`, `space12`, `space16`, `space24`, `space32`, `space48`, etc.
     - EdgeInsets helpers currently available: `all4`, `all8`, `all12`, `all16`, `all20`, `all24`, `all32`, `horizontal16`, `horizontal24`, `vertical8`, `vertical12`, `vertical16`, and named symmetric combinations.
2. **Shapes & Radii**:
   - Always use `context.m3e.shapes.*` tokens or named expressive shapes:
     - Standard radii: `shapes.radiusNone`, `shapes.radiusSmall` (8dp), `shapes.radiusMedium` (12dp), `shapes.radiusLarge` (16dp), `shapes.radiusExtraLarge` (28dp), `shapes.radiusFull` (9999dp).
     - Named expressive shapes: `shapes.clover4Leaf`, `shapes.squircle`, `shapes.burst`, `shapes.cookie9Sided`, `shapes.pill`, etc.
3. **Motion Physics**:
   - Always use `context.m3e.motion.*` spring simulations and standard durations:
     - Spatial transitions: `motion.createSpatialSpring()` (overshoot-enabled spring simulation).
     - Effect transitions: `motion.createEffectSpring()` (critically damped spring simulation).
     - Durations currently available: `motion.durationFast`, `durationMedium`, and `durationSlow`.

---

## Negative constraints and guardrails

The following are explicit non-goals and anti-patterns. If a requirement is not supported by a direct Material Design page, current Flutter API, or a clearly documented project decision, do not infer it.

- Do not assume a baseline Material 3 component is automatically an M3 Expressive component.
- Do not copy a component shape, elevation, or animation solely because it looks similar in a reference image; verify the source and platform API.
- Do not treat a screenshot resemblance, theme flag, or component family name as proof of matching anatomy, tokens, or motion.
- Do not claim a component "supports" a state that the current Flutter API or source page does not document unless you confirm it in the target SDK.
- Do not use hard-coded colors, radii, spacing, or timing values when a semantic theme or composition rule is available.
- Do not ignore large text, reduced-motion settings, keyboard focus, or RTL/localization as secondary concerns.
- Do not claim a design is fully compliant without recording the scope, tested target platforms, and unresolved risks.
- Do not recommend a deprecated or migration-sensitive API without documenting why it remains necessary for the supported SDK range.

---

## Error-Handling Scenarios & Compliant Resolutions

When generating or refactoring Flutter code, AI agents frequently encounter edge cases. Below are the 3 most common failure scenarios, their root causes, and their normative M3E-compliant resolutions.

### Scenario 1: Layout Pixel Overflow (`RenderFlex` Overflow)

**Root Cause**: Hard-coded column or row sizing without flexibility when rendered on compact screens or when an on-screen keyboard appears.

❌ **Non-Compliant Example**:
```dart
// BAD: Magic numbers and inflexible Column causes RenderFlex overflow on small viewports
Widget buildHeaderBad(BuildContext context) {
  return Container(
    height: 180, // Magic number
    padding: const EdgeInsets.all(16.0), // Magic number
    child: Row(
      children: [
        const Icon(Icons.star, size: 48),
        Container(width: 16), // Magic number
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Very Long Title That Overflows Mobile Viewports Rapidly',
                style: TextStyle(fontSize: 24)), // Non-semantic
            Text('Detailed description explaining the expressive item feature set.'),
          ],
        ),
      ],
    ),
  );
}
```

✅ **Compliant M3E Resolution**:
```dart
// GOOD: Responsive constraints, context.m3e tokens, and flexible text wrapping
Widget buildHeaderCompliant(BuildContext context) {
  final m3e = context.m3e;
  final theme = Theme.of(context);

  return LayoutBuilder(
    builder: (context, constraints) {
      return Container(
        padding: m3e.spacing.all16,
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerLow,
          borderRadius: m3e.shapes.borderLarge,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.star_rounded,
              size: m3e.spacing.space32,
              color: theme.colorScheme.primary,
            ),
            SizedBox(width: m3e.spacing.space16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Very Long Title That Wraps Correctly Across All Viewports',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: m3e.spacing.space4),
                  Text(
                    'Detailed description explaining the expressive item feature set.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
```

---

### Scenario 2: Text Truncation under Large Text Scaling

**Root Cause**: Fixed container heights or clipping containers that do not account for the larger text sizes available through platform accessibility settings. Flutter does not define 2.0x as a universal maximum; test the target platforms' supported large text settings. A 200% scale may be used as an additional project test scenario when applicable.

❌ **Non-Compliant Example**:
```dart
// BAD: Fixed container height truncates text when text scale > 1.2
Widget buildActionTileBad(BuildContext context, String title) {
  return Container(
    height: 52, // Fixed height causes vertical overflow when text is scaled
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Text(title, maxLines: 1), // Truncates or clips under large font settings
  );
}
```

✅ **Compliant M3E Resolution**:
```dart
// GOOD: Dynamic intrinsic height with minimum accessible tap targets and auto-wrap
Widget buildActionTileCompliant(BuildContext context, String title) {
  final m3e = context.m3e;
  final theme = Theme.of(context);

  return ConstrainedBox(
    constraints: BoxConstraints(
      minHeight: m3e.spacing.space48, // Project token; size tap targets for the target platform
    ),
    child: Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(
        horizontal: m3e.spacing.space16,
        vertical: m3e.spacing.space12,
      ),
      child: Text(
        title,
        style: theme.textTheme.labelLarge?.copyWith(
          color: theme.colorScheme.onSurface,
        ),
        softWrap: true, // Allows wrapping naturally under large text scaling
      ),
    ),
  );
}
```

---

### Scenario 3: Hit Target Boundary Clipping on Dense Controls

**Root Cause**: Shrinking buttons or interactive elements without preserving a usable activation area. Flutter's accessibility guidance cites platform recommendations of 48x48 dp for Android and 44x44 pt for iOS. Treat these as mobile-platform recommendations, not universal dimensions or WCAG conformance criteria; identify and test any accessibility standard required by the app separately.

❌ **Non-Compliant Example**:
```dart
// BAD: The target may be too small for comfortable touch activation
Widget buildSmallIconButtonBad(BuildContext context, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: const SizedBox(
      width: 28,
      height: 28,
      child: Icon(Icons.close, size: 16),
    ),
  );
}
```

✅ **Compliant M3E Resolution**:
```dart
// GOOD: Meets the Flutter/Android touch-target recommendation using project spacing tokens
Widget buildSmallIconButtonCompliant(BuildContext context, VoidCallback onTap) {
  final theme = Theme.of(context);
  final m3e = context.m3e;

  return IconButton(
    onPressed: onTap,
    iconSize: 20,
    visualDensity: VisualDensity.compact,
    style: IconButton.styleFrom(
      minimumSize: Size.square(m3e.spacing.space48),
      tapTargetSize: MaterialTapTargetSize.padded,
      foregroundColor: theme.colorScheme.onSurfaceVariant,
    ),
    icon: const Icon(Icons.close_rounded),
  );
}
```

---

## Sources and conflicts

Prefer current official Material guidance for design intent, Flutter API docs for Flutter behavior, and official platform docs for OS integration. Use the most specific applicable component/platform/version source. When authoritative sources conflict, state the discrepancy and avoid silently choosing a convenient claim. See [decision rules](docs/ai-agent-guide/design-decision-rules.md).

---

## Required completion note

Summarize files changed, platform/version tested, commands and actual outcomes, deviations or unsupported features, and remaining uncertainty. Follow [the implementation workflow](docs/ai-agent-guide/implementation-workflow.md).
