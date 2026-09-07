import { readCache, todayStr, writeCache } from "../../shared/cache.js";
import { monthOf, since } from "../../shared/months.js";
import { octokit } from "./octokit.js";

/**
 * Cache entries live under `.cache/github/<YYYY-MM-DD>_since-<YYYY-MM>/`.
 * The window start is part of the path so a change to the window never
 * reuses stale data.
 */
const cacheDir = `github/${todayStr}_since-${since.toISOString().slice(0, 7)}`;

/**
 * Monthly created and merged PR counts for one repo over both chart windows.
 *
 * One request stream covers both metrics. PRs are listed newest-updated
 * first. A PR created or merged inside the window was also updated inside
 * the window, so paging stops once a page ends before `since`.
 *
 * @returns {Promise<{ createdCounts: Record<string, number>, mergedCounts: Record<string, number> }>}
 */
export async function fetchRepoPRCounts(owner, repo) {
  const cachePath = `${cacheDir}/${owner}__${repo}.json`;
  const cached = readCache(cachePath);

  if (cached) {
    console.log(`Loading cached data for ${owner}/${repo}`);
    return cached;
  }

  console.log(`Fetching live data for ${owner}/${repo}...`);

  const prs = await octokit.paginate(
    octokit.rest.pulls.list,
    {
      owner,
      repo,
      state: "all",
      sort: "updated",
      direction: "desc",
      per_page: 100,
    },
    (response, done) => {
      const inWindow = response.data.filter((pr) => new Date(pr.updated_at) >= since);

      if (inWindow.length < response.data.length) {
        done();
      }

      return inWindow;
    },
  );

  const createdCounts = {};
  const mergedCounts = {};

  for (const pr of prs) {
    if (new Date(pr.created_at) >= since) {
      const month = monthOf(pr.created_at);
      createdCounts[month] = (createdCounts[month] ?? 0) + 1;
    }

    if (pr.merged_at && new Date(pr.merged_at) >= since) {
      const month = monthOf(pr.merged_at);
      mergedCounts[month] = (mergedCounts[month] ?? 0) + 1;
    }
  }

  const repoData = { createdCounts, mergedCounts };

  writeCache(cachePath, repoData);

  return repoData;
}
