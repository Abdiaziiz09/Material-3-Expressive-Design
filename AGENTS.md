# Shared instructions for AI coding agents

This repository is an independent, documentation-only reference for Flutter mobile apps informed by Material 3 Expressive. It is not an official specification, a widget package, or a runnable app.

Agent products differ in which instruction files they discover. Do not claim that every tool automatically loads this file. Configure the target agent's own instruction mechanism to reference it when needed.

## Before changing UI

1. Read [the agent guide](docs/agent-guide.md), [overview](docs/overview.md), and the relevant sections of [foundations](docs/foundations.md), [components](docs/components.md), [Flutter implementation](docs/flutter.md), and [mobile platforms](docs/platforms.md).
2. Inspect the target app's Flutter/Dart version, dependencies, existing architecture, Android/iOS targets, form factors, input modes, localization, and accessibility requirements.
3. Check official Material sources for design intent and the target SDK for API facts. Label unsupported details as unknown or application-specific.
4. Follow existing project structure. Read [project-structure guidance](ai-rules-project-structure.md); do not introduce a prescribed architecture or package by default.

## Implementation rules

- `ThemeData.useMaterial3: true` does not prove complete M3 Expressive conformance.
- Reuse Flutter Material widgets when their verified behavior meets the task. Do not ban or prescribe a widget solely by family name.
- Never invent `m3d.design`, `context.m3e`, token accessors, widgets, imports, or packages. Use them only when their implementation exists in the target app or a declared dependency.
- Prefer semantic theme roles and existing app tokens. Do not pass project-defined values off as official Material tokens.
- Avoid unexplained layout, spacing, radius, and duration literals. Reuse named app tokens where available; document and centralize any genuinely shared new project value.
- Do not invent decorative treatments, custom shapes, or animations just because a task mentions M3 Expressive. Implement only requested behavior or behavior supported by verified, relevant design evidence; otherwise keep the simplest appropriate UI and flag meaningful assumptions.
- Do not add custom motion by default. For every custom animation, identify its specific widget, trigger/state change, user benefit, and verified Flutter API; if any are unclear or unjustified, omit it. Built-in Material interaction feedback may remain.
- Support text scaling, localization/RTL, semantics, focus, platform navigation, safe areas, and reduced motion where applicable.
- Surface failures using the target app's established error patterns. Avoid silent catches, success-shaped fallbacks, and unnecessary casts.
- Write idiomatic Dart/Flutter code and follow the target project's formatter and lints. Write code comments in clear, professional English. Add concise comments that explain the purpose of each meaningful class, widget, function, or non-obvious logic block; use `///` for public API documentation. Do not comment every line or repeat self-explanatory code. Keep comments accurate and maintained.
- Make focused changes, preserve unrelated work, and update directly related documentation/tests.

## Verification and completion

Run the smallest relevant checks in the target app and report exact commands/results. Test applicable Android/iOS targets and accessibility behaviors when available. Clearly state what was not tested; do not claim conformance from a theme flag, snippet, or automated test alone.

For changes to this repository, run:

```bash
python scripts/validate_docs.py
python scripts/validate_links.py
mkdocs build --strict
```

In the final summary state the files changed, versions/platforms checked, exact validation results, unsupported requirements, and remaining uncertainty.
