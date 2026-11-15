# Material 3 Expressive for Flutter

An independent, source-traceable guide for developers and AI coding agents building Flutter mobile interfaces informed by Material 3 Expressive (M3E). This repository is not an official Google/Flutter specification, a runtime package, a runnable app, or a conformance guarantee.

`ThemeData.useMaterial3: true` enables Flutter's Material 3 behavior; it does not prove complete M3E implementation. Verify design intent against current Material guidance and API behavior against the target application's Flutter SDK.

## Documentation

| Start here | Use it for |
|---|---|
| [Overview](docs/overview.md) | Scope, terminology, evidence labels, and repository map |
| [AI coding-agent guide](docs/agent-guide.md) | A reliable, agent-neutral implementation workflow |
| [Foundations](docs/foundations.md) | Color, typography, shape, spacing, motion, and accessibility |
| [Components](docs/components.md) | Component selection and Flutter starting points |
| [Flutter implementation](docs/flutter.md) | Theme, architecture, APIs, snippets, and validation |
| [Android and iOS](docs/platforms.md) | Platform integration, tablets, foldables, and testing |
| [Evidence and sources](docs/evidence.md) | Source hierarchy, limitations, and preserved research data |

Use the root [AGENTS.md](AGENTS.md) as a short routing guide. Agent tools differ in how instruction files are discovered; configure each tool to read the shared guide if necessary.

## Quick start

Before implementing a screen, inspect the target app's Flutter/Dart version, dependencies, existing conventions, supported platforms/form factors, localization, and accessibility requirements. Read the relevant pages above, verify APIs in the app's pinned SDK, and label unsupported details instead of guessing.

This repository contains no Flutter app to analyze or run. The optional [token example](docs/m3e_tokens.dart) is app-local sample code, not an installed API. See [Contributing](CONTRIBUTING.md) for documentation checks.

## Examples and evidence

The guides use text and Flutter code examples to show implementation patterns. Examples are starting points, not canonical M3E widgets; verify the design against current official Material guidance and APIs against the target application's Flutter SDK. See [Components](docs/components.md), [Foundations](docs/foundations.md), and [Evidence and sources](docs/evidence.md).
