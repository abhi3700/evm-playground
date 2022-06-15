/* 
  Get SC address from transaction & nonce
  Source: https://docs.ethers.io/v5/api/utils/address/#utils--contract-addresses
*/

const from = "0x8ba1f109551bD432803012645Ac136ddd64DBA72";
const nonce = 5;

ethers.utils.getContractAddress({ from, nonce });
// '0x082B6aC9e47d7D83ea3FaBbD1eC7DAba9D687b36'
