/**
 * Chart PRs created and merged per month across every repo a user owns,
 * this year against last year.
 *
 * Usage: GITHUB_AUTH=token node prs-over-year-for-user.js username
 *        GITHUB_AUTH=token USER=username node prs-over-year-for-user.js
 */
import { writeAggregateChart } from "./shared/aggregate.js";
import { octokit } from "./shared/octokit.js";

const [, , fromArgs] = process.argv;
const username = fromArgs ?? process.env.USER_NAME;

if (!username) {
  console.error("Error: Provide a target GitHub user via USER_NAME env var or CLI arg.");
  console.error("Usage: GITHUB_AUTH=your_token node prs-over-year-for-user.js <username>");
  process.exit(1);
}

console.log(`Fetching repositories for user: ${username}...`);

// "owner" leaves out repos the user only collaborates on, which belong to
// someone else's chart.
const repos = await octokit.paginate(octokit.rest.repos.listForUser, {
  username,
  type: "owner",
  per_page: 100,
});

await writeAggregateChart({
  name: username,
  repos,
  outputPath: `${username}_user_prs_per_month.png`,
});
