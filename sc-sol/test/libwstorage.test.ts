import { Contract, ContractFactory } from "ethers";
import { ethers } from "hardhat";
import { expect } from "chai";
import { ZERO_ADDRESS } from "./testUtils";
import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";

describe("LibWStorage", async () => {
  let libwstorage: Contract;
  let libwstorageFactory: ContractFactory;
  let alice: SignerWithAddress, bob: SignerWithAddress;

  beforeEach(async () => {
    [alice, bob] = await ethers.getSigners();
    libwstorageFactory = await ethers.getContractFactory("LibWStorage");
    libwstorage = await libwstorageFactory.deploy();
    await libwstorage.deployed();
  });

  it("Should return the old state after deployment", async () => {
    const [oldAddress, oldName] = await libwstorage.getState();
    expect(oldAddress).to.eq(ZERO_ADDRESS);
    expect(oldName).to.eq("");
  });

  it("Should set the new state", async () => {
    await libwstorage.connect(alice).setState(bob.address, "Test");
    const [newAddress, newName] = await libwstorage.getState();
    expect(newAddress).to.eq(bob.address);
    expect(newName).to.eq("Test");
  });

  it("Should get the position", async () => {
    const position = await libwstorage.getPosition();
    // console.log("position", position);
    expect(position).to.not.eq(0);
  });

  it("Should get the same position even after setting a new state", async () => {
    const positionBefore = await libwstorage.getPosition();
    // console.log("position", positionBefore);

    await libwstorage.connect(alice).setState(bob.address, "Test");
    const positionAfter = await libwstorage.getPosition();

    expect(positionBefore).to.eq(positionAfter);
  });
});
