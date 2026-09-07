import { writeFileSync } from "node:fs";
import QuickChart from "quickchart-js";
import {
  currentWindow,
  daysElapsedThisMonth,
  daysInMonth,
  monthAbbrev,
  previousWindow,
  windowTitle,
} from "./months.js";

const WHITE = "#ffffff";
const TITLE_FONT = { size: 32, weight: "bold" };
const TICK_FONT = { size: 24, weight: "bold" };
const GRID = { color: "#333333" };

/** "r, g, b" strings for series colors. Pass one as `rgb` in a series. */
export const COLORS = {
  blue: "56, 189, 248",
  green: "74, 222, 128",
  amber: "251, 191, 36",
  pink: "244, 114, 182",
};

const CURRENT_STYLE = {
  borderWidth: 6,
  pointRadius: 8,
  pointHoverRadius: 8,
};

const PREVIOUS_STYLE = {
  borderWidth: 4,
  borderDash: [14, 10],
  pointRadius: 5,
  pointHoverRadius: 5,
};

const SHARED_STYLE = {
  cubicInterpolationMode: "monotone",
  fill: false,
};

/*
 * The callbacks below run on QuickChart's side, so each must be
 * self-contained and cannot close over local variables. They read
 * `partialIndex`, a custom dataset property marking the in-progress month.
 */

/**
 * Show a label at the first point holding the series' highest complete
 * value, and at the estimated in-progress month.
 */
const atMaxOrEstimate = (ctx) => {
  if (ctx.dataIndex === ctx.dataset.partialIndex) return true;
  const complete = ctx.dataset.data.slice(0, ctx.dataset.partialIndex ?? undefined);
  return ctx.dataIndex === complete.indexOf(Math.max(...complete));
};

/** "28", "1,475.2", "78.8M": compact notation once the number gets long. */
const labelText = (value, ctx) => {
  const n =
    value >= 10000
      ? new Intl.NumberFormat("en-US", { notation: "compact", maximumFractionDigits: 1 }).format(
          value,
        )
      : value.toLocaleString("en-US");
  return ctx.dataIndex === ctx.dataset.partialIndex ? `est. ${n}` : `max ${n}`;
};

/**
 * Estimate labels go to the right of the last point, into the canvas padding.
 * A label on the first point also goes right, so it does not collide with
 * the y-axis ticks.
 */
const labelAlign = (ctx) =>
  ctx.dataIndex === ctx.dataset.partialIndex || ctx.dataIndex === 0 ? "right" : "top";

/** Dash the segment leading into the in-progress month. */
const dashIntoPartial = (ctx) =>
  ctx.p1DataIndex === ctx.chart.data.datasets[ctx.datasetIndex].partialIndex ? [8, 8] : undefined;

/**
 * Estimate where the in-progress month will land by blending two guesses:
 *
 *   historical = average of (same month last year, last month this year)
 *   pace       = count so far this month / days elapsed * days in the month
 *
 * The blend weight is the fraction of the month elapsed. Early in the month
 * the historical guess dominates because the pace guess is noisy. As days
 * pass, pace takes over, and on the last day it equals the real count.
 * The result never drops below the count already recorded this month.
 * Rounded to one decimal place.
 *
 * @param {number} [daysElapsed] days of the month the data covers. Defaults
 *   to the calendar; pass a smaller number when the source lags a day or two.
 */
function estimateCurrentMonth(counts, partialIndex, daysElapsed = daysElapsedThisMonth) {
  const thisMonth = currentWindow[partialIndex];
  const lastMonth = currentWindow[partialIndex - 1];
  const sameMonthLastYear = previousWindow[partialIndex];

  const soFar = counts[thisMonth] ?? 0;
  const totalDays = daysInMonth(thisMonth);
  const progress = daysElapsed / totalDays;

  const historical = ((counts[sameMonthLastYear] ?? 0) + (counts[lastMonth] ?? 0)) / 2;
  const pace = (soFar / daysElapsed) * totalDays;

  const blended = historical * (1 - progress) + pace * progress;

  return Math.round(Math.max(blended, soFar) * 10) / 10;
}

