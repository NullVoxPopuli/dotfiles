import { getCacheDate, readCache, writeCache } from "../../shared/cache.js";

/**
 * The registry's own search endpoint cannot page past 5000 results and
 * ignores its filter qualifiers, so package discovery goes through the
 * Algolia "npm-search" index that npmjs.com and yarnpkg.com use. This is
 * the public, search-only key those sites ship in their front ends.
 */
const ALGOLIA = {
  appId: "OFCNCOG2CU",
  apiKey: "f54e21fa3a2a0160595bb058179bfb1e",
  index: "npm-search",
};

/** Algolia returns at most this many hits per query, however you page. */
const MAX_HITS = 1000;

const DAY_MS = 24 * 60 * 60 * 1000;

async function query(keyword, fromMs, toMs) {
  const params = new URLSearchParams({
    query: "",
    facetFilters: JSON.stringify([`keywords:${keyword}`]),
    numericFilters: JSON.stringify([`modified>=${fromMs}`, `modified<${toMs}`]),
    hitsPerPage: String(MAX_HITS),
    page: "0",
    attributesToRetrieve: JSON.stringify(["name", "modified"]),
  });

  const res = await fetch(
    `https://${ALGOLIA.appId}-dsn.algolia.net/1/indexes/${ALGOLIA.index}/query`,
    {
      method: "POST",
      headers: {
        "X-Algolia-Application-Id": ALGOLIA.appId,
        "X-Algolia-API-Key": ALGOLIA.apiKey,
        "Content-Type": "application/json",
      },
      body: JSON.stringify({ params: params.toString() }),
    },
  );

  if (!res.ok) {
    throw new Error(`Algolia search failed: ${res.status} ${await res.text()}`);
  }

  return res.json();
}

/**
 * Collect every package modified in [fromMs, toMs). When a range holds more
 * hits than one query can return, split it in half and recurse.
 */
async function collect(keyword, fromMs, toMs, into) {
  const { nbHits, hits } = await query(keyword, fromMs, toMs);

  if (nbHits <= MAX_HITS) {
    for (const hit of hits) into.set(hit.name, hit.modified);
    return;
  }

  if (toMs - fromMs < 1000) {
    throw new Error(`More than ${MAX_HITS} packages modified in the same second; cannot split.`);
  }

  const mid = Math.floor((fromMs + toMs) / 2);
  await collect(keyword, fromMs, mid, into);
  await collect(keyword, mid, toMs, into);
}

/**
 * Every npm package tagged with `keyword`, with the time its registry
 * document was last modified. Cached per day.
 *
 * @returns {Promise<Array<{ name: string, modified: number }>>} `modified` is a ms timestamp
 */
export async function searchPackagesByKeyword(keyword) {
  const cachePath = `npm/search/${getCacheDate()}/${keyword}.all.json`;
  const cached = readCache(cachePath);

  if (cached) {
    console.log(`Loading cached package list for "${keyword}"`);
    return cached;
  }

  console.log(`Searching npm for packages with keyword "${keyword}"...`);

  const found = new Map();
  await collect(keyword, 0, Date.now() + DAY_MS, found);

  const packages = [...found]
    .map(([name, modified]) => ({ name, modified }))
    .sort((a, b) => a.name.localeCompare(b.name));

  writeCache(cachePath, packages);

  return packages;
}
