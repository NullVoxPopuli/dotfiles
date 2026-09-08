import { existsSync, mkdirSync, readdirSync, readFileSync, writeFileSync } from "node:fs";
import { dirname, join } from "node:path";

/** On-disk JSON cache root: `home/bin-js/.cache/`, ignored by git. */
export const cacheRoot = join(import.meta.dirname, "../.cache");

/** Local calendar date, so a "day" of cache matches the clock on the wall. */
function localDate(d = new Date()) {
  const pad = (n) => String(n).padStart(2, "0");
  return `${d.getFullYear()}-${pad(d.getMonth() + 1)}-${pad(d.getDate())}`;
}

const today = localDate();
const DATE = /\d{4}-\d{2}-\d{2}/g;

let cacheDate = today;

/**
 * The date stamp used in cache keys. Defaults to today. Set it to an
 * earlier day to reuse that day's cache instead of refetching.
 */
export function getCacheDate() {
  return cacheDate;
}

/**
 * @param {string} value  "YYYY-MM-DD", or "latest" for the most recent day
 *   before today that has anything cached.
 * @param {object} [options]
 * @param {string} [options.scope]  subdirectory of the cache to look in for
 *   "latest", e.g. "npm", so another source's cache does not decide the date.
 */
export function setCacheDate(value, { scope = "" } = {}) {
  const resolved = value === "latest" ? latestCacheDate(scope) : value;

  if (value === "latest" && !resolved) {
    throw new Error(`No cache from a previous day found under ${join(cacheRoot, scope)}.`);
  }

  if (!/^\d{4}-\d{2}-\d{2}$/.test(resolved)) {
    throw new Error(`Invalid cache date "${value}". Use YYYY-MM-DD or "latest".`);
  }

  if (resolved !== today) {
    console.log(`Reusing cache from ${resolved}.`);
  }

  cacheDate = resolved;
}

/** Newest date stamp before today in cache paths under `scope`, or undefined. */
function latestCacheDate(scope) {
  const dates = [];

  const walk = (dir, depth) => {
    if (depth === 0 || !existsSync(dir)) return;

    for (const entry of readdirSync(dir, { withFileTypes: true })) {
      if (!entry.isDirectory()) continue;
      for (const match of entry.name.match(DATE) ?? []) {
        if (match < today) dates.push(match);
      }
      walk(join(dir, entry.name), depth - 1);
    }
  };

  walk(join(cacheRoot, scope), 3);

  return dates.sort().at(-1);
}

/** @returns {unknown | undefined} the parsed JSON at `relativePath`, or undefined if absent */
export function readCache(relativePath) {
  const path = join(cacheRoot, relativePath);
  if (!existsSync(path)) return undefined;
  return JSON.parse(readFileSync(path, "utf8"));
}

export function writeCache(relativePath, value) {
  const path = join(cacheRoot, relativePath);
  mkdirSync(dirname(path), { recursive: true });
  writeFileSync(path, JSON.stringify(value, null, 2));
}
