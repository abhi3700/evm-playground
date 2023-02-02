import { expect } from "chai";
import { ethers } from "hardhat";
import { ContractFactory, Contract } from "ethers";

describe("ERC20Token", function () {
  let ERC20Token: ContractFactory;
  let erc20token: Contract;

  beforeEach(async function () {
    ERC20Token = await ethers.getContractFactory("ERC20Token");
    erc20token = await ERC20Token.deploy("Donut Token", "DONUT");
    await erc20token.deployed();
  });

  it("should return correct token name & symbol", async () => {
    expect(await erc20token.name()).to.eq("Donut Token");
    expect(await erc20token.symbol()).to.eq("DONUT");
  });

  // TODO: add more tests
});
