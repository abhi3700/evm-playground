import { ethers } from "hardhat";
import { Contract, ContractFactory /* , BigNumber */ } from "ethers";
import { config as dotenvConfig } from "dotenv";
import { resolve } from "path";
dotenvConfig({ path: resolve(__dirname, "./.env") });

async function main(): Promise<void> {
  // ==============================================================================
  // We get the contract to deploy
  const numFactory: ContractFactory = await ethers.getContractFactory("Num");
  const numContract: Contract = await numFactory.deploy(10);
  await numContract.deployed();
  console.log("SC deployed to: ", numContract.address);
  console.log(
    `The transaction that was sent to the network to deploy the contract: ${numContract.deployTransaction.hash}`
  );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then()
  .catch((error: Error) => {
    console.error(error);
    throw new Error("Exit: 1");
  });
