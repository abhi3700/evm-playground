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

## Concepts
* Watch these in series
	- [How to Use an ERC-20 Token | Solidity (0.6)](https://youtu.be/xtDkat5f6Hs)
* `transfer` >> `approve`
	- sender is the owner in `allowance` to check the recipient's spendable value
	- Example: Suppose, Alice (100 MTN) wants to transfer 10 MTN to Bob (0 MTN).
		1. Alice calls `transfer(Bob, 10)` function => `balanceOf(Bob)` updated from `0` to `10`
		1. Now, `approve(Bob, 10)` can be called by either Alice or Bob, so that the Bob could spend max. 10 MTN tokens. => `allowance(Alice, Bob)` updated from 0 to 10.
		1. [ ] TODO: Also check `allowance(Bob, Bob)` where signer is Alice/Bob (2 cases).
		1. [ ] TODO: Also check `allowance(Alice, Bob)` where signer is Alice/Bob (2 cases).

* `approve` >> `transferFrom`:
	- sender is the owner in `allowance` to check the recipient's spendable value
	- Example: Suppose, Bob(10 MTN) wants to request 20 MTN tokens from Alice (90 MTN).
	  1. Alice calls `approve(Bob, 20)` so that Bob can transfer 20 MTN on behalf of Alice. => `allowance(Alice, Bob)` updated to 20.
	  1. Bob calls `transferFrom(Alice, Bob, 20)` function => `balanceOf(Bob)` = 30
* `approve(spender, token)` 
	- to approve the spending of token
	- allowance(owner, spender) mapping storage var gets updated.
		- here, owner: owner of the amount of tokens, not necessarily the token admin.
		- here, spender: spender of the amount of tokens. 
		- Example: Suppose out of 100 MTN tokens of Alice (owner), Bob (spender) is allowed to spend 10 MTN tokens. i.e. `allowance[Alice][Bob] = 10`
		- A person is allowed to spend the amount shown in `allowance[Owner][Person]`. Note: Owner is not the token Admin.


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
* [How to Create an ERC20 Token the Simple Way | Toptal](https://www.toptal.com/ethereum/create-erc20-token-tutorial)
* [Understanding ERC-20 token contracts](https://www.wealdtech.com/articles/understanding-erc20-token-contracts/)
* https://solidity-by-example.org/app/erc20/