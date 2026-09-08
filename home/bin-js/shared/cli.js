import { parseArgs } from "node:util";
import { setCacheDate } from "./cache.js";

/**
 * Parse `[target] [--cache-date <YYYY-MM-DD|latest>]` from argv.
 *
 * `--cache-date` (or the CACHE_DATE env var) makes the run read and write
 * that day's cache instead of today's, so a previous day's fetches can be
 * reused. "latest" picks the most recent earlier day with anything cached.
 *
 * @param {object} args
 * @param {string} args.cacheScope  cache subdirectory this script uses,
 *   e.g. "github" or "npm", so "latest" only considers its own entries
 * @param {object} [args.options]  extra `parseArgs` option definitions
 *   specific to the calling script
 * @returns {{ target: string | undefined, values: Record<string, unknown> }}
 *   the positional target, if given, and every parsed flag
 */
export function parseCli({ cacheScope, options = {} }) {
  const { values, positionals } = parseArgs({
    allowPositionals: true,
    options: { "cache-date": { type: "string" }, ...options },
  });

  const cacheDate = values["cache-date"] ?? process.env.CACHE_DATE;
  if (cacheDate) setCacheDate(cacheDate, { scope: cacheScope });

  return { target: positionals[0], values };
}
