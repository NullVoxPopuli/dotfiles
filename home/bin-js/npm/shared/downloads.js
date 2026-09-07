import { readCache, writeCache } from "../../shared/cache.js";
import { mapConcurrent } from "../../shared/concurrency.js";
import { fetchWithRetry } from "../../shared/fetch-retry.js";
import { currentWindow, daysInMonth, monthOf, previousWindow } from "../../shared/months.js";

const API = "https://api.npmjs.org/downloads/range";

/** The bulk endpoint takes at most this many packages, and no scoped ones. */
const BULK_LIMIT = 128;
/** The API rate-limits aggressively; keep this low and let retries absorb the rest. */
const CONCURRENCY = 4;
const PROGRESS_EVERY = 25;

/** Inclusive YYYY-MM-DD range covering a window, capped at today. */
function rangeFor(window) {
  const first = window[0];
  const last = window.at(-1);
  const lastDay = `${last}-${String(daysInMonth(last)).padStart(2, "0")}`;
  const today = new Date().toISOString().slice(0, 10);

  return { start: `${first}-01`, end: lastDay < today ? lastDay : today };
}

/** Collapse one package's daily counts into monthly totals. */
function summarize(entry) {
  const monthly = {};
  let lastDayWithDownloads = null;

  for (const { day, downloads } of entry?.downloads ?? []) {
    if (downloads === 0) continue;
    const month = monthOf(day);
    monthly[month] = (monthly[month] ?? 0) + downloads;
    lastDayWithDownloads = day;
  }

  return { monthly, lastDayWithDownloads };
}

/** @returns {Promise<Record<string, object | null>>} API entry per package name; null if unknown */
async function fetchRange(range, names) {
  const res = await fetchWithRetry(`${API}/${range.start}:${range.end}/${names.join(",")}`);

  if (!res.ok) {
    throw new Error(`downloads API returned ${res.status}`);
  }

  const json = await res.json();
  return names.length === 1 ? { [names[0]]: json } : json;
}

function cachePathFor(range, name) {
  return `npm/downloads/${range.start}_${range.end}/${name.replace("/", "__")}.json`;
}

function describe(batch) {
  return batch.length === 1 ? batch[0] : `${batch.length} packages`;
}

/**
 * Monthly download totals across `names` for both chart windows.
 *
 * Cached per package per date range under `.cache/npm/downloads/`. The
 * previous window's range never changes, so it is fetched once. The current
 * window ends today, so its entries are refetched once a day.
 *
 * @param {string[]} names
 * @returns {Promise<{
 *   counts: Record<string, number>,
 *   lastDayWithDownloads: string | null,
 *   failures: string[],
 * }>} `lastDayWithDownloads` is the latest YYYY-MM-DD any package reported
 *   downloads for; the API usually lags the calendar by a day.
 */
export async function fetchDownloadTotals(names) {
  const counts = {};
  const failures = [];
  let lastDayWithDownloads = null;

  for (const window of [previousWindow, currentWindow]) {
    const range = rangeFor(window);
    const summaries = [];
    const missing = [];

    for (const name of names) {
      const cached = readCache(cachePathFor(range, name));
      if (cached) summaries.push(cached);
      else missing.push(name);
    }

    console.log(
      `Downloads ${range.start}..${range.end}: ${summaries.length} cached, ${missing.length} to fetch`,
    );

    const batches = [];
    const unscoped = missing.filter((name) => !name.startsWith("@"));
    const scoped = missing.filter((name) => name.startsWith("@"));

    for (let i = 0; i < unscoped.length; i += BULK_LIMIT) {
      batches.push(unscoped.slice(i, i + BULK_LIMIT));
    }
    for (const name of scoped) batches.push([name]);

    let done = 0;

    await mapConcurrent(batches, CONCURRENCY, async (batch) => {
      try {
        const byName = await fetchRange(range, batch);

        for (const name of batch) {
          const summary = summarize(byName[name]);
          writeCache(cachePathFor(range, name), summary);
          summaries.push(summary);
        }
      } catch (err) {
        failures.push(...batch);
        console.warn(`Failed downloads for ${describe(batch)}: ${err.message}`);
      }

      done++;
      if (done % PROGRESS_EVERY === 0 || done === batches.length) {
        console.log(`  ${done}/${batches.length} requests`);
      }
    });

    for (const { monthly, lastDayWithDownloads: lastDay } of summaries) {
      for (const [month, n] of Object.entries(monthly)) {
        counts[month] = (counts[month] ?? 0) + n;
      }
      if (lastDay && (!lastDayWithDownloads || lastDay > lastDayWithDownloads)) {
        lastDayWithDownloads = lastDay;
      }
    }
  }

  return { counts, lastDayWithDownloads, failures };
}
