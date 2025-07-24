/**
 * Requires at least Node 22 as the default system node.
 *
 * Scans a whole disk for potentially vulnerable dependencies
 * and reports the likihood that found folders could be an issue.
 *
 * This is slow, because we have to check node_modules' contents.
 *
 * This script is not fool proof, but it will give you paths to investigate.
 * Either by comparing shas, or if that is compromised, 
 * you can just delete the path, and let the package manager (npm, pnpm, etc)
 * deal with it.
 *
 * Assumptions:
 * - there exists a folder with the matchig package name
 * - the code didn't already start executing
 *   - OR:
 *     - the executed code did not move itself
 * - we can't trust the version to be correct
 * - we can't trust a package.json to exist
 */

import { glob } from 'node:fs/promises';
import { dirname, join } from 'node:path';

import { readPackageJson } from './utils/read-package-json.mjs';
import { findUp } from './utils/find-up.mjs';

const CHECK_FOR = [
  { name: 'eslint-config-prettier', versions: ['8.10.0', '9.1.1', '10.1.6'] },
  { name: 'eslint-plugin-prettier', versions: ['4.2.2', '4.2.3'] },
  { name: 'synckit', versions: ['0.11.9'] },
  { name: '@pkgr/core', versions: ['0.2.8'] },
  { name: 'napi-postinstall', versions: ['0.3.1'] },
  { name: 'got-fetch', versions: ['5.1.11', '5.1.12'] },
];

/**
 * NOTE: this could be where folks hide malicious code. 
 *       This is for debugging only.
 */
const SKIPPED_DIRECTORIES = [];

const [_node, _thisScript, maybePath] = process.argv;

const within = maybePath ?? process.cwd();

console.log(`Searching within '${within}'`);

/**
 *
 *
 * Entrypoint here (called at bottom of file)
 *
 *
 */
async function main() {
  for await (const entry of glob('**/*.{js,cjs,mjs,ts,cts,mts,wasm}', { cwd: within })) {
    let absolute = join(within, entry);
    let check = looseMatchName(absolute);

    if (!check) continue;

    /**
     * Dedupe files within a package
     */
    let folderPath = await folderPathOfFile(absolute);

    // assert(folderPath, `Could not determine what *package* folder ${absolute} is in.`);

    if (!folderPath) continue;

    sus.because.folder(folderPath, { match: check });
  }

  for (let folder of sus.foldersToDiveDeeper) {
    let json = await readPackageJson(folder);

    if (!json) {
      sus.because.noPackageJson(folder);
      continue;
    }

    let check = isSusPackageJson(json);

    if (!check) continue;

    sus.because.exactMatch(folder, { match: check });
  }


  sus.report();
}

/**
 * Package names can only be one folder, or two if they're scoped
 *
 * But, we have to first crawl up to find the nearest node_modules directory
 *
 */
async function folderPathOfFile(filePath) {
  let nearestNodeModules = await findUp('node_modules', { from: dirname(filePath) });

  if (!nearestNodeModules) {
    // These could be very many false negatives
    sus.because.noNodeModules(filePath);
    return;
  }


  // If withoutPrefix matches filePath, then we probably have a symlink, in which case, we'll come across the file again a different way.
  let withoutPrefix = nearestNodeModules ? filePath.replace(nearestNodeModules, '') : filePath;
  if (withoutPrefix === filePath) {
    return;
  }

  let parts = withoutPrefix.split('/').filter(Boolean);
  let [nameOrScope, maybeName] = parts;

  let name = nameOrScope;
  if (name.startsWith('@')) {
    name += `/${maybeName}`;
  }


  let result = join(nearestNodeModules, name);

  if (result.endsWith('/home')) {
    console.log({ nearestNodeModules, withoutPrefix, filePath, name, nameOrScope, maybeName });
    process.exit(1);
  }

  return result;
}

/**
 * We don't match the version as well (here), because a malicious package
 * could lie about their version.
 */
function looseMatchName(entry) {
  let result = CHECK_FOR.find(check => entry.includes(check.name));

  return result;
}

function isSusPackageJson(json) {
  let result = CHECK_FOR.find(check => json.name === check.name);

  if (!result) return;

  if (result.versions.includes(json.version)) {
    return result;
  }
}


/**
 *
 * TODO tracking
 *
 */

class Sus {
  #folderMatches = new Map();
  #notInNodeModules = new Set();
  #exactMatch = new Map();
  #noPackageJson = new Set();

  because = {
    folder: (path, { match }) => this.#folderMatches.set(path, { folderPath: path, match }),
    noNodeModules: (path) => this.#notInNodeModules.add(path),
    exactMatch: (path, { match }) => this.#exactMatch.set(path, { folderPath: path, match }),
    noPackageJson: (path) => this.#noPackageJson.add(path),
  }

  get foldersToDiveDeeper() {
    return this.#folderMatches.keys();
  }


  report() {
    let didReport = false;
    if (this.#exactMatch.size > 0) {
      didReport = true;
      console.log('');
      console.log('Exact Matches: Reset your keys and delete these');
      console.log(this.#exactMatch)
    }

    if (this.#notInNodeModules.size > 0) {
      didReport = true;
      console.log('');
      console.log('Not in node_modules');
      console.log(this.#notInNodeModules)
    }

    if (this.#noPackageJson.size > 0) {
      didReport = true;
      console.log('');
      console.log('Potentially warrants further investigation');
      console.log('No package.json');
      console.log(this.#noPackageJson)
    }

    if (this.#folderMatches.size > 0) {
      didReport = true;
      console.log('');
      console.log('Potentially warrants further investigation');
      console.log('Folder Matches');
      console.log(this.#folderMatches)
    }

    if (!didReport) {
      console.log('Did not find anything');
    }
  }
}
const sus = new Sus();

/**
 *
 * 
 * Begin invocation
 *
 *
 */
main();
