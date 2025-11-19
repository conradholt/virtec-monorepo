// index.js
const fs = require('fs').promises;
const { argv, env } = require('process');
const { WASI } = require('wasi');

async function main() {
  const wasi = new WASI({
//   version: 'preview1',
//   args: argv,
//   env,
//   preopens: {
//     '/sandbox': '/path/on/host',
//   },
  });
  const bytes = await fs.readFile(new URL('./hello.wasm', import.meta.url));
  // works in Node >=14 with --experimental-modules or with CommonJS use __dirname

  const { instance } = await WebAssembly.instantiate(bytes, wasi.getImportObject());
  const add = instance.exports.add;
  console.log("3 + 4 =", add(3,4));
}

main().catch(err => {
  console.error(err);
  process.exit(1);
});
