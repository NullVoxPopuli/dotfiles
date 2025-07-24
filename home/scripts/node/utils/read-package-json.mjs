import { join } from 'node:path';
import { existsSync } from 'node:fs';
import { readFile } from 'node:fs/promises';

export async function readPackageJson(dir) {
  let packageJsonPath = join(dir, 'package.json');

  if (!existsSync(packageJsonPath)) return;

  let buffer = await readFile(packageJsonPath);
  let str = buffer.toString();
  let json = JSON.parse(str);

  return json;
}
