/* 
    Upgrade script for SC written using OpenZeppelin (OZ) proxy pattern method 
*/

import { ethers, upgrades } from 'hardhat';
import { Contract, ContractFactory, BigNumber } from 'ethers';

const tokenContract = require("../../build/artifacts/contracts/Token.sol/Token.json")

// TODO: parse the deployed token contract address which needs to upgraded
// const UPGRADEABLE_TOKEN_CONTRACT = 'upgradeable-token-contract-address' || "";
const UPGRADEABLE_TOKEN_CONTRACT = '0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0' || "";           // tested in localhost

async function main(): Promise<void> {
  // Hardhat always runs the compile task when running scripts through it.
  // If this runs in a standalone fashion you may want to call compile manually
  // to make sure everything is compiled
  // await run("compile");
    
  // ==============================================================================
  // We get the token contract to deploy
  const TokenFactory: ContractFactory = await ethers.getContractFactory('Token2');
  
  // NOTE: No need to parse the `initialize` params, as storage state variables are maintained in the new deployed token contract 
  const token: Contract = await upgrades.upgradeProxy(UPGRADEABLE_TOKEN_CONTRACT, TokenFactory);

  console.log(`Token contract upgraded to: ${token.address}`);
  console.log(`The transaction that was sent to the network to upgrade the deployed token contract: ${
          token.deployTransaction.hash}`);

}


// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.  
main()
  .then(() => process.exit(0))
  .catch((error: Error) => {
    console.error(error);
    process.exit(1);
  });
