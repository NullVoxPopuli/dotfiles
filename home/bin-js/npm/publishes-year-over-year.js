/**
 * Chart npm activity across every package tagged with a keyword, this year
 * against last year. Defaults to the "ember-addon" keyword. Writes two charts:
 *
 *   npm_<keyword>_releases_per_month.png         releases across all packages
 *   npm_<keyword>_active_packages_per_month.png  packages with at least one release
 *   npm_<keyword>_downloads_per_month.png        downloads summed over all packages
 *
 * Usage: node publishes-year-over-year.js [keyword] [--cache-date YYYY-MM-DD|latest] [--exclude-scoped]
 *        KEYWORD=some-keyword node publishes-year-over-year.js
 *
 * The download counts for the current window are refetched once a day and
 * take a while under the API's rate limit. Pass `--cache-date latest` to
 * reuse the most recent day's data instead.
 *
 * `--exclude-scoped` leaves out "@scope/name" packages. Their downloads
 * must be fetched one request at a time, so this also makes a fresh run
 * many times faster. Output filenames gain an "_unscoped" suffix.
 */
import { COLORS, writeYearOverYearChart } from "../shared/chart.js";
import { parseCli } from "../shared/cli.js";
import { mapConcurrent } from "../shared/concurrency.js";
import { currentWindow, monthOf, since } from "../shared/months.js";
import { fetchDownloadTotals } from "./shared/downloads.js";
import { fetchReleaseTimes } from "./shared/release-times.js";
import { searchPackagesByKeyword } from "./shared/search.js";

const { target, values } = parseCli({
  cacheScope: "npm",
  options: { "exclude-scoped": { type: "boolean" } },
});
const keyword = target ?? process.env.KEYWORD ?? "ember-addon";
const excludeScoped = values["exclude-scoped"] ?? false;

const subject = `npm "${keyword}" packages${excludeScoped ? " (unscoped only)" : ""}`;
const outputPrefix = `npm_${keyword}${excludeScoped ? "_unscoped" : ""}`;

const CONCURRENCY = 8;
const PROGRESS_EVERY = 100;

const found = await searchPackagesByKeyword(keyword);
const allPackages = excludeScoped ? found.filter((pkg) => !pkg.name.startsWith("@")) : found;

if (excludeScoped) {
  console.log(`Excluding ${found.length - allPackages.length} scoped packages.`);
}

// A package can only have a release inside the chart windows if its registry
// document was modified inside them. Downloads, though, accrue to every package.
const packages = allPackages.filter((pkg) => pkg.modified >= since.getTime());

console.log(
  `Found ${allPackages.length} "${keyword}" packages, ${packages.length} modified since ${since.toISOString().slice(0, 10)}.`,
);

/** releases per month, across all packages */
const releaseCounts = {};
/** packages with at least one release that month */
const packageCounts = {};
const failures = [];
let processed = 0;

await mapConcurrent(packages, CONCURRENCY, async (pkg) => {
  try {
    const time = await fetchReleaseTimes(pkg);
    const monthsWithRelease = new Set();

    for (const iso of Object.values(time)) {
      if (new Date(iso) < since) continue;
      const month = monthOf(iso);
      releaseCounts[month] = (releaseCounts[month] ?? 0) + 1;
      monthsWithRelease.add(month);
    }

    for (const month of monthsWithRelease) {
      packageCounts[month] = (packageCounts[month] ?? 0) + 1;
    }
  } catch (err) {
    failures.push(pkg.name);
    console.warn(`Failed to process ${pkg.name}: ${err.message}`);
  }

  processed++;
  if (processed % PROGRESS_EVERY === 0 || processed === packages.length) {
    console.log(`  ${processed}/${packages.length} packages`);
  }
});

const downloads = await fetchDownloadTotals(allPackages.map((pkg) => pkg.name));
failures.push(...downloads.failures);

// Download data lags the calendar, so the estimate should count only the
// days that have data. If the last reported day is not in the current month
// yet, fall back to the chart's calendar default.
const thisMonth = currentWindow.at(-1);
const daysWithDownloadData = downloads.lastDayWithDownloads?.startsWith(thisMonth)
  ? Number(downloads.lastDayWithDownloads.slice(8))
  : undefined;

await Promise.all([
  writeYearOverYearChart({
    title: `${subject}: releases per month`,
    yAxisLabel: "Number of releases",
    series: [{ label: "Releases", rgb: COLORS.blue, counts: releaseCounts }],
    outputPath: `${outputPrefix}_releases_per_month.png`,
  }),
  writeYearOverYearChart({
    title: `${subject}: packages with a release per month`,
    yAxisLabel: "Number of packages",
    series: [{ label: "Active packages", rgb: COLORS.green, counts: packageCounts }],
    outputPath: `${outputPrefix}_active_packages_per_month.png`,
  }),
  writeYearOverYearChart({
    title: `${subject}: downloads per month`,
    yAxisLabel: "Downloads",
    series: [
      {
        label: "Downloads",
        rgb: COLORS.amber,
        counts: downloads.counts,
        daysElapsed: daysWithDownloadData,
      },
    ],
    outputPath: `${outputPrefix}_downloads_per_month.png`,
  }),
]);

if (failures.length > 0) {
  console.warn(`\n${failures.length} package lookups failed, so totals are an undercount:`);
  for (const name of failures) console.warn(`  ${name}`);
  process.exitCode = 1;
}
