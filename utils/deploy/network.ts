/* 
    Get network details for the current network on which it's running
*/

import { ethers } from "hardhat";

// import "@typechain/hardhat"; has to be present in 'hardhat.config.ts' file

// const network = await ethers.getDefaultProvider().getNetwork();   // always return homestead & chainId: 1
const network = await ethers.provider.getNetwork();
const chainId: number = network.chainId;
console.log(`Network name: ${network.name}`);
console.log(`Network chain id: ${chainId}`);

// use for running a logic inside the deploy script like this:

if (chainId === 31337) {
  // do something
} else {
  // do something
}

// ---------------------
/* 
  Metamask assumes localhost:8545 as chain id: 1337, but actually with hardhat, it gives chain id as 31337
*/
