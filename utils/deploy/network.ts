/* 
    Get network details for the current network on which it's running
*/

import { ethers } from "hardhat";

// import "@typechain/hardhat"; has to be present in 'hardhat.config.ts' file

const network = await ethers.getDefaultProvider().getNetwork();
const chainId: number = network.chainId;
console.log(`Network name: ${network.name}`);
console.log(`Network chain id: ${chainId}`);

// use for running a logic inside the deploy script like this:

if (chainId === 1) {
  // do something
} else {
  // do something
}
