# Implementation workflow for coding agents

1. **Read instructions:** root `AGENTS.md`, scope, support matrix, and relevant component/foundation pages.
2. **Establish target:** Android/iOS versions, phone/tablet/foldable form factors, Flutter version, orientation and available screen constraints, touch and any supported external input, localization/RTL, accessibility needs, and existing architecture.
3. **Extract requirements:** list official design requirements, Flutter facts, application requirements, and unknowns separately. Link sources.
4. **Check capability:** verify candidate widget constructors and properties in API docs for the selected SDK. Classify each requirement built-in, configurable, custom, platform-specific, or unverified.
   - For Flutter M3 Expressive work in the standalone `material_ui` package, consult Flutter's [component migration checklist](https://github.com/flutter/flutter/blob/master/docs/ecosystem/material_ui/Material-3-Expressive-component-migration-checklist.md). It describes incremental, component-level opt-in while keeping Material 3 as the default; verify the actual target package version and do not infer a global expressive theme or app requirement from the checklist.
5. **Design composition:** choose semantic color/type/surface roles, responsive structure, navigation, and interaction states. Mark local decisions explicitly.
6. **Implement:** reuse existing widgets and project patterns; add custom behavior only for documented gaps. Preserve accessibility and platform conventions.
7. **Test:** run analyzer, unit/widget/integration tests as applicable; inspect light/dark, input states, text scaling, RTL, resize, and target platform behavior.
8. **Review evidence:** compare against relevant official guidance and source assets. Record gaps and any inaccessible or ambiguous source.
9. **Report:** summarize files, decisions, sources, versions, executed commands and exact outcomes, visual/platform checks, and remaining limitations.

Keep this workflow portable across AI agents: rely on repository documentation and the project's actual files as the shared source of truth. Agent-specific instruction files may link to this workflow, but must not silently override its evidence, scope, or validation requirements.

If authoritative sources conflict, follow [decision rules](design-decision-rules.md). Do not fabricate confidence or convert an unverified behavior into a requirement.
