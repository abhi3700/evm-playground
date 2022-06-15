/* 
  Compute address using
  - private key
  - public key (compressed)
  - public key (uncompressed)
  
  Source: https://docs.ethers.io/v5/api/utils/address/#utils-computeAddress
*/

// Private Key
ethers.utils.computeAddress(
  "0xb976778317b23a1385ec2d483eda6904d9319135b89f1d8eee9f6d2593e2665d"
);
// '0x0Ac1dF02185025F65202660F8167210A80dD5086'

// Public Key (compressed)
ethers.utils.computeAddress(
  "0x0376698beebe8ee5c74d8cc50ab84ac301ee8f10af6f28d0ffd6adf4d6d3b9b762"
);
// '0x0Ac1dF02185025F65202660F8167210A80dD5086'

// Public Key (uncompressed)
ethers.utils.computeAddress(
  "0x0476698beebe8ee5c74d8cc50ab84ac301ee8f10af6f28d0ffd6adf4d6d3b9b762d46ca56d3dad2ce13213a6f42278dabbb53259f2d92681ea6a0b98197a719be3"
);
// '0x0Ac1dF02185025F65202660F8167210A80dD5086'
