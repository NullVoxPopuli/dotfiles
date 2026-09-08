/**
 * Chart PRs created and merged per month for one repo over the last year.
 *
 * Usage: GITHUB_AUTH=token node prs-over-year.js owner/repo [--cache-date YYYY-MM-DD|latest]
 *        GITHUB_AUTH=token REPO=owner/repo node prs-over-year.js
 */
import { parseCli } from "../shared/cli.js";
import { writePRChart } from "./shared/pr-chart.js";
import { fetchRepoPRCounts } from "./shared/pr-counts.js";

const repoInput = parseCli({ cacheScope: "github" }).target ?? process.env.REPO ?? "";
const [owner, repo] = repoInput.split("/");

if (!owner || !repo) {
  console.error('Error: Provide a repository as "owner/repo" via REPO env var or CLI arg.');
  console.error(`  Received: ${repoInput}`);
  process.exit(1);
}

const { createdCounts, mergedCounts } = await fetchRepoPRCounts(owner, repo);

await writePRChart({
  name: `${owner}/${repo}`,
  createdCounts,
  mergedCounts,
  outputPath: `${owner}_${repo}_prs_per_month.png`,
});
