/**
 * Every year-over-year chart compares two windows of 12 whole months each:
 *   - current:  the 12 months ending with this month
 *   - previous: the 12 months before that
 * Both windows start on the first of a month, so no bucket is partial
 * except the current month.
 */
const now = new Date();
const MONTHS_PER_WINDOW = 12;

function firstOfMonth(monthsAgo) {
  return new Date(Date.UTC(now.getUTCFullYear(), now.getUTCMonth() - monthsAgo, 1));
}

/** 12 consecutive "YYYY-MM" keys starting at `start`. */
function windowFrom(start) {
  const cursor = new Date(start);
  const keys = [];

  for (let i = 0; i < MONTHS_PER_WINDOW; i++) {
    keys.push(cursor.toISOString().slice(0, 7));
    cursor.setUTCMonth(cursor.getUTCMonth() + 1);
  }

  return keys;
}

export const currentWindow = windowFrom(firstOfMonth(MONTHS_PER_WINDOW - 1));
export const previousWindow = windowFrom(firstOfMonth(MONTHS_PER_WINDOW * 2 - 1));

/** Earliest instant any fetch needs to reach back to. */
export const since = firstOfMonth(MONTHS_PER_WINDOW * 2 - 1);

/** "YYYY-MM" for an ISO timestamp. GitHub timestamps are UTC. */
export function monthOf(isoTimestamp) {
  return isoTimestamp.slice(0, 7);
}

/** Days of the current month that have started, counting today. */
export const daysElapsedThisMonth = now.getUTCDate();

/** "2026-02" -> 28 */
export function daysInMonth(yearMonth) {
  const [year, month] = yearMonth.split("-").map(Number);
  return new Date(Date.UTC(year, month, 0)).getUTCDate();
}

/** "2026-03" -> "Mar" */
export function monthAbbrev(yearMonth) {
  const [year, month] = yearMonth.split("-").map(Number);
  return new Date(Date.UTC(year, month - 1, 1)).toLocaleString("en-US", {
    month: "short",
    timeZone: "UTC",
  });
}

/** ["2025-10", ..., "2026-09"] -> "Oct 2025–Sep 2026" */
export function windowTitle(window) {
  const first = window.at(0);
  const last = window.at(-1);
  return `${monthAbbrev(first)} ${first.slice(0, 4)}–${monthAbbrev(last)} ${last.slice(0, 4)}`;
}

/** Sum a list of `{ [month]: count }` objects into one. */
export function sumCounts(countsList) {
  const total = {};

  for (const counts of countsList) {
    for (const [month, count] of Object.entries(counts)) {
      total[month] = (total[month] ?? 0) + count;
    }
  }

  return total;
}
