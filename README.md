# Material 3 Expressive for Flutter

An independent, source-traceable guide for developers and AI coding agents building Flutter mobile interfaces informed by Material 3 Expressive (M3E). This repository is not an official Google/Flutter specification, a runtime package, a runnable app, or a conformance guarantee.

`ThemeData.useMaterial3: true` enables Flutter's Material 3 behavior; it does not prove complete M3E implementation. Verify design intent against current Material guidance and API behavior against the target application's Flutter SDK.

## Documentation

| Start here | Use it for |
|---|---|
| [Overview](docs/overview.md) | Scope, terminology, evidence labels, and repository map |
| [AI coding-agent guide](docs/agent-guide.md) | Agent-neutral implementation workflow |
| [Foundations](docs/foundations.md) | Design foundations and context-sensitive motion selection |
| [Components](docs/components.md) | Component selection and Flutter starting points |
| [Flutter implementation](docs/flutter.md) | SDK/API checks, architecture, animation APIs, and testing |
| [Android and iOS](docs/platforms.md) | Platform integration, tablets, foldables, and device validation |
| [Evidence and sources](docs/evidence.md) | Source hierarchy, limitations, and preserved research data |

Use the root [AGENTS.md](AGENTS.md) as a short routing guide. Agent tools differ in how instruction files are discovered; configure each tool to read it if necessary.

## Quick start

Before implementing a screen, inspect the target app's Flutter/Dart version, dependencies, existing conventions, supported platforms/form factors, localization, and accessibility requirements. Read the relevant pages above, verify APIs in the app's pinned SDK, and label unsupported details instead of guessing.

Choose motion for the particular widget, action, and state change. Spring, ripple, shape morphing, scale, and number-ticker effects are possible patterns, not a mandatory checklist. See [motion foundations](docs/foundations.md#motion) and [Flutter animation choices](docs/flutter.md#choosing-an-animation-api).

This repository contains no Flutter app to analyze or run. The optional [token example](docs/m3e_tokens.dart) contains app-local spacing and shape values, not an installed API. See [Contributing](CONTRIBUTING.md) for documentation checks.

## Validation

From the repository root:

```bash
python scripts/validate_docs.py
python scripts/validate_links.py
mkdocs build --strict
```

Flutter analysis, device testing, and accessibility validation must run in the target application and its actual SDK environment.
