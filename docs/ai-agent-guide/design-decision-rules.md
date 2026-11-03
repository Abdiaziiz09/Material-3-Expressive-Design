# Design decision rules

## Authority order

1. Current, relevant official Material component/foundation guidance for design intent.
2. Current Flutter API documentation/source for Flutter behavior and API availability.
3. Official Android/iOS and accessibility documentation for mobile OS behavior.
4. Reputable implementation references for examples, clearly marked non-normative.
5. Explicit project requirements and tested local decisions where upstream sources do not prescribe an answer.

This order is scoped, not absolute: Android or Apple documentation is authoritative for its mobile OS behavior, and Flutter's versioned API reference is authoritative for Flutter behavior.

## Resolve ambiguity

- Check date, version, platform, component, and whether the source is normative or illustrative.
- Prefer the most specific applicable source.
- If sources conflict, document the conflict and avoid making an unsupported universal claim.
- If details are absent, mark them unspecified and choose a labeled project decision.
- Verify API signatures in the exact app SDK before writing examples.
- Use community repositories as implementation evidence only; do not imply official endorsement.

## Evidence ledger

For every material decision record: requirement, source URL and relevant section, verification date/version, target platform, implementation mapping, and validation result.
