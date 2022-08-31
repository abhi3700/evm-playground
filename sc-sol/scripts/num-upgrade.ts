import { ethers, upgrades } from "hardhat";
import { Contract, ContractFactory /* , BigNumber */ } from "ethers";
import { config as dotenvConfig } from "dotenv";
import { resolve } from "path";
dotenvConfig({ path: resolve(__dirname, "./.env") });

async function main(): Promise<void> {
  // ==============================================================================
  // We get the contract to deploy
  const numV2Factory: ContractFactory = await ethers.getContractFactory(
    "NumV2"
  );
  const proxyContract: Contract = await upgrades.upgradeProxy(
    "0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0",
    numV2Factory
  );
  await proxyContract.deployed();
  const proxyAdminAddress: String = await upgrades.erc1967.getAdminAddress(
    proxyContract.address
  );
  const numContractAddress: string =
    await upgrades.erc1967.getImplementationAddress(proxyContract.address);
  console.log("Proxy SC deployed to: ", proxyContract.address);
  console.log("Proxy Admin deployed to: ", proxyAdminAddress);
  console.log("Implementation SC deployed to: ", numContractAddress);
  console.log(
    `The transaction that was sent to the network to deploy the contract: ${proxyContract.deployTransaction.hash}`
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
