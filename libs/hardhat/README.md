# Hardhat

## About
* Hardhat is a development environment to compile, deploy, test, and debug your Ethereum software.
* Hardhat comes built-in with Hardhat Network, a local Ethereum network designed for development. Its functionality focuses around Solidity debugging, featuring stack traces, console.log() and explicit error messages when transactions fail.

## Installation
* Ensure installation of nvm, npm, nodejs

## Project Setup
1. Open bash in a folder & then run `$ npm init -y`
1. Then, `$ npm install -D hardhat`
1. `$ npx hardhat` >> Choose "Create an empty hardhat.config.js". Now, config file created
1. Now, install plugins using `$ npm install -D @nomiclabs/hardhat-ethers ethers @nomiclabs/hardhat-waffle ethereum-wallet chai`
1. Next add the line `require('@nomiclabs/hardhat-waffle')` in file `hardhat.config.js`

### OpenZeppelin
* `$ npm install @openzeppelin/contracts`