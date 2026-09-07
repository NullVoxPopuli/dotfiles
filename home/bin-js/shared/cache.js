import { existsSync, mkdirSync, readFileSync, writeFileSync } from "node:fs";
import { dirname, join } from "node:path";

/** On-disk JSON cache root: `home/bin-js/.cache/`, ignored by git. */
export const cacheRoot = join(import.meta.dirname, "../.cache");

export const todayStr = new Date().toISOString().slice(0, 10);

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
