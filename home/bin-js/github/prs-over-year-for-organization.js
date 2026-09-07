/**
 * Chart PRs created and merged per month across every repo in an org,
 * this year against last year.
 *
 * Usage: GITHUB_AUTH=token node prs-over-year-for-organization.js org-name
 *        GITHUB_AUTH=token ORG=org-name node prs-over-year-for-organization.js
 */
import { writeAggregateChart } from "./shared/aggregate.js";
import { octokit } from "./shared/octokit.js";

const [, , fromArgs] = process.argv;
const orgName = fromArgs ?? process.env.ORG;

if (!orgName) {
  console.error("Error: Provide a target GitHub Organization via ORG env var or CLI arg.");
  console.error("Usage: GITHUB_AUTH=your_token node prs-over-year-for-organization.js <org-name>");
  process.exit(1);
}

console.log(`Fetching repositories for organization: ${orgName}...`);

const repos = await octokit.paginate(octokit.rest.repos.listForOrg, {
  org: orgName,
  type: "all",
  per_page: 100,
});

await writeAggregateChart({
  name: orgName,
  repos,
  outputPath: `${orgName}_org_prs_per_month.png`,
});
