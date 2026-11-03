# M3E Flutter Documentation — Phase 0 & 1 Review

**Review date:** 2026-10-24
**Repository reviewed:** https://github.com/Abdiaziiz09/Flutter-M3E-Design
**Scope:** rubric normalization, current evidence re-check, master component inventory, and source-evidence ledger.
**Status:** Integrated audit record. The report and its inventory/evidence artifacts are available in this repository; no GitHub commit or push is implied.

## Executive result

- **Audit-assessed readiness score: 57/100 (57%).** This is the score retained by this audit and is tied to the weighted rubric below; it has not been independently recalculated in this integration. The separately mentioned **68% is not reproducible** from the current repository or an available scorecard in this conversation; it must not be averaged with 57% or treated as an equivalent metric. If 68% was intended to mean topic breadth, label it separately and show its own denominator. Until then, treat it as an unverified estimate.
- **This is a documentation-readiness score, not an M3E conformance score.** The repository repeatedly disclaims full conformance, and the evidence below does not prove app-level M3E visual parity.
- **38 component rows** are now represented in the proposed master inventory. This count includes separate entries for Expressive-specific additions and overlapping baseline components where the mapping relationship itself is important (e.g., SegmentedButton vs connected button group).
- At the audit snapshot, the repository component matrix had **30 data rows** (including grouped families). During integration, the matrix was split to show the inventory's separately tracked app bars/toolbars, FAB variants, selection controls, and date/time pickers. The integrated matrix now has **38 data rows** matching the 38-entry inventory; this does not claim that all entries are fully specified.

## Phase 0 — normalized rubric

The following is the single authoritative scoring model for future comparisons. The score assesses whether the documentation lets an AI agent implement UI with little or no unsupported guessing.

| Dimension | Weight | Current score | Evidence-based rationale |
|---|---:|---:|---|
| Design principles, scope and terminology | 10 | 9 | Scope/terminology is clear; official intent vs implementation recommendation is separated. |
| Foundations and normative design tokens | 20 | 7 | Color/type/shape/elevation/spacing/motion are discussed, but no complete authoritative token registry is present. |
| Components, variants, properties and state contracts | 25 | 10 | Broad catalog, matrix and ledger exist; many entries only have metadata evidence and lack full anatomy/variants/tokens/state behavior. |
| Layout, navigation, responsiveness and platform coverage | 15 | 10 | All six platform guides and adaptive guidance exist; detailed thresholds/recipes and validation remain incomplete. |
| Flutter implementation, theming and reusable architecture | 10 | 6 | Setup/theme/examples are present, but sample is a Material 3 baseline rather than a complete M3E reference library. |
| Accessibility, motion, interaction and localization | 10 | 7 | Relevant topics/checklists exist; normative acceptance criteria and full test matrix are incomplete. |
| AI workflow, source provenance and validation | 10 | 8 | `AGENTS.md`, source catalog, matrix, ledger and scripts are strong; many source reviews remain metadata-level and tests were not run in this audit. |
| **Total** | **100** | **57** | **Retained normalized baseline** |

### Why 57% and 68% are not averaged

An average of two numbers with unknown or different denominators would create false precision. The 57% had the explicit weights above. The 68% has no traceable scorecard here, so it is not safe to claim it measures the same thing. If a future audit measures topic presence/breadth, use a separate metric with an explicit denominator and never present it as readiness/conformance.

## Phase 1 — evidence re-check

### Confirmed from the current repository

