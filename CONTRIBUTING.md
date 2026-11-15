# Contributing

Thank you for improving this independent reference. Submit focused changes that improve correctness, source traceability, accessibility, or practical implementation.

## Documentation standards

- Write all deliverables in English.
- Prefer official Material, Flutter, Android, Apple, W3C, and platform documentation. Link directly to the relevant page.
- Mark statements as official guidance, Flutter fact, or implementation recommendation when their authority could be confused.
- For APIs, include the canonical API page and the Flutter/Dart version checked. Do not infer API availability from a similar widget.
- Do not invent a token, component variant, measurement, animation curve, or platform capability. Say "not specified in the cited source" when applicable.
- Avoid copying source prose, images, or assets. Summarize in original words and respect upstream licenses.
- Keep one canonical page per topic and link to it elsewhere; update the compact navigation indexes when page locations change.

## Validation

Run `python scripts/validate_docs.py`, `python scripts/validate_links.py`, and `mkdocs build --strict` after installing `requirements.txt`. This repository has no runnable Flutter app; verify documented API examples against the target application's Flutter version and, when feasible, analyze and test copied snippets in that app. Record unavailable checks instead of claiming success.

## Proposing changes

Open an issue with the affected page, claim, source URL, and proposed correction. Pull requests should explain scope and platform/version implications. Please do not include proprietary content or credentials.
