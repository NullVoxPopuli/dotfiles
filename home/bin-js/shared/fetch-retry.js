import { setTimeout as sleep } from "node:timers/promises";

const RETRYABLE = new Set([429, 500, 502, 503, 504]);

/**
 * `fetch` that waits and retries on rate limiting and server errors.
 * Honors a Retry-After header when present, otherwise backs off
 * exponentially from one second. Resolves with the final response, which
 * may still be an error after the retries are spent.
 */
export async function fetchWithRetry(url, { retries = 6 } = {}) {
  for (let attempt = 0; ; attempt++) {
    const res = await fetch(url);

    if (!RETRYABLE.has(res.status) || attempt >= retries) {
      return res;
    }

    const retryAfter = Number(res.headers.get("retry-after"));
    const waitMs = retryAfter > 0 ? retryAfter * 1000 : 1000 * 2 ** attempt;

    await res.body?.cancel();
    await sleep(waitMs);
  }
}
