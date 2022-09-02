/* 
    Deploy a SC - "StfxVault.sol" as upgradeable using OZ Transparent Proxy pattern
*/

// Deploy Vault SC
const StfxVaultFactory: ContractFactory = await ethers.getContractFactory(
  "StfxVault"
);
const stfxVaultproxyContract: Contract = await upgrades.deployProxy(
  StfxVaultFactory,
  [
    readerContract.address,
    stfxContract.address,
    BigNumber.from(String(5e10)),
    BigNumber.from(String(2e7)),
    BigNumber.from(String(5e10)),
    USDC_ADDRESS,
  ]
);
await stfxVaultproxyContract.deployed();
const stfxVaultproxyAdminAddress: String =
  await upgrades.erc1967.getAdminAddress(stfxVaultproxyContract.address);
const stfxVaultContractAddress: string =
  await upgrades.erc1967.getImplementationAddress(
    stfxVaultproxyContract.address
  );
console.log("Proxy SC deployed to: ", stfxVaultproxyContract.address);
console.log("Proxy Admin deployed to: ", stfxVaultproxyAdminAddress);
console.log("Implementation SC deployed to: ", stfxVaultContractAddress);
console.log(
  `The transaction that was sent to the network to deploy the proxy contract: ${stfxVaultproxyContract.deployTransaction.hash}\n`
);
