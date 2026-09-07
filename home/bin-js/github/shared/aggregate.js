import { writePRChart } from "./pr-chart.js";
import { since, sumCounts } from "../../shared/months.js";
import { fetchRepoPRCounts } from "./pr-counts.js";

/**
 * Sum PR counts across a list of repos and write one chart.
 * Repos that are archived or had no push in the chart window are skipped.
 * A repo that fails to fetch is reported and left out of the totals, and
 * the process exit code is set to 1 so the undercount is not silent.
 *
 * @param {object} args
 * @param {string} args.name        Chart subject, e.g. an org or user login
 * @param {Array<{ name: string, owner: { login: string }, archived: boolean, pushed_at: string | null }>} args.repos
 * @param {string} args.outputPath
 */
export async function writeAggregateChart({ name, repos, outputPath }) {
  console.log(`Found ${repos.length} total repositories.`);

  const activeRepos = repos.filter(
    (r) => !r.archived && r.pushed_at && new Date(r.pushed_at) >= since,
  );

  console.log(
    `Processing ${activeRepos.length} unarchived repositories active in the chart window...`,
  );

  const results = [];
  const failures = [];

  for (const { owner, name: repo } of activeRepos) {
    try {
      results.push(await fetchRepoPRCounts(owner.login, repo));
    } catch (err) {
      failures.push(`${owner.login}/${repo}`);
      console.warn(`Failed to process ${owner.login}/${repo}: ${err.message}`);
    }
  }

  await writePRChart({
    name,
    createdCounts: sumCounts(results.map((r) => r.createdCounts)),
    mergedCounts: sumCounts(results.map((r) => r.mergedCounts)),
    outputPath,
  });

  if (failures.length > 0) {
    console.warn(`\n${failures.length} repos were skipped, so totals are an undercount:`);
    for (const repo of failures) console.warn(`  ${repo}`);
    process.exitCode = 1;
  }
}
