---
name: url-shortener-stack
description: "url-shortener repo — monorepo layout, stack (AdonisJS 7 api, Ember 7 web-client), dev setup"
metadata: 
  node_type: memory
  type: project
  originSessionId: b768c253-bcf8-40e8-a29d-a23c2d531b8a
  modified: 2026-08-09T22:45:33.435Z
---

pnpm monorepo (Node ^24): `api/` + `web-client/` + `packages/url-compression` (UUID→short-id base conversion).

- **api/**: AdonisJS 7, ESM subpath imports (`#controllers/*`, `#services/*`, …). Lucid ORM — Postgres in prod, better-sqlite3 for dev/test. GitHub OAuth via `@adonisjs/ally` + session guard; bouncer for policies. JSON:API responses (`ts-japi`, mimetype middleware), OpenAPI via `node ace swagger:generate` + Scalar on `docs.` subdomain. Stripe (`app/services/stripe*.ts`, webhook controller + dedupe). Rate limiting via `@adonisjs/limiter`. Tests: Japa (api/browser/unit; Playwright for browser).
- **web-client/**: Ember 7 (`ember-source ~7.3.0-alpha.5`), Embroider v2 + Vite, all-gts templates, `ember-scoped-css`, UI from `nvp.ui` + `ember-primitives`, data via `@warp-drive/*`. QUnit/testem configured but effectively no frontend tests yet.
- **web-client file-based routing (Aug 2026 refactor):** `app/routes/<name>/+route.ts` + `+template.gts`, globbed + remapped in `app.ts` (`customLayout`); non-`+` files in a route dir are co-located components (not globbed). Hierarchical layouts, NO conditional layout switching: `application/+template.gts` is minimal (`{{pageTitle}}` + `{{outlet}}`); marketing chrome is `routes/application/site-chrome.gts` used by `index`, `pricing`, and `auth/+template.gts`; `dashboard/+template.gts` = nvp.ui `ApplicationShell` (sidebar nav w/ Home+Dashboard) wrapping `{{outlet}}` — `dashboard/` is the logged-in section, pages go in `dashboard/<page>/`, overview at `dashboard/index/`. Preston corrected me for using `router.currentRouteName` conditionals — always use route nesting instead.
- Routes are subdomain-grouped in `api/start/routes.ts`: `api.` (v1 links CRUD + billing + stripe webhook), auth origin (`/_/auth/*`), `docs.`, apex (`GET /:id` redirect).
- **Testing (fixed 2026-08-09):** api = Japa (`node ace test unit functional`; browser suite = Playwright, slow). Apex-route specs must send `Host: DOMAIN` (routes are domain-scoped). web-client = qunit via the ember.nvp pattern: `pnpm test` = `build:test` (vite build) + `testem ci` DIRECTLY with `cwd: 'dist'` in testem.js (NOT `ember test` — nvp.ui lacks an addon-main so ember-cli can't boot); minimal tests/index.html (no content-for); test-helper mutates config (locationType 'none', rootElement, autoboot) before `setApplication` — config.ts itself stays clean. Use semantic selectors in rendering tests (ember-scoped-css rewrites class names).
- Dev needs `/etc/hosts` entries (`nvp.local`, `api.nvp.local`, `app.nvp.local`, `docs.nvp.local`) + apache2 vhosts (`api/config/apache2/install.sh`). `pnpm start` = api :5001 + web :5002. Prod domain: nvp.gg.
- Business rule: glimdown.com URLs are free (`glimdownOwner` in `api/app/consts.ts`).
- No CLAUDE.md in the repo.

Related: [[stripe-quota-work]], [[nvp-oss-projects]]
