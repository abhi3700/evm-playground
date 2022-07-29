# Token

## About

- It is ERC20 Token SC.
- It can be written with so many modifications in terms of adding timelock, DEX, whitelisting users, etc.
- In terms of decimal these are the types:

  - #### [ERC20 Token SC with default decimal i.e. 18](../contracts/ERC20Token.sol)
  - #### [ERC20 Token SC with custom decimal for 1 token (say 9)](../contracts/ERC20TokenD.sol)
  - #### [ERC20 Token SC with custom decimal for multiple tokens](../contracts/GenericERC20Token.sol)
    - It can be used in unit tests for DeFi applications like staking, vault, etc.

  ```ts
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
    .catch((error: Error) => {
      console.error(error);
      throw new Error("Exit: 1");
  });
  ```

  - #### [ERC20 Token SC pre-minted](../contracts/ERC20TokenM.sol)

    - Hence, doesn't need to write additional lines in scripts for minting token

  - #### [ERC20 Token SC pre-minted with custom decimals](../contracts/ERC20TokenDM.sol)
  - #### [ERC20 Token SC capped, pre-mint addresses with custom decimals](../contracts/ERC20TokenCapD.sol)
  - #### [ERC20 Token SC with metadata, custom decimals](../contracts/ERC20TokenMeta.sol)
