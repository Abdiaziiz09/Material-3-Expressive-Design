# Material 3 Expressive Flutter guide

This repository is an independent, documentation-only reference for developers and AI coding agents building Material 3 Expressive-informed Flutter mobile apps. It is not an official Google specification, a Flutter component package, or a runnable sample app.

## Start here

1. Read [Agent guide](agent-guide.md) before writing or changing UI.
2. Check [Scope and terminology](overview.md#scope-and-terminology).
3. Use [Foundations](foundations.md) for design principles and evidence-labeled example values.
4. Use [Components](components.md) to select components by task and verify their sources.
5. Use [Flutter implementation](flutter.md) and [Mobile platforms](platforms.md) for implementation checks.
6. Use [Evidence and sources](evidence.md) to distinguish verified evidence from historical audit records.

## Scope and terminology

Material 3 Expressive (M3E) is a design direction within Material 3, not a Flutter rendering mode or a guarantee that every Material component has an expressive variant. `ThemeData.useMaterial3: true` selects Flutter's Material 3 behavior; it does not establish M3E conformance.

This guide covers Flutter apps targeting **Android and iOS mobile**, including supported phones, tablets, foldables, and resized windows. Web and desktop implementation guidance is out of scope. Platform setup, input, accessibility, and integration must be verified for the target app.

Use the following evidence labels:

- **Material guidance** — supported by a cited official Material source.
- **Flutter fact** — supported by the selected Flutter SDK/API documentation.
- **Platform fact** — supported by Android, Apple, or applicable accessibility documentation.
- **Application choice** — a product-specific decision, not a universal requirement.
- **Unverified** — evidence is incomplete; do not state it as fact.

Keep design intent separate from Flutter API behavior and local implementation choices. Do not infer exact dimensions, timing, anatomy, or behavior from a screenshot or component name.

## Repository map

```text
AGENTS.md                         Shared repository instructions
ai-rules-project-structure.md     Flutter project-structure guidance
docs/
  overview.md                     Scope and terminology
  agent-guide.md                  Agent workflow and code-quality rules
  foundations.md                  Design foundations
  components.md                   Component mapping and examples
  flutter.md                      Flutter APIs, setup, themes, and testing
  platforms.md                    Android, iOS, and foldables
  evidence.md                     Sources, limitations, and audit data
  m3e_tokens.dart                 Optional, app-local token example
  m3e-master-component-inventory.csv
  m3e-master-component-inventory.json
  m3e-source-evidence-ledger.csv
```

The evidence files are historical research artifacts. They are not a live API inventory, current implementation, or proof of conformance.

## What this repository does not provide

- A Flutter application, pub package, or runtime design-token system.
- Custom M3E widgets, shape paths, spring helpers, or a universal breakpoint system.
- A prescribed state-management, routing, or dependency-injection library.
- A guarantee of conformance, SDK compatibility, or identical Android/iOS rendering.

For code tasks, inspect the target project's source tree, `pubspec.yaml`, lockfile, Flutter version, and existing conventions before implementation. Never invent imports or APIs such as `m3d.design` or a presumed `context.m3e` package. The optional token example works only if copied into the target project.

## Language and maintenance

Repository-authored documentation and agent instructions are written in English. Target-app user-facing language is determined by that app's requirements. See [Contributing](https://github.com/Abdiaziiz09/Flutter-M3E-Design/blob/main/CONTRIBUTING.md) for documentation standards and validation commands.
