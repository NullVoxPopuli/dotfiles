import { Octokit } from "@octokit/rest";
import { throttling } from "@octokit/plugin-throttling";

const token = process.env.GITHUB_AUTH;

if (!token) {
  console.error("Error: set the GITHUB_AUTH env var to a GitHub token.");
  process.exit(1);
}

const ThrottledOctokit = Octokit.plugin(throttling);

const MAX_RETRIES = 3;

/**
 * Octokit client that waits and retries when GitHub applies
 * primary or secondary rate limits.
 */
export const octokit = new ThrottledOctokit({
  auth: token,
  throttle: {
    onRateLimit: (retryAfter, options, _octokit, retryCount) => {
      console.warn(
        `Rate limit hit for ${options.method} ${options.url}. Retrying in ${retryAfter}s.`,
      );
      return retryCount < MAX_RETRIES;
    },
    onSecondaryRateLimit: (retryAfter, options, _octokit, retryCount) => {
      console.warn(
        `Secondary rate limit hit for ${options.method} ${options.url}. Retrying in ${retryAfter}s.`,
      );
      return retryCount < MAX_RETRIES;
    },
  },
});
