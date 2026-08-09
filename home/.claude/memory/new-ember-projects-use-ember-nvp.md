---
name: new-ember-projects-use-ember-nvp
description: New Ember projects (apps AND libraries) must be scaffolded with the ember.nvp project/generator
metadata:
  type: feedback
---

When the user starts any new Ember project — app or library — scaffold it with their **ember.nvp** project/generator, not `ember new`/`ember addon` or other starters.

**Why:** It's their own generator, pre-configured with their preferred setup (stated 2026-08-09).

**How to apply:** For any "new Ember app/library/addon" request, reach for ember.nvp first (check its README/usage at the time — likely github.com/NullVoxPopuli or universal-ember). Don't fall back to stock blueprints or [[nvp-oss-projects]]'s polaris-starter unless ember.nvp doesn't cover the case, and ask before substituting.

Related: [[who-is-nvp]], [[nvp-oss-projects]]
