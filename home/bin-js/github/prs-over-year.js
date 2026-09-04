import { writeFileSync } from "node:fs";
import { Octokit } from "@octokit/rest";
import QuickChart from "quickchart-js";

const octokit = new Octokit({ auth: process.env.GITHUB_AUTH });

const [, , fromArgs] = process.argv;
const repoInput = fromArgs || process.env.REPO;

const [owner, repo] = (repoInput || "").split("/");

if (!owner || !repo) {
  console.error('Error: Provide a repository as "owner/repo" via REPO env var or CLI arg.');
  console.error(`  Received: ${repoInput}`);
  process.exit(1);
}

const oneYearAgo = new Date();
oneYearAgo.setFullYear(oneYearAgo.getFullYear() - 1);

async function getPRMonthlyCounts() {
  const createdCounts = {};
  const mergedCounts = {};

  // 1. Fetch created PRs in the last year (sorted desc by created)
  const createdPRs = await octokit.paginate(
    octokit.rest.pulls.list,
    {
      owner,
      repo,
      state: "all",
      sort: "created",
      direction: "desc",
      per_page: 100,
    },
    (response, done) => {
      const pagePRs = response.data;
      const lastPR = pagePRs[pagePRs.length - 1];
      if (lastPR && new Date(lastPR.created_at) < oneYearAgo) {
        done();
      }
      return pagePRs;
    },
  );

  for (const pr of createdPRs) {
    if (new Date(pr.created_at) >= oneYearAgo) {
      const month = pr.created_at.slice(0, 7);
      createdCounts[month] = (createdCounts[month] || 0) + 1;
    }
  }

  // 2. Fetch updated PRs (sorted desc by updated) to reliably capture recently merged PRs
  const updatedPRs = await octokit.paginate(
    octokit.rest.pulls.list,
    {
      owner,
      repo,
      state: "closed",
      sort: "updated",
      direction: "desc",
      per_page: 100,
    },
    (response, done) => {
      const pagePRs = response.data;
      const lastPR = pagePRs[pagePRs.length - 1];
      if (lastPR && new Date(lastPR.updated_at) < oneYearAgo) {
        done();
      }
      return pagePRs;
    },
  );

  for (const pr of updatedPRs) {
    if (pr.merged_at) {
      const mergedAt = new Date(pr.merged_at);
      if (mergedAt >= oneYearAgo) {
        const month = pr.merged_at.slice(0, 7);
        mergedCounts[month] = (mergedCounts[month] || 0) + 1;
      }
    }
  }

  const allMonths = Array.from(
    new Set([...Object.keys(createdCounts), ...Object.keys(mergedCounts)]),
  ).sort();

  return {
    labels: allMonths,
    createdData: allMonths.map((m) => createdCounts[m] || 0),
    mergedData: allMonths.map((m) => mergedCounts[m] || 0),
  };
}

async function generateChart() {
  const { labels, createdData, mergedData } = await getPRMonthlyCounts();

  if (labels.length === 0) {
    console.warn("No PR activity found in the last year.");
  }

  const chart = new QuickChart();
  chart.setVersion("4");
  chart.setHeight(1080);
  chart.setWidth(1920);
  chart.setBackgroundColor("#000000");
  chart.setConfig({
    type: "bar",
    data: {
      labels,
      datasets: [
        {
          label: "PRs Created",
          data: createdData,
          backgroundColor: "rgba(56, 189, 248, 0.75)",
          borderColor: "#38bdf8",
          borderWidth: 1,
        },
        {
          label: "PRs Merged",
          data: mergedData,
          backgroundColor: "rgba(74, 222, 128, 0.75)",
          borderColor: "#4ade80",
          borderWidth: 1,
        },
      ],
    },
    options: {
      plugins: {
        legend: {
          labels: {
            color: "#fff",
            font: { size: 36 },
            textStrokeColor: "#000000",
            textStrokeWidth: 3,
          },
        },
      },
      scales: {
        x: {
          title: {
            display: true,
            text: "Month",
            color: "#fff",
            textStrokeColor: "#000000",
            textStrokeWidth: 3,
            font: { size: 36 },
          },
          ticks: { color: "#9ca3af", font: { size: 24 } },
          grid: { color: "#1f2937" },
        },
        y: {
          title: {
            display: true,
            text: "Number of PRs",
            color: "#fff",
            textStrokeColor: "#000000",
            textStrokeWidth: 3,
            font: { size: 36 },
          },
          ticks: { color: "#9ca3af", font: { size: 24 } },
          grid: { color: "#1f2937" },
          beginAtZero: true,
        },
      },
    },
  });

  const imageBuffer = await chart.toBinary();
  writeFileSync(`${owner}_${repo}_prs_per_month.png`, imageBuffer);
}

generateChart();
