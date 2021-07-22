require("@nomiclabs/hardhat-waffle");

/*
  mainly for ERC20 Token contract, but can be used for 
  any contract using this lib
*/
require('@openzeppelin/hardhat-upgrades');

// Go to https://admin.moralis.io/speedyNodes, sign up, create
// a new App in its dashboard, and replace "KEY" with its key
const MORALIS_API_KEY = "a0bb5e42536be98ee47765ff";

// Replace this private key with your Ropsten account private key
// To export your private key from Metamask, open Metamask and
// go to Account Details > Export Private Key
// Be aware of NEVER putting real Ether into testing accounts
const RINKEBY_PRIVATE_KEY = "cf2a6872928392175e383fc10f93c13eab0c050bd4dbd6b45201fad5bd9409b7";

module.exports = {
  solidity: {
    compilers: [
      {
        version: "0.8.4",
        settings: {
          optimizer: {
            enabled: true,
            runs: 1000,
          },
        },
      },
      {
        version: "0.5.17",
        settings: {
          optimizer: {
            enabled: true,
            runs: 1000,
          },
        },
      },
    ],
    overrides: {
      "contracts/ERC20Token.sol": {
        version: "0.8.4",
        settings: {
          optimizer: {
            enabled: true,
            runs: 1000,
          },
        }
      }
    }
  },
  networks: {
    rinkeby: {
      url: `https://speedy-nodes-nyc.moralis.io/${MORALIS_API_KEY}/eth/rinkeby`,
      accounts: [`0x${RINKEBY_PRIVATE_KEY}`],
    },
    // local: {
    //   url: 'http://127.0.0.1:7545/',
    //   accounts: ['0xe0db4b3fa4af41d065eb3c2e5df3dfbed18203607e59ec428e225e7b2d23c194'],
    // },
  },
};