import { COLORS, writeYearOverYearChart } from "../../shared/chart.js";

/**
 * Year-over-year chart of PRs created and merged per month.
 *
 * @param {object} args
 * @param {string} args.name  Chart subject, e.g. "emberjs/ember.js" or an org login
 * @param {Record<string, number>} args.createdCounts  keyed by "YYYY-MM", both windows
 * @param {Record<string, number>} args.mergedCounts   keyed by "YYYY-MM", both windows
 * @param {string} args.outputPath
 */
export function writePRChart({ name, createdCounts, mergedCounts, outputPath }) {
  return writeYearOverYearChart({
    title: `${name}: pull requests per month`,
    yAxisLabel: "Number of PRs",
    series: [
      { label: "Created", rgb: COLORS.blue, counts: createdCounts },
      { label: "Merged", rgb: COLORS.green, counts: mergedCounts },
    ],
    outputPath,
  });
}
