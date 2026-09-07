import { readCache, writeCache } from "../../shared/cache.js";
import { fetchWithRetry } from "../../shared/fetch-retry.js";

/** Keys in a registry document's `time` map that are not versions. */
const NOT_A_VERSION = new Set(["created", "modified", "unpublished"]);

/**
 * Publish time of every version of one package, as `{ [version]: ISO }`.
 *
 * Cached indefinitely under `.cache/npm/packages/`. The search index's
 * `modified` timestamp is stored beside the data, and a cache entry is
 * reused only while the package has not been modified since. That makes
 * a full re-run cheap: only packages with new activity are refetched.
 *
 * @param {{ name: string, modified: number }} pkg  as returned by the search
 */
export async function fetchReleaseTimes({ name, modified }) {
  const cachePath = `npm/packages/${name.replace("/", "__")}.json`;
  const cached = readCache(cachePath);

  if (cached && cached.modified >= modified) {
    return cached.time;
  }

  const res = await fetchWithRetry(`https://registry.npmjs.org/${name}`);

  if (!res.ok) {
    throw new Error(`registry returned ${res.status} for ${name}`);
  }

  const doc = await res.json();
  const time = {};

  for (const [version, iso] of Object.entries(doc.time ?? {})) {
    if (!NOT_A_VERSION.has(version)) time[version] = iso;
  }

  writeCache(cachePath, { modified, time });

  return time;
}
