import assert from 'node:assert';
import { getPackages } from '@manypkg/get-packages';
import { project } from 'ember-apply';
import { $ } from 'execa';
import { writeFile } from 'node:fs/promises';

async function getPipe() {
  let data = "";

  for await (const chunk of process.stdin) data += chunk;

  return data;
}

let stdin = await getPipe();

assert(stdin, `Expected piped text to be passed to this scirpt, but there was nothing. Usage: <other scirpt> | this-script`);



let repoRoot = await project.gitRoot();
let repoInfo = await getPackages(repoRoot);

let { stdout: hostname } = await $`hostname`

let result = stdin;

result = result.replaceAll(hostname, '<hostname>');

let count = 1;

for (let pkg of repoInfo.packages) {
  result = result.replaceAll(`"${pkg.relativeDir}/`, `"packages/pkg-${count}/`)
  result = result.replaceAll(`"${pkg.relativeDir}"`, `"packages/pkg-${count}"`)

  if (pkg.packageJson.name) {
    result = result.replaceAll(`"${pkg.packageJson.name}"`, `"pkg-${count}"`);
  }


  count++;
}

await writeFile('output.txt', result);