1. The repository's component ledger states that the 2026-10-24 Material check only confirmed HTTP 200, title and HTML description metadata, and **did not inspect full interactive pages, illustrations, exact dimensions, tokens, motion or all states**. That is the central evidence limitation. Source: [component verification ledger](component-verification-ledger.md).
2. The repo's SDK/API record reports Flutter 3.47.7 stable and Dart 3.13.5, but this audit did not run Flutter or independently examine the local source tree. API evidence is therefore labelled “reported by repository”, not “re-run independently”.
3. The component catalog itself states it is not a complete reproduction of Material's interactive specifications or a conformance guarantee. Source: [component catalog](component-coverage.md).
4. `llms-full.txt` is intentionally a concise entry file that points to canonical pages rather than a copied, full documentation bundle. This is sensible for freshness, but it means an AI agent given that file alone does not receive all normative content. Source: [llms-full.txt](https://github.com/Abdiaziiz09/Flutter-M3E-Design/blob/main/llms-full.txt).
5. Official Flutter documentation says that in Flutter 3.47 the standalone `material_ui` and `cupertino_ui` packages are available ahead of formal deprecation of in-framework libraries. The API/import strategy must be tied to the actual target Flutter/package version. Source: [Flutter decoupling migration guide](https://docs.flutter.dev/release/breaking-changes/material-ui-and-cupertino-ui).
6. Official Flutter issue #168813 enumerates M3E-specific new/updated components and style areas; button-group and button M3E proposals #184936 and #184937 are recorded as Backlog in the issue tracker at review time. This supports keeping “API exists” separate from “M3E behavior exists”. Sources: [umbrella issue](https://github.com/flutter/flutter/issues/168813), [button groups proposal](https://github.com/flutter/flutter/issues/184936), [buttons proposal](https://github.com/flutter/flutter/issues/184937).

### Evidence grade definitions

- **E0 — Listed/unverified:** URL/topic is listed, but this pass did not independently inspect the page.
- **E1 — Metadata-level:** title and purpose metadata, or repository-reported URL checks; not enough to specify anatomy/tokens/interaction.
- **E2 — API claim:** API existence or mapping is recorded by repository or official Flutter API docs; must be checked against the actual target SDK/package.
- **E3 — Full normative review:** official page visuals/text/variants/states/tokens reviewed and mapped to requirements.
- **E4 — Tested conformance evidence:** local implementation compared against E3 requirements across relevant themes/states/platforms and accessibility checks.

The current component ledger is predominantly **E1 + repository-reported E2/test records**. This audit does not upgrade a component to E3/E4 without evidence.

## Component inventory snapshot

**Scope reconciliation note:** the Flutter umbrella issue says “Fifteen new or updated components,” while the list rendered in the cited issue currently exposes 14 named entries (app bars, button groups, carousel, common buttons, extended FAB, FAB menu, FABs, icon buttons, loading indicator, navigation bar, navigation rail, progress indicators, split button, toolbars). This count discrepancy must be reconciled against the live Material catalog before freezing the final normative inventory.

| Classification | Rows | Meaning |
|---|---:|---|
| M3E updated | 9 | As classified in inventory; not a conformance result. |
| M3E new | 5 | As classified in inventory; not a conformance result. |
| M3 baseline / M3E status not established in this audit | 1 | As classified in inventory; not a conformance result. |
| M3 baseline / M3E update not confirmed | 21 | As classified in inventory; not a conformance result. |
| M3 baseline; relationship to M3E connected groups must be explicit | 1 | As classified in inventory; not a conformance result. |
| M3 baseline / M3E update not confirmed; expressive support needs review | 1 | As classified in inventory; not a conformance result. |

| **Total** | **38** | Master inventory entries. |

| Repository coverage status | Rows | Interpretation |
|---|---:|---|
| Mentioned in docs | 34 | Inventory coverage label, not spec completeness. |
| Partially represented | 3 | Inventory coverage label, not spec completeness. |
| No dedicated row | 1 | Inventory coverage label, not spec completeness. |


## High-impact gaps exposed in Phase 1

1. **Toolbars are an M3E-specific item but are only treated as a pattern**, not a separately specified component.
2. **Bottom app bar is absent as a dedicated inventory/ledger row** and needs source/API review before being marked covered.
3. **Button groups, split buttons, FAB menus and loading indicators are not equivalent to the nearest standard Flutter widgets.** They need standalone contracts and visual/interaction tests.
4. **Extended FAB and date-range picker deserve separate contract/test rows**, rather than being swallowed by a related family.
5. **`SegmentedButton` must not be treated as a one-to-one M3E connected button group.** The official Flutter proposal describes a distinction and new capabilities.
6. **The source catalog is honest but shallow:** current component evidence is mostly metadata-level. It cannot currently support exact design values or complete state claims.
7. **The SDK boundary is important:** repository's snapshot records Flutter 3.47.7 and an in-framework source path, while official Flutter docs now describe standalone `material_ui`/`cupertino_ui` packages. Future evidence must record which package/API path was actually tested.
8. **Testing evidence is fixture-level and incomplete.** Golden files use Ahem test font and do not prove actual typography, Android/iOS device rendering, native assistive technology, or M3E conformance (as the ledger itself acknowledges).

## Deliverables in this audit pack

- [Master component inventory (CSV)](m3e-master-component-inventory.csv) — component/family inventory with classification, repository coverage, mapping, priority and next action.
- [Master component inventory (JSON)](m3e-master-component-inventory.json) — the same 38 inventory entries in machine-readable JSON.
- [Source-evidence ledger (CSV)](m3e-source-evidence-ledger.csv) — one row per inventory entry with provenance, repository-reported SDK/API/test evidence, evidence grade and gaps.
- This file — Phase 0 rubric normalization and Phase 1 summary.

## Gate before Phase 2 (token registry/component contracts)

Do **not** start assigning exact token values or claiming component conformance until the following have been approved:

- Component inventory scope and duplicate/overlap decisions are approved.
- Every E1 source row either advances to E3 through direct official review, or is explicitly marked unavailable/unverified.
- The project selects and pins Flutter version plus `material_ui` vs in-framework API strategy.
- M3E-specific components have separate source-backed contracts, especially toolbar, button group, split button, FAB menu and loading indicator.
- No custom value is labelled official unless its source citation proves it; project decisions are recorded separately.

## References

- [Repository README](https://github.com/Abdiaziiz09/Flutter-M3E-Design/blob/main/README.md)
- [Component coverage matrix](component-coverage.md)
- [Component verification ledger](component-verification-ledger.md)
- [Official source catalog](official-sources.md)
- [AI agent rules](https://github.com/Abdiaziiz09/Flutter-M3E-Design/blob/main/AGENTS.md)
- [Flutter Material package decoupling](https://docs.flutter.dev/release/breaking-changes/material-ui-and-cupertino-ui)
- [Flutter M3E umbrella issue](https://github.com/flutter/flutter/issues/168813)
- [Flutter button groups proposal](https://github.com/flutter/flutter/issues/184936)
- [Flutter buttons proposal](https://github.com/flutter/flutter/issues/184937)
