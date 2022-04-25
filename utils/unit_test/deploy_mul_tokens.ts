/* 
    Read this: "../../base/Token/README.md#"

*/

import { GenericERC20 } from "../../build/typechain/GenericERC20";
import GenericERC20Artifact from "../../build/artifacts/contracts/helper/GenericERC20.sol/GenericERC20.json";
import { Wallet } from "ethers";
import { deployContract } from "ethereum-waffle";

async function deploySwap(): Promise<void> {

    const tbtcToken = (await deployContract(
        (owner as unknown) as Wallet,
        GenericERC20Artifact,
        ["tBTC", "TBTC", "18"],
    )) as GenericERC20;
    await tbtcToken.deployed();

    const wbtcToken = (await deployContract(
        (owner as unknown) as Wallet,
        GenericERC20Artifact,
        ["Wrapped Bitcoin", "WBTC", "8"],
    )) as GenericERC20;
    await wbtcToken.deployed();

    const renbtcToken = (await deployContract(
        (owner as unknown) as Wallet,
        GenericERC20Artifact,
        ["renBTC", "RENBTC", "8"],
    )) as GenericERC20;
    await renbtcToken.deployed();

    const sbtcToken = (await deployContract(
        (owner as unknown) as Wallet,
        GenericERC20Artifact,
        ["sBTC", "SBTC", "18"],
    )) as GenericERC20;
    await sbtcToken.deployed();
}

deploySwap()
    .then(() => {
        console.log("Successfully deployed contracts locally...")
    }
  .catch ((error: Error) => {
    console.error(error);
    throw new Error("Exit: 1");
});