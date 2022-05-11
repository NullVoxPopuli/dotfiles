#!/usr/bin/node

/**
  * This script services as a quick way to show what I use.
  * The output isn't the prettiest, but it's good enough.
  */
import fs from 'fs/promises';
import path from 'path';
import { fileURLToPath } from 'url';

const ROOT = path.dirname(fileURLToPath(import.meta.url));

async function shellUtilities() {
  heading('Shell Utilities');

  let install = await getFile('./install.sh');
  let lines = install.split('\n');

  let apt = splitOnSpace(lines
    .filter(line => line.includes('apt install'))
    .map(line => line.replace('sudo apt install', ''))
  );

  let snap = splitOnSpace(lines
    .filter(line => line.includes('snap install'))
    .map(line => line.replace('sudo snap install', ''))
  );

  let python = splitOnSpace(lines
    .filter(line => line.includes('pip install') || line.includes('pip3 install'))
    .map(line => line.replace(/pip3? install( --user)?/, ''))
  );

  console.log({
    'apt packages': apt,
    'snap packages': snap,
    'python packages': python
  });
}

async function vimPlugins() {
  heading('neovim plugins');

  let pluginDir = path.join(ROOT, 'home', '.config', 'nvim', 'lua', 'plugins');
  let files = await fs.readdir(pluginDir);

  function getPluginNames(file) {
    let singleLine = (quote) => {
      return new RegExp(`use ${quote}([^${quote}]+)${quote}`, 'gm');
    };
    let singleLineWithBracket = (quote) => {
      return new RegExp(`use \{ ${quote}([^${quote}]+)${quote}`, 'gm');
    }
    let multiLine = (quote = `'`) => {
      return new RegExp(`^\\s*${quote}([^${quote}]+)${quote}\\s*,?$`, 'gm');
    };

    let matches = [
      ...file.matchAll(multiLine(`'`)),
      ...file.matchAll(multiLine(`"`)),
      ...file.matchAll(singleLine(`"`)),
      ...file.matchAll(singleLine(`'`)),
      ...file.matchAll(singleLineWithBracket(`'`)),
      ...file.matchAll(singleLineWithBracket(`'`)),
    ]
      .map(match => match[1])
      .filter(Boolean)
      .filter(match => match.includes('/'))
      .filter(match => match.replace(/\s\s/, ''))
      .filter(match => !match.includes(' -- '))
      .filter(match => !match.includes('~/'))
      .filter(match => !match.startsWith('/'))
      .filter(match => !match.startsWith('https:'))
      .filter(match => !match.startsWith('./'))
      .filter(Boolean);

    return matches;
  }

  for (let file of files) {
    let buffer = await fs.readFile(path.join(pluginDir, file));
    let fileData = buffer.toString();

    let plugins = getPluginNames(fileData);

    console.log(`>> ${file}`);
    console.log(plugins);
  }

  // concat all files into one.
  // because 'packer' is used, the ways in which packages are declared is uniform

}

function splitOnSpace(lines) {
  return [...(new Set(lines
    .map(line => line.replace('\\', ''))
    .map(line => line.trim())
    .map(line => line.split(' '))
    .flat()
    .filter(Boolean)
  )).values()];
}


function heading(title) {
  console.log('-------------------------------------------')
  console.log(`           ${title}`);
  console.log('-------------------------------------------')
}

async function getFile(filePath) {
  let buffer = await fs.readFile(path.join(ROOT, filePath));

  return buffer.toString();
}

async function main() {
  await shellUtilities();
  await vimPlugins();
}

main();
