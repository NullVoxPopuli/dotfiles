import fs from 'node:fs';
import path from 'node:path';
import { filesize } from 'filesize';
import { minify } from 'terser';
import { execa,  execaCommand, $ } from 'execa';

const options =  {
  parse: {
    html5_comments: false,
  },
  compress: true,
  output: {
    ecma: 2022,
    comments: false,
  },
};

const getSize = (file) => {
  const {size} = fs.statSync(file)
  return filesize(size)
}

const files = fs.globSync(path.join(process.cwd(), '/**/*.js'))

for (let file of files) {
  console.log(`Minifying ${file} (${getSize(file)})`)

  const terserResult = await minify(fs.readFileSync(file, 'utf8'), options)

  if (terserResult.error) {
    throw terserResult.error;
  }

  let min = `${file}.min`;
  let gz = `${min}.gz`;
  let br = `${min}.br`;

  fs.writeFileSync(min, terserResult.code, 'utf8');
  await execa({stdout: {file: gz}})`gzip -c ${min}`;
  await execa`brotli ${min} --quality=11 --output=${br}`;
}

/**
 * See sizes via:
 * ❯ du --depth 1 --reverse --apparent-size --no-percent-bars --filter ".js$" ember-composable-helpers/dist/
 * ❯ du --depth 1 --reverse --apparent-size --no-percent-bars --filter ".min$" ember-composable-helpers/dist/
 * ❯ du --depth 1 --reverse --apparent-size --no-percent-bars --filter ".gz$" ember-composable-helpers/dist/
 * ❯ du --depth 1 --reverse --apparent-size --no-percent-bars --filter ".br$" ember-composable-helpers/dist/
 *
 */
