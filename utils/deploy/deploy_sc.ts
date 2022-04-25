// ==================================== M-1 ======================================
// import { ethers } from "hardhat";
// import { Contract, ContractFactory /* , BigNumber */ } from "ethers";
// import { config as dotenvConfig } from "dotenv";
// import { resolve } from "path";
// dotenvConfig({ path: resolve(__dirname, "./.env") });

// async function main(): Promise<void> {
//   // ==============================================================================
//   // We get the token contract to deploy
//   const Erc20TokenFactory = await ethers.getContractFactory("ERC20Token");
//    erc20TokenContract = await Erc20TokenFactory.deploy(
//      "Health Token",
//      "HLT"
//    );
//   await erc20TokenContract.deployed();
//   console.log("ERC20 token SC deployed to: ", erc20TokenContract.address);
//   console.log(
//     `The transaction that was sent to the network to deploy the erc20 token contract: ${erc20TokenContract.deployTransaction.hash}`
//   );
// }

// // // We recommend this pattern to be able to use async/await everywhere
// // // and properly handle errors.
// main()
//   .then(() => new Error("Exit: 0"))
//   .catch((error: Error) => {
//     console.error(error);
//     // process.exit(1);
//     throw new Error("Exit: 1");
//   });





// ==================================== M-2: Using task ======================================
// step-1
import { task } from "hardhat/config";
import { TaskArguments } from "hardhat/types";
import { Contract, ContractFactory /* , BigNumber */ } from "ethers";

task("deploy:ERC20Token", "Deploy Escrow Contract").setAction(async function (
    taskArguments: TaskArguments,
    { ethers }
) {
    // TODO: modify as per the SC written
    // We get the erc20 token contract to deploy
    const Erc20TokenFactory: ContractFactory = await ethers.getContractFactory(
        "ERC20Token"
    );
    const erc20TokenContract: Contract = await Erc20TokenFactory.deploy(
        "Health Token",
        "HLT"
    );
    await erc20TokenContract.deployed();
    console.log("ERC20 token SC deployed to: ", erc20TokenContract.address);
    console.log(
        `The transaction that was sent to the network to deploy the token contract: ${erc20TokenContract.deployTransaction.hash}`
    );
});

// step-2
// & then create an "index.ts" file & put this input
import "./deploy";

// step-3
// & then run in console for deploying
// $ yarn hardhat deploy:ERC20Token --network rinkeby

// For more, refer the boilerplate: https://github.com/abhi3700/evm_boilerplate
// ==================================================================================
