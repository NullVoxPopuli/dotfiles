import fs from 'node:fs';
import path from 'node:path';
import { filesize } from 'filesize';
import { minify } from 'terser';
import { execa,  execaCommand, $ } from 'execa';

const [, , subPath] = process.argv;

const options =  {
  parse: {
    html5_comments: false,
  },
  compress: {
    ecma: 2022,
    passes: 6,
    toplevel: false,
    defaults: true,
    arguments: false,
    keep_fargs: false,
    toplevel: false,
    // Danger!
    unsafe: true,
    unsafe_comps: false,
    unsafe_math: true,
    unsafe_symbols: true,
    unsafe_proto: true,
    unsafe_undefined: true,
  },
  toplevel: false,
  output: {
    ecma: 2022,
    comments: false,
  },
};

const getSize = (file) => {
  const {size} = fs.statSync(file)
  return filesize(size)
}

const files = fs.globSync(path.join(process.cwd(), subPath || '.', '/**/*.js'))

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
 * Run via:
 * ❯ node ~/Development/NullVoxPopuli/dotfiles/home/bin-js/compress.js ./dist/ 
 *
 * See sizes via:
 * ❯ du --depth 1 --reverse --apparent-size --no-percent-bars --filter ".js$" ./dist/
 * ❯ du --depth 1 --reverse --apparent-size --no-percent-bars --filter ".min$" ./dist/
 * ❯ du --depth 1 --reverse --apparent-size --no-percent-bars --filter ".gz$" ./dist/
 * ❯ du --depth 1 --reverse --apparent-size --no-percent-bars --filter ".br$" ./dist/
 *
 */
