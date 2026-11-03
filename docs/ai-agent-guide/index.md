# AI agent guide

Use the repository-root `AGENTS.md` before implementation. This guide is the operational reference for applying the repository as a complete M3E design-system reference. Its guidance is agent-neutral: use it with any AI coding agent, regardless of provider, model, editor, or agent-specific configuration format.

## Start here

**New to this repository?** Read in this order:

1. [`AGENTS.md`](https://github.com/Abdiaziiz09/Flutter-M3E-Design/blob/main/AGENTS.md) — mandatory rules and error-handling scenarios
2. [M3E quick-start](m3e-quick-start.md) — complete step-by-step workflow for AI agents
3. [Getting started: scope](../getting-started/scope.md) — what M3E is and what it is not
4. [Design token registry](../foundations/design-token-registry.md) — every token with value, accessor, and evidence grade
5. [Component decision matrix](../components/component-decision-matrix.md) — which widget to use for each design intent

## Reference pages

- [M3E quick-start](m3e-quick-start.md) — complete agent workflow with code patterns
- [Implementation workflow](implementation-workflow.md) — step-by-step process checklist
- [Design decision rules](design-decision-rules.md) — authority order and conflict resolution
- [Mobile platform selection](platform-selection.md) — Android and iOS phones, tablets, and foldables
- [Validation checklist](validation-checklist.md) — what to verify before submitting
- [Anti-patterns](anti-patterns.md) — what to avoid

## What agents must always report

Every implementation submission must include:

- Files changed and their purpose
- `flutter --version` output (exact)
- `material_ui` version from `pubspec.lock`, when the target project uses it
- Platforms tested with device/emulator names
- Actual output of `flutter analyze`, `flutter test`, `validate_docs.py`
- Confirmation that no magic numbers were used (or a list of labeled custom choices)
- Accessibility checks performed
- Known gaps, unverified items, and remaining limitations

Report the target project's actual versions and executed checks; do not assume the reference app's dependency versions or describe an unrun check as passed.

Do not infer full M3 Expressive compliance from a theme flag, screenshot resemblance, or a community package name alone.
