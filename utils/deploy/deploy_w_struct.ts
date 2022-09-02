/* 
    How to deploy a contract with struct (in Solidity) aka interface/type (in typescript)?
*/
import { ethers, upgrades } from "hardhat";
import { BigNumber, Contract, ContractFactory } from "ethers";

const PERP_VAULT: string = "0xb0ff090d04c268abb26450ba749f0497efa9bb7c";
const PERP_MARKET_REGISTRY: string =
  "0x51705d391e0d01fa684366407704de0856e4dbab";
const USDC_ADDRESS: string = "0x3e22e37cb472c872b5de121134cfd1b57ef06560";
const CLEARING_HOUSE: string = "0xf10288fd8d778f2880793c1caccbf02206649802";

interface Perp {
  vault: string;
  marketRegistry: string;
  clearingHouse: string;
}

const perpDex: Perp = <Perp>{
  vault: PERP_VAULT,
  marketRegistry: PERP_MARKET_REGISTRY,
  clearingHouse: CLEARING_HOUSE,
};

const ReaderFactory: ContractFactory = await ethers.getContractFactory(
  "Reader"
);

const readerContract: Contract = await ReaderFactory.deploy(perpDex);
await readerContract.deployed();
console.log("Reader deployed to: ", readerContract.address);
console.log(
  `The transaction that was sent to the network to deploy the Reader contract: ${readerContract.deployTransaction.hash}\n`
);
