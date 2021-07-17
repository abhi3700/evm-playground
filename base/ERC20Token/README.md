# ERC20 Token

## About

## Installation
* OpenZeppelin - `$ npm install @openzeppelin/contracts`
	- use like this `import "@openzeppelin/contracts/token/ERC20/ERC20.sol"` in Solidity
	- find whether installed or not via `$ npm list | grep openzeppelin`
* Hardhat Testing framework
	- install using `$ npm install --save-dev @openzeppelin/hardhat-upgrades` for every project
	- Also, add this line `require('@openzeppelin/hardhat-upgrades');` to the config file `hardhat.config.js` for openzeppelin contracts

## Contract
* [Example](./contracts/ERC20Token.sol)

## Compile
```console
$ npx hardhat compile
Solidity 0.8.6 is not fully supported yet. You can still use Hardhat, but some features, like stack traces, might not work correctly.

Learn more at https://hardhat.org/reference/solidity-support"

Compiling 8 files with 0.8.6
Compilation finished successfully
```

## Deploy
* Rinkeby Testnet
```console
$ npx hardhat run scripts/ERC20Token-deploy.js --network rinkeby
Compiling 8 files with 0.8.6
Compilation finished successfully
Deploying contracts with the account: 0x3E52edB6f9283dE867fbe65F444CC615CE6F2BcD
Account balance: 18748989215991913728
Contract address: 0x8Da5764cbbB70D73D73086b81ba3cD22c8d821aD
```

## References
* 