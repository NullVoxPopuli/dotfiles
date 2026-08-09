---
name: stripe-quota-work
description: "In-progress `stripe` branch (Aug 2026) — tiered plans + monthly link quotas; known rough edges"
metadata: 
  node_type: memory
  type: project
  originSessionId: b768c253-bcf8-40e8-a29d-a23c2d531b8a
  modified: 2026-08-09T13:20:56.431Z
---

As of 2026-08-09, branch `stripe` (uncommitted) replaces the binary free-vs-subscribed gate with **tiered plans + monthly link quotas**:

- `api/app/services/plans.ts`: hardcoded PLANS — side-hobby $1/15 links, hobby $5/100, project $15/1000; `NO_SUBSCRIPTION_PLAN` (5), `FREE_PLAN` (unlimited); `planForPriceId()`.
- `api/app/services/link_quota.ts`: `quotaForAccount()` counts links created this UTC month per account.
- Migration adds `(owned_by, created_at)` index on `links`.
- `actions/create.ts` gates on remaining quota (402 "Monthly link limit reached"); `actions/billing.ts` checkout takes a `plan` key, status returns plan/usage/availablePlans.
- Web: new `pricing` route/component, dashboard shows plan+usage, `dashboard.ts` service gains checkout/portal methods.

**Known rough edges found 2026-08-09** (verify still present before mentioning): billing.ts broken indentation; pricing.gts renders `${{plan.priceInCents}}` showing cents as dollars; `{{#if ...usage.remaining}}` treats 0 as "Unlimited"; link_quota.ts loads full rows instead of a COUNT query.

Related: [[url-shortener-stack]]
