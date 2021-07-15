# Hardhat

## About
* Hardhat is a development environment to compile, deploy, test, and debug your Ethereum software.
* Hardhat comes built-in with Hardhat Network, a local Ethereum network designed for development. Its functionality focuses around Solidity debugging, featuring stack traces, console.log() and explicit error messages when transactions fail.
* Hardhat vs Truffle
	- Unlike Truffle, in Hardhat, there is a print option using `console.log` present inside `hardhat/console.sol` lib.
* There are 

## Installation
* Ensure installation of nvm, npm, nodejs
* `$ npm install --save-dev hardhat` inside a project directory

## Architecture
* Hardhat is designed around the concepts of tasks and plugins. The bulk of Hardhat's functionality comes from plugins, which as a developer you're free to choose the ones you want to use.

### [Tasks](https://hardhat.org/tutorial/creating-a-new-hardhat-project.html#tasks)
* Available tasks (by default): `compile`, `check`, `test`, etc.
* Create a new task [here](https://hardhat.org/guides/create-task.html)
* Example inside `hardhat.config.js` config file:
```
// https://hardhat.org/guides/create-task.html
/*task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});
```

### [Plugins](https://hardhat.org/tutorial/creating-a-new-hardhat-project.html#plugins)
* `$ npm install --save-dev @nomiclabs/hardhat-ethers ethers @nomiclabs/hardhat-waffle ethereum-waffle chai`
* Add line to your config file - `hardhat.config.js`
```js
require("@nomiclabs/hardhat-waffle");

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: "0.7.3",
};
```

## Getting Started
* [Follow this tutorial](https://hardhat.org/tutorial/)
* After `$ npx hardhat`, If you select `Create a sample project a simple project` creation wizard will ask you some questions and create a project with the following structure:
```
contracts/			- is where the source files for your contracts should be.
scripts/				- is where your tests should go.
test/						- is where simple automation scripts go.
hardhat.config.js
```

## Testing & Ethereum networks
* When it comes to testing your contracts, Hardhat comes with some built-in defaults:
	- The built-in Hardhat Network as the development network to test on
	- Mocha as the test runner
* If you need to use an external network, like an Ethereum testnet, mainnet or some other specific node software, you can set it up using the networks configuration entries in the exported object in hardhat.config.js, which is how Hardhat projects manage settings.

You can use of the `--network` CLI parameter to quickly change the network. Click more for `set up your ethereum network` - https://hardhat.org/config/#networks-configuration

## Plugins & Dependencies
* [`Ether.js`](https://docs.ethers.io/)
* [`Waffle`](https://getwaffle.io/)
	- used in config file
* [`Chai`](https://www.chaijs.com/)
	- used for assertion, which comes from `Waffle`
* [`Mocha`](https://mochajs.org/)
	- test runner to organized your tests. All Mocha functions are available in the global scope.
	- has 4 functions: `before`, `beforeEach`, `after`, `afterEach`.
	- They're very useful to setup the environment for tests, and to clean it up after they run.
* You may have seen this notice when creating the sample project:
```
You need to install these dependencies to run the sample project:
  npm install --save-dev @nomiclabs/hardhat-waffle ethereum-waffle chai @nomiclabs/hardhat-ethers ethers
```
* The sample project uses the @nomiclabs/hardhat-waffle plugin, which depends on the @nomiclabs/hardhat-ethers plugin. These integrate the Ethers.js and Waffle tools into your project. Following is to be present in the `hardhat.config.js` config file:
```
require("@nomiclabs/hardhat-waffle");

module.exports = {};
```


## Project Setup
1. Open bash in a folder & then run `$ npm init -y` or `$ npm init --yes`. Already done [here](../../base/Greeter)
1. Then, download hardhat using `$ npm install --save hardhat`
1. `$ npx hardhat` >> Choose "Create an empty hardhat.config.js". Now, config file created
1. Hardhat will install plugins like `hardhat-waffle`, `hardhat-ethers`. If missed, install using `$ npm install --save-dev @nomiclabs/hardhat-waffle ethereum-waffle chai @nomiclabs/hardhat-ethers ethers`
1. To first get a quick sense of what's available and what's going on, run npx hardhat in your project folder using `$ npx hardhat`
1. Next add the line `require('@nomiclabs/hardhat-waffle');` in file `hardhat.config.js`

> We're only requiring hardhat-waffle here because it depends on hardhat-ethers so adding both isn't necessary.

1. If you take a look at the `hardhat.config.js` file, you will find the definition of the task `accounts`. Now, list down the accounts `$ npx hardhat accounts`
1. Now, to compile use `$ npx hardhat compile` 
	- the compiled artifacts saved in the `artifacts/` directory by default or whatever your configured artifacts path is.
	- If you didn't change any files since the last compilation, nothing will be compiled & it shows like this: `Nothing to compile`
	- Enforce a recompilation using `npx hardhat compile --force`
1. Now, for testing use `$ npx hardhat test` after creating a file `test/test.js` (filename doesn't matter.). Here, the contract(s) have been tested w/o deployment.

> 3 main concepts: `Signer`, `ContractFactory` and `Contract` are explained here.

1. To deploy the contract, [source](https://hardhat.org/tutorial/debugging-with-hardhat-network.html) after creating the `scripts/deploy.js`:
	- __Hardhat network__: use `$ npx hardhat run scripts/deploy.js`
	- __local network__: use `$ npx hardhat run scripts/deploy.js --network local` using Ganache local chain & to see rich contract data, compile using truffle. View the contract in Ganache.
```console
$ npx hardhat run scripts/deploy.js --network local
Deploying contracts with the account: 0xef92fAA501c2B7F84763066fE382DfC455A2Bf82
Account balance: 99558873620000000000
Token address: 0xBC9b6a9Ba4C0C83F4A8BE90D32419365ACeB10B9
```
		+ Add the `network` in config file `hardhat.config.js`:
```
module.exports = {
  solidity: "0.8.6",
  networks: {
    local: {
      url: 'http://127.0.0.1:7545/',
      accounts: ['0xe0db4b3fa4af41d065eb3c2e5df3dfbed18203607e59ec428e225e7b2d23c194'],
    },
  },
};
```
	- __Rinkeby network__: use `$ npx hardhat run scripts/deploy.js --network rinkeby`. View the contract - https://ropsten.etherscan.io/address/<contract_address>

## Commands
* `$ npx hardhat compile`: compile a contract
* `$ npx hardhat compile --force`: compile a contract, even if it's compiled already
* `$ npx hardhat clean`: clear the `cache` folder and delete the `artifacts/` folder.
* Multiple Solidity versions compilation within same folder - [here](https://hardhat.org/guides/compile-contracts.html#multiple-solidity-versions)
* `npx hardhat test` - runs all the files in the folder
* `npx hardhat test ./test/Greeter-test.js` - runs particularly the file
* [testing for selected `describe` inside `*.js` file, add `.only`](https://mochajs.org/#exclusive-tests)

### OpenZeppelin
* `$ npm install @openzeppelin/contracts`

## Troubleshooting
### Nothing to compile
* This gets displayed, when there is an already existing `artifacts/` folder.
* Solution: delete the folder & then `$ npx hardhat compiled`

### Console.log Support error
* Check the type of variables parsed. Ensure it's of these supported types: Integer, String, Bool, address

## TODO
- call the solidity functions using CLI

## References
* [Getting Started guide](https://hardhat.org/getting-started/)
* [Solidity Writing To Console (console.log) - Hardhat Introduction](https://www.youtube.com/watch?v=5V5vDJhafwk)