/**
 * @param {number} [partialIndex] index of a month still in progress. That point
 *   is plotted at an estimate, drawn hollow, reached by a dashed segment,
 *   labelled "est.", and left out of the max label.
 */
function dataset({ label, rgb, daysElapsed }, counts, window, style, alpha, partialIndex) {
  const color = `rgba(${rgb}, ${alpha})`;
  const data = window.map((m) => counts[m] ?? 0);

  if (partialIndex !== undefined) {
    data[partialIndex] = estimateCurrentMonth(counts, partialIndex, daysElapsed);
  }

  const result = {
    label: `${label} (${windowTitle(window)})`,
    data,
    borderColor: color,
    backgroundColor: color,
    ...SHARED_STYLE,
    ...style,
  };

  if (partialIndex !== undefined) {
    result.partialIndex = partialIndex;
    result.pointBackgroundColor = data.map((_, i) => (i === partialIndex ? "#000000" : color));
    result.pointBorderWidth = data.map((_, i) => (i === partialIndex ? 4 : 1));
    result.segment = { borderDash: dashIntoPartial };
  }

  return result;
}

/**
 * Render a 1920x1080 line chart of monthly counts, this year against last.
 * The current 12 months are solid lines. The 12 months before that are
 * dashed lines on the same month axis, for year-over-year comparison.
 * The current month is still in progress, so its point is hollow and
 * reached by a dashed segment. Each series' peak complete value is labelled.
 *
 * @param {object} args
 * @param {string} args.title        Chart title, e.g. "emberjs/ember.js: pull requests per month"
 * @param {string} args.yAxisLabel   e.g. "Number of PRs"
 * @param {Array<{ label: string, rgb: string, counts: Record<string, number>, daysElapsed?: number }>} args.series
 *   `counts` is keyed by "YYYY-MM" and should span both windows. `daysElapsed`
 *   is how many days of the current month the data covers, if not all so far.
 * @param {string} args.outputPath
 */
export async function writeYearOverYearChart({ title, yAxisLabel, series, outputPath }) {
  const datasets = [
    ...series.map((s) =>
      dataset(s, s.counts, currentWindow, CURRENT_STYLE, 1, currentWindow.length - 1),
    ),
    ...series.map((s) => dataset(s, s.counts, previousWindow, PREVIOUS_STYLE, 0.6)),
  ];

  if (datasets.every((d) => d.data.every((n) => n === 0))) {
    console.warn(`No data found for "${title}" in the last two years.`);
  }

  const chart = new QuickChart();
  chart.setVersion("4");
  chart.setHeight(1080);
  chart.setWidth(1920);
  chart.setBackgroundColor("#000000");

  chart.setConfig({
    type: "line",
    data: {
      labels: currentWindow.map(monthAbbrev),
      datasets,
    },
    options: {
      // Extra right padding keeps the "est." label on the last point inside the canvas.
      layout: { padding: { top: 40, left: 20, right: 200 } },
      plugins: {
        title: {
          display: true,
          text: title,
          color: WHITE,
          font: { size: 40, weight: "bold" },
          padding: { bottom: 10 },
        },
        legend: {
          labels: { color: WHITE, font: { size: 22, weight: "bold" }, boxWidth: 30, padding: 20 },
        },
        datalabels: {
          display: atMaxOrEstimate,
          align: labelAlign,
          anchor: "end",
          offset: 12,
          color: (ctx) => ctx.dataset.borderColor,
          font: { size: 28, weight: "bold" },
          formatter: labelText,
        },
      },
      scales: {
        x: {
          title: {
            display: true,
            text: "Month",
            color: WHITE,
            font: TITLE_FONT,
            padding: { top: 20 },
          },
          ticks: { color: WHITE, font: TICK_FONT },
          grid: GRID,
        },
        y: {
          title: {
            display: true,
            text: yAxisLabel,
            color: WHITE,
            font: TITLE_FONT,
            padding: { bottom: 20 },
          },
          ticks: { color: WHITE, font: TICK_FONT },
          grid: GRID,
          beginAtZero: true,
          // Headroom above the tallest point so the "max" label stays inside the plot.
          grace: "15%",
        },
      },
    },
  });

  writeFileSync(outputPath, await chart.toBinary());
  console.log(`Saved output to ${outputPath}`);
}
