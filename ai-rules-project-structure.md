# Flutter project structure and coding guidance

This is a portable reference for Flutter projects. Adapt it to the target repository; it is not a mandatory architecture or a vendor-specific agent configuration. If an AI tool does not discover this file, configure that tool's own instruction mechanism to reference it.

## Principles

- Inspect the existing project before proposing structural changes.
- Preserve its established naming, architecture, dependencies, and test conventions unless there is a concrete, task-related reason to change them.
- Keep code near the feature that owns it. Introduce shared layers only when more than one feature genuinely needs them.
- Prefer straightforward, typed, testable code over a large generic architecture.
- Add dependencies only for demonstrated needs. BLoC, Riverpod, Provider, GetIt, GoRouter, and `Either`-style result types are alternatives, not requirements.
- Do not add empty directories or abstractions for hypothetical future features.

## Example for a growing app

```text
lib/
  app/
    app.dart
    theme/
    router.dart              # Only when routing needs a shared abstraction
  features/
    library/
      data/                  # External I/O and repositories, when needed
      domain/                # Reusable business rules, when needed
      application/           # Feature state/use-cases, if useful
      presentation/
        pages/
        widgets/
  shared/                    # Cross-feature code only; omit until needed
test/
  features/
    library/
```

This is an illustrative feature-oriented layout, not a Flutter standard. A small app may need only `lib/`, a few focused files, and `test/`. Do not create `data/domain/application` layers when a feature is simple enough to implement clearly without them. Match tests to behavior and mirror feature paths when practical.

## Code organization

- Keep widgets focused on rendering and user interaction; isolate domain rules and external I/O when complexity warrants it.
- Write idiomatic Dart and Flutter code for the target SDK. Follow the project's `analysis_options.yaml`, formatter, lints, and established naming. If the project has no conventions, follow the [Dart style guide](https://dart.dev/effective-dart/style) and format with `dart format`.
- Write code comments in clear, professional English, regardless of the conversation language or user-facing app locale.
- Add concise comments explaining the responsibility of each meaningful class, widget, and function. Use `///` for public API documentation, and explain non-obvious logic, constraints, and trade-offs near the relevant code.
- Keep comments accurate and update them when behavior changes. Do not comment every line or repeat what clear names and straightforward code already say.
- Put state in the target app's existing state-management pattern. Do not mix patterns in the same feature without a clear boundary.
- Use typed models, explicit failure/loading/empty states, and the project's existing error-reporting approach.
- Keep route definitions centralized only if the app benefits from it. Avoid adding a router package for a trivial navigation flow.
- Use shared design tokens/theme roles where they already exist; do not create an unverified M3E API or dependency.
- Preserve localization, RTL, semantics, focus behavior, and testability when reorganizing UI.

## When to add structure or tooling

Add a folder, layer, abstraction, or dependency only when it addresses a real concern such as repeated cross-feature behavior, complex state transitions, independently testable business logic, or multiple navigation flows. Explain the decision and keep the change proportional to the task.

Before introducing a library, check the app's dependency constraints, platform support, maintenance status, and existing alternatives. Confirm the selected API in the version actually pinned by the target application.
