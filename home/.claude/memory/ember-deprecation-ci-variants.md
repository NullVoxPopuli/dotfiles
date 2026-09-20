---
name: ember-deprecation-ci-variants
description: "Adding a deprecation to ember.js requires running the CI deprecation-variant test jobs locally, or CI fails late"
metadata: 
  node_type: memory
  type: project
  originSessionId: 0a014eab-ea65-4f7f-a30c-ba0baccb7723
  modified: 2026-09-02T17:16:57.922Z
---

When adding a new deprecation to ember.js, run these two variants locally before
pushing — the default `pnpm test` passes while both of these fail:

- `ALL_DEPRECATIONS_ENABLED=true pnpm test` — forces deprecations whose `since`
  has no `enabled` key to actually fire, so any Ember test exercising the newly
  deprecated API fails with "Unexpected Ember.deprecate call".
- `OVERRIDE_DEPRECATION_VERSION=15.0.0 pnpm test` — makes `deprecateUntil`
  *throw* for anything with `until` below that version.

Each also has an `ENABLE_OPTIONAL_FEATURES=true` pairing in CI. All five need a
`npx vite build --mode development` first.

**Why:** these are separate CI jobs gated behind `basic-test`, so they land late
in the run and cost a full push/wait cycle to discover.

**How to apply:** when a deprecation makes Ember's own tests fail, prefer
pointing those tests at whatever internal/non-deprecating path the framework
itself uses, rather than blanket-skipping them with `testUnless(...isRemoved)` —
skipping silently drops behavioral coverage at the removal version. Reserve
`expectDeprecation` for tests that genuinely cover the deprecated surface.

Related: [[url-shortener-stack]] is unrelated; see [[who-is-nvp]] for context on
Ember core team work.
