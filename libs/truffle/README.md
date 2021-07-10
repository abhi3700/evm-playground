# Truffle

## Installation
* `$ npm install -g truffle`
	- check installation using `truffle version`
* Update solidity, if not latest
	- `$ npm install -g solc`, check via `$ solcjs --version`
* get the directory of truffle location
```console
$ which truffle
/home/abhi3700/.nvm/versions/node/v14.4.0/bin/truffle
```
* [Ganache: Local Blockchain](https://www.trufflesuite.com/ganache)

## Commands
* `truffle init` - creates an empty Truffle project with no example contracts included.
* `truffle create contract <contract_name>` - create a contract file (with initial code) in the folder
* `truffle develop` - create a network for SC deploy
* `truffle migrate` - migrate the contracts onto the running network
* `truffle migrate --reset` - replace the deployed contracts with new addresses


## Project Setup
* Create a folder via `mkdir pet-shop-tutorial`
* `$ cd pet-shop-tutorial`
* `$ truffle unbox pet-shop`: includes the basic project structure as well as code for the user interface.
* Explain [Directory Structure](https://www.trufflesuite.com/tutorial#directory-structure)

> A migration is an additional special smart contract that keeps track of changes.

## Troubleshooting
### solidity version issue
* Error
```console
Error: Truffle is currently using solc 0.5.16, but one or more of your contracts specify "pragma solidity ^0.8.6".
Please update your truffle config or pragma statement(s).
(See https://trufflesuite.com/docs/truffle/reference/configuration#compiler-configuration for information on
configuring Truffle to use a specific solc compiler version.)

Compilation failed. See above.
```
* Before of `truffle-config.js`
```js
module.exports = {
  // See <http://truffleframework.com/docs/advanced/configuration>
  // for more about customizing your Truffle configuration!
  networks: {
    development: {
      host: "127.0.0.1",
      port: 7545,
      network_id: "*" // Match any network id
    },
    develop: {
      port: 8545
    }
  }
};
```
* Solution: add compiler into `truffle-config.js`
```js
module.exports = {
  // See <http://truffleframework.com/docs/advanced/configuration>
  // for more about customizing your Truffle configuration!
  networks: {
    development: {
      host: "127.0.0.1",
      port: 7545,
      network_id: "*" // Match any network id
    },
    develop: {
      port: 8545
    }
  },
  compilers: {
    solc: {
      version: "0.8.6",
      settings: {
       optimizer: {
         enabled: true,
         runs: 150
       },
      }
    }
  }
};
```

> NOTE: Ensure latest version of `solc` is installed using `npm` via `$ npm install -g solc`. check `$ solcjs --version`

> `solc` is a CLI tool for compiling solidity codes, whereas `solcjs` is used alongwith `truffle` 

### Ganache: Zero ETH balance in addresses
* Don't start with Quickstart, rather create a workspace.

### Ganache: View Contracts
* Problem: contract is not viewable in Ganache 
* Solution: just install [node for main OS: Windows 10](https://nodejs.org/en/download/)

### Where to find 'Assert.sol' file
* try
```console
$ find ~ -name "Assert.sol"
/home/abhi3700/.nvm/versions/node/v14.4.0/lib/node_modules/truffle/build/Assert.sol
```
* Exact file [here](https://github.com/trufflesuite/truffle/blob/develop/packages/resolver/solidity/Assert.sol)

### Not found 'DeployedAddresses.sol' file
* try
```console
$ find ~ -name "DeployedAddresses.sol"
$
```
* Not found, because this file is dynamically created at test time. (Kindalike the geth.ipc file that gets generated when geth is running but disappears when geth is stopped).

## References
* [Website](https://www.trufflesuite.com/)
* [Getting Started](https://www.trufflesuite.com/tutorial)
* [Assert.sol](https://github.com/trufflesuite/truffle/blob/develop/packages/resolver/solidity/Assert.sol)
* [All Asserts file for testing](https://github.com/trufflesuite/truffle/tree/develop/packages/resolver/solidity)
* [WRITING TESTS IN SOLIDITY](https://www.trufflesuite.com/docs/truffle/testing/writing-tests-in-solidity)
