import { ember, project, packageJson } from "ember-apply";
import { inspect } from "node:util";

let stats = {
  projects: {
    ember: {
      app: {
        "test-app": 0,
        "real-app": 0,
        embroider: 0,
        get total() {
          return this["test-app"] + this["real-app"];
        },
      },
      library: {
        v2: 0,
        v1: 0,
        get total() {
          return this.v1 + this.v2;
        },
      },
      get total() {
        return this.library.total + this.app.total;
      },
    },
    other: 0,
    get total() {
      return this.ember.total + this.other;
    },
  },
};

function containsEmbroider(manifest) {
  let deps = [
    ...Object.keys(manifest.devDependencies ?? {}),
    ...Object.keys(manifest.dependencies ?? {}),
  ];

  return (
    deps.includes("@embroider/webpack") || deps.includes("@embroider/vite")
  );
}

for await (let workspace of await project.eachWorkspace()) {
  let isEmber = await ember.isEmberProject();

  if (!isEmber) {
    stats.projects.other++;
    continue;
  }

  let manifest = await packageJson.read();
  let hasEmbroider = containsEmbroider(manifest);

  let isApp = await ember.isApp();

  if (isApp) {
    if (hasEmbroider) {
      stats.projects.ember.app.embroider++;
    }

    if (workspace.includes("/test-app")) {
      stats.projects.ember.app["test-app"]++;
      continue;
    }
    stats.projects.ember.app["real-app"]++;
    continue;
  }

  let isV2 = await ember.isV2Addon();

  if (isV2) {
    stats.projects.ember.library.v2++;
    continue;
  }
  stats.projects.ember.library.v1++;
}

console.log(
  inspect(stats, {
    depth: Infinity,
    colors: true,
    showProxy: true,
    showHidden: true,
    getters: true,
    numericSeparator: true,
  }),
);
