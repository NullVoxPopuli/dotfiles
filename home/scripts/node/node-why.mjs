#!/usr/bin/env node

import module from 'node:module';
import assert from 'node:assert';
import path from 'node:path';
import fs from 'node:fs/promises';

const [,, ...args] = process.argv;
const depName = args[0];

assert(depName, 'You must provide a dependency name');

const require = module.createRequire(import.meta.url);
const pathOfDep = require.resolve(depName, {
  paths: [
    process.cwd(),
  ]
});

async function getVersion() {
  const pathParts = pathOfDep.split('/');

  let tailNodeModulesIndex;
  // backwards iteration, yay!
  for (let i = pathParts.length - 1; i > 0; i--) {
    let segment = pathParts[i];

    if (segment === 'node_modules') {
      tailNodeModulesIndex = i;
      break;
    }
  }

  if (!tailNodeModulesIndex) {
    return;
  }

  let relevantParts = pathParts.slice(0, tailNodeModulesIndex + 2);
  let pathToDep = relevantParts.join('/');
  let packageJsonPath = path.join(pathToDep, 'package.json');
  let file = await fs.readFile(packageJsonPath);
  let manifest = JSON.parse(file.toString());

  return manifest.version;
}


let version;
try {
  version = await getVersion();
} catch (e) {
  console.error('oops');
  console.error(e.message);
}; 

let versionString = version ? `Which is @ ${version}` : '';

console.info(`
  Node resolves ${depName} to 
     ${pathOfDep}

     ${versionString}
`);


