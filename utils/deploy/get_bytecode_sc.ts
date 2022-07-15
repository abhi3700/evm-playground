/* 
    Get bytecode of a SC
    Here, the source code is available.
*/
// 1. compile the source code into binary
// 2. call from "build/artifacts/contracts/<contract_name.sol>/<contract_name.json>"
const abi = require("../build/artifacts/contracts/Bank.sol/Bank.json");
const bytecode = abi.bytecode;
