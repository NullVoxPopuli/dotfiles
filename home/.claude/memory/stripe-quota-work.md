---
name: stripe-quota-work
description: "In-progress `stripe` branch (Aug 2026) — tiered plans + monthly link quotas; known rough edges"
metadata: 
  node_type: memory
  type: project
  originSessionId: b768c253-bcf8-40e8-a29d-a23c2d531b8a
  modified: 2026-08-09T13:57:25.582Z
---

As of 2026-08-09, branch `stripe` (uncommitted) replaces the binary free-vs-subscribed gate with **tiered plans + monthly link quotas**:

- `api/app/services/plans.ts`: hardcoded PLANS — side-hobby $1/15 links, hobby $5/100, project $15/1000; `NO_SUBSCRIPTION_PLAN` (5), `FREE_PLAN` (unlimited); `planForPriceId()`.
- `api/app/services/link_quota.ts`: `quotaForAccount()` counts links created this UTC month per account.
- Migration adds `(owned_by, created_at)` index on `links`.
- `actions/create.ts` gates on remaining quota (402 "Monthly link limit reached"); `actions/billing.ts` checkout takes a `plan` key, status returns plan/usage/availablePlans.
- Web: new `pricing` route/component, dashboard shows plan+usage, `dashboard.ts` service gains checkout/portal methods.

**Fixed 2026-08-09 (later session):** billing.ts misnested attributes (plan/usage/availablePlans were inside `stripe`); dashboard route never called `dashboard.refresh()`; `{{#if ...usage.remaining}}` treated 0 as "Unlimited". Dashboard component rewritten (usage meter, links table, billing-portal button). Also fixed: SSR home routes in `api/start/routes.ts` needed `.domain(DOMAIN)` — Adonis only falls back to domainless routes when NO registered domain matches the hostname.

**Still rough** (verify before mentioning): pricing.gts renders `${{plan.priceInCents}}` showing cents as dollars; link_quota.ts loads full rows instead of a COUNT query.

**Dev serving note:** user's commit 777180a (2026-08-09) made dev origins portless — Apache on :80 proxies `nvp.local`→api:5001, `app.nvp.local`→vite:5002. Browse the app at `http://app.nvp.local/` (no port), else CORS blocks `/_/auth/me` (allowlist is exact-match portless origins).

Related: [[url-shortener-stack]]
