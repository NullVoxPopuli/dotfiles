import path from 'node:path';
import assert from 'node:assert';
import { stat } from 'node:fs/promises';


const ROOT = '/';

export async function findUp(name, options) {

  assert(name, `Must pass a name to findUp`);
  assert(options.from, `the from options is required when using findUp`);

  let directory = path.resolve(options.from);
  let isAbsolute = path.isAbsolute(name);

  assert(directory, `the from must be a valid directory`);
  assert(path.isAbsolute(options.from), `the from must be an absolute path. Received ${options.from}`);

  let stopAt = options.stopAt ?? ROOT;

  while (directory) {
    let filePath = isAbsolute ? name : path.join(directory, name);

    try {
      const stats = await stat(filePath);
      if (stats.isFile() || stats.isDirectory()) {
        return filePath;
      }
    } catch { }

    if (directory === stopAt || directory === ROOT) {
      break;
    }

    directory = path.dirname(directory);
  }

}
