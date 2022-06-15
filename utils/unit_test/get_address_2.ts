/* 
  Recover address from a signed message (signature) & digest (hashed message)

  Needs:
  - hashed message i.e. digest
  - signed message (with private key) i.e. signature which consists of r, s, v

  Source: https://docs.ethers.io/v5/api/utils/address/#utils-recoverAddress
*/

const digest =
  "0x7c5ea36004851c764c44143b1dcb59679b11c9a68e5f41497f6cf3d480715331";

// Using an expanded Signature
ethers.utils.recoverAddress(digest, {
  r: "0x528459e4aec8934dc2ee94c4f3265cf6ce00d47cf42bb106afda3642c72e25eb",
  s: "0x42544137118256121502784e5a6425e6183ca964421ecd577db6c66ba9bccdcf",
  v: 27,
});
// '0x0Ac1dF02185025F65202660F8167210A80dD5086'

// Using a flat Signature
const signature =
  "0x528459e4aec8934dc2ee94c4f3265cf6ce00d47cf42bb106afda3642c72e25eb42544137118256121502784e5a6425e6183ca964421ecd577db6c66ba9bccdcf1b";
ethers.utils.recoverAddress(digest, signature);
// '0x0Ac1dF02185025F65202660F8167210A80dD5086'
