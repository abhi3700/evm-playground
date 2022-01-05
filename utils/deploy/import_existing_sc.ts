const tokenContract = require("../../build/artifacts/contracts/Token.sol/Token.json")
const tokenContractAddress = '0x0DCd1Bf9A1b36cE34237eEaFef220932846BCD82' || "";           // tested in localhost

// get the token contract
const token = await ethers.getContractAt(tokenContract.abi, tokenContractAddress);
