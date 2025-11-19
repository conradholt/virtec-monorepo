// index.js
const fs = require('fs').promises;

async function main() {
  const bytes = await fs.readFile(new URL('./hello.wasm', import.meta.url)); // works in Node >=14 with --experimental-modules or with CommonJS use __dirname
  const { instance } = await WebAssembly.instantiate(bytes, {});
  const add = instance.exports.add;
  console.log("3 + 4 =", add(3,4));
}

main().catch(err => {
  console.error(err);
  process.exit(1);
});
