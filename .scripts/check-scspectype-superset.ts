// Every SCValType that can appear at a contract function boundary must be
// expressible in a contract spec, so SCSpecType needs a counterpart for it.
// The names line up by prefix: SCV_U32 -> SC_SPEC_TYPE_U32.

import { readFileSync } from "node:fs";

// SCValType variants that cannot cross a contract function boundary, and so
// intentionally have no SCSpecType counterpart.
const EXCLUDED = [
  "CONTRACT_INSTANCE",
  "LEDGER_KEY_CONTRACT_INSTANCE",
  "LEDGER_KEY_NONCE",
];

const spec = readFileSync("Stellar-contract-spec.x", "utf8");
const val = readFileSync("Stellar-contract.x", "utf8").match(/\bSCV_\w+/g) ?? [];

const missing = [...new Set(val.map((name) => name.slice("SCV_".length)))]
  .filter((name) => !EXCLUDED.includes(name))
  .filter((name) => !new RegExp(`\\bSC_SPEC_TYPE_${name}\\b`).test(spec));

if (missing.length > 0) {
  console.log(`
SCValType variants with no SCSpecType counterpart: ${missing.map((n) => "SCV_" + n).join(", ")}

SCSpecType must be a superset of SCValType so that every value type usable at a
contract function boundary can be captured in a contract spec. Either add the
missing SCSpecType variant, or, if the value cannot cross a contract boundary,
add it to EXCLUDED in this script.`);
  process.exit(1);
}

console.log("SCSpecType covers every SCValType variant.");
