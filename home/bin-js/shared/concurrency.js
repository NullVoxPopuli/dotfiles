/**
 * Like `Promise.all(items.map(fn))`, but with at most `limit` calls in
 * flight at once. Results keep the order of `items`.
 */
export async function mapConcurrent(items, limit, fn) {
  const results = new Array(items.length);
  let next = 0;

  async function worker() {
    while (next < items.length) {
      const index = next++;
      results[index] = await fn(items[index], index);
    }
  }

  const workers = Array.from({ length: Math.min(limit, items.length) }, worker);
  await Promise.all(workers);

  return results;
}
