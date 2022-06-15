/* 
  Get SC address from `CREATE2` (https://eips.ethereum.org/EIPS/eip-1014) call
  Source: https://docs.ethers.io/v5/api/utils/address/#utils--contract-addresses
*/

const from = "0x8ba1f109551bD432803012645Ac136ddd64DBA72";
const salt =
  "0x7c5ea36004851c764c44143b1dcb59679b11c9a68e5f41497f6cf3d480715331";
const initCode = "0x6394198df16000526103ff60206004601c335afa6040516060f3";
const initCodeHash = keccak256(initCode);

getCreate2Address(from, salt, initCodeHash);
// '0x533ae9d683B10C02EbDb05471642F85230071FC3'
