# AI coding-agent guide

This guide is the shared, agent-neutral workflow for Flutter UI tasks. Product-specific instruction files may link here, but do not assume every agent automatically discovers `AGENTS.md` or this document. Configure an agent's own instruction mechanism when needed.

## Before coding

1. Read the root [AGENTS.md](https://github.com/Abdiaziiz09/Flutter-M3E-Design/blob/main/AGENTS.md), this guide, [Overview](overview.md), and the relevant sections of [Foundations](foundations.md), [Components](components.md), [Flutter](flutter.md), and [Platforms](platforms.md).
2. Inspect the target app: Flutter/Dart version, dependencies, architecture, existing widgets, test layout, Android/iOS deployment targets, supported form factors, localization, and accessibility requirements.
3. Write down the user task, official design requirements, verified Flutter behavior, app-specific decisions, and unknowns. Link evidence for design claims.
4. Check the target app's actual constructors, imports, and package versions. This docs repository has no executable widget library.
5. Keep the change scoped to the requested feature. Follow existing project structure unless there is a concrete reason to improve it.

## Professional Flutter structure

There is no single folder layout or state-management package suitable for every Flutter app. Prefer a feature-oriented structure when the app has multiple features; for a small app, start with fewer folders and add boundaries as complexity grows.

```text
lib/
  app/
    app.dart
    router.dart              # Only if the app needs a shared router
    theme/
  features/
    library/
      data/                  # Repositories and external I/O, when needed
      domain/                # Reusable business rules, when needed
      presentation/
        pages/
        widgets/
      application/           # Feature state/use-cases, if the architecture needs it
  shared/                    # Cross-feature code only; omit until needed
test/
  features/
    library/
```

Treat this as a scalable example, not a required scaffold. Avoid creating empty `core/constants/utils/widgets` directories or repeating `data/domain/presentation` layers for trivial features. Keep feature-specific code near its feature; promote code to `shared/` only when there is a real cross-feature use. Mirror production paths in tests where practical.

## Architecture and dependencies

- Preserve the app's established architecture. Do not migrate state management, routing, or dependency injection as an incidental part of a screen task.
- BLoC, Riverpod, Provider, GetIt, GoRouter, `Either`-style result types, and other libraries are options, not universal Flutter requirements. Use them only when already adopted or when a documented need justifies adding them.
- Do not add a package for a problem that can be solved clearly with existing Flutter APIs and the app's current dependencies.
- Keep UI, state transitions, and external I/O separated enough to test, without introducing layers that add no value.
- Use typed models and explicit loading, empty, success, and error states where relevant. Surface errors through the app's established logging and user-notification patterns; do not silently swallow them.

## Implementation rules

- Reuse existing code and established naming, formatting, localization, and theme patterns.
- Write idiomatic Dart and Flutter code for the target SDK. Follow the repository's `analysis_options.yaml`, configured formatter, lints, and naming patterns; where none are specified, use the [Dart style guide](https://dart.dev/effective-dart/style) and run `dart format`.
- Write code comments in clear, professional English, even when the surrounding conversation or user-facing app copy uses another language.
- Add concise comments that explain what each meaningful class, widget, or function is responsible for, and clarify non-obvious logic, constraints, or trade-offs. Use `///` for useful public API documentation.
- Keep comments near the code they describe, accurate, and updated when behavior changes. Do not comment every line or merely restate obvious code; names and types should make straightforward details clear.
- Use semantic `ColorScheme`, `TextTheme`, and target-app design tokens where available.
- Do not invent `m3d.design`, `context.m3e`, component classes, token accessors, or imports. They are available only if their implementations exist in the target app or a declared dependency.
- Do not present a baseline Material widget as M3E merely because `useMaterial3` is enabled. Also do not ban built-in widgets without component-specific evidence.
- Avoid unexplained layout, radius, or duration literals. Prefer the app's named tokens; label any new application-specific value and centralize it when it is genuinely shared.
- Support text scaling, RTL, semantics, focus, platform navigation, safe areas, and reduced motion where applicable.
- Prefer focused widgets and clear names. Use `const` when it improves correctness/performance and the constructor permits it; do not add keys without a state or identity need.
- Use typed callbacks and errors; avoid `dynamic`, broad catches, silent fallbacks, and unnecessary casts.

## Validate and report

Run the smallest relevant checks in the target app, typically:

```bash
flutter analyze
flutter test
```

Add integration, device, visual, or accessibility checks when the change affects those behaviors and the environment supports them. Do not report unrun checks as passed.

In the final report, state:

- Files changed and the purpose of each.
- Flutter/Dart and relevant dependency versions.
- Exact commands and outcomes.
- Platforms/devices checked, and what was not checked.
- Custom decisions, unsupported requirements, and remaining uncertainty.

No theme flag, snippet, screenshot comparison, or automated test alone proves M3E conformance.
