# ethio_playground
Ethereum Contracts [helpful for EOSIO Developers]


## Compile
* Ethereum smart contracts are generally written in Solidity and then compiled into EVM bytecode and corresponding ABI via solc.

> NOTE: most people do not compile contracts directly through commands, because there are very convenient tools and frameworks such as remix or truffle.

* Comparo

| | Solidity | EOSIO |
|--|------|---|
| Compile Contract | solcjs --abi --bin hello.sol | eosio-cpp hello.cpp -o hello.wasm |
| Deployment contract |	hello=(web3.eth.contract([…])).new({…}) |	cleos set contract hello ./hello -p hello@active |
| Call contract | hello.hi.sendTransaction(…) | cleos push action hello hi '["bob"]' -p bob@active |

## Deploy
* The address of the contract account (not external account) is automatically generated at deployment time, and the contract can never be changed once deployed.
* In ETH, gas fee is analogous to EOS's RAM (for contract storage), CPU, NET (follow staked or powerup model). `EOSIO's CPU & NET` <-> `ETH's gas fee`
* In ETH, an object is created based on ABI in the `geth` console and then calls the `new()` method to initiate a contract creation txn (parameters contain bytecode), whereas in EOSIO's `cleos` tool, `set()` method is used to specify the bytecode and the directory where the ABI is located.

## Call
* The call method is only executed locally, does not generate transactions and does not consume gas, `sendTransaction()` method will generate transactions and consume gas, the transaction is executed by the miner and packaged into the block, while modifying the account status.

## Coding
### Layout
* Elements
	1. The pragma statement
	1. Import statements
	1. Interfaces
	1. Libraries
	1. Contracts

> NOTE: Libraries, interfaces, and contracts have their own elements as well. They should go in this order:

> - Type declarations

> - State variables

> - Events

> - Functions

### Contract
* Contracts and libraries should be named using the CapWords style. Examples: SimpleToken, SmartBank, CertificateHashRepository, Player, Congress, Owned.
* Contract and library names should also match their filenames.
* If a contract file includes multiple contracts and/or libraries, then the filename should match the core contract.
* Contracts consist of 2 main types:
	- Persistent data kept in __state variables__
	- Runnable __functions__ that can modify state variables

* Each contract can contain declarations of State Variables, Functions, Function Modifiers, Events, Errors, Struct Types and Enum Types. Furthermore, contracts can inherit from other contracts.

> NOTE: unlike in other languages, you don’t need to use the keyword this to access state variables.

* Creating contracts programmatically on Ethereum is best done via using the JavaScript API `web3.js`. It has a function called `web3.eth.Contract` to facilitate contract creation.
* A constructor is optional. Only one constructor is allowed, which means overloading is not supported.
* When a contract is created, its constructor (a function declared with the constructor keyword) is executed once.
* A constructor is optional. Only one constructor is allowed, which means overloading is not supported.
* Inheritance:
```
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.0 <0.9.0;

import "./Owned.sol";


contract Congress is Owned, TokenRecipient {
    //...
}
```

#### [State Variable types](https://docs.soliditylang.org/en/develop/types.html#types)
#### [Enums](https://docs.soliditylang.org/en/develop/types.html#enums) cannot have more than 256 members
#### [Function](https://docs.soliditylang.org/en/develop/types.html#enums)
```
function (<parameter types>) {internal|external} [pure|view|payable] [returns (<return types>)]
```

*  by default, functions are internal, so no need to write anything, or else, mention `public` 
* Getter methods are marked `view`.
* `constant` on functions is an alias to `view`, but this is deprecated and is planned to be dropped in version 0.5.0.
* Functions can be declared pure in which case they promise not to read from or modify the state.

### Special Variables and Functions
* There are special variables and functions which always exist in the global namespace and are mainly used to provide information about the blockchain or are general-use utility functions
```solidity
blockhash(uint blockNumber) returns (bytes32): hash of the given block when blocknumber is one of the 256 most recent blocks; otherwise returns zero
block.chainid (uint): current chain id
block.coinbase (address payable): current block miner’s address
block.difficulty (uint): current block difficulty
block.gaslimit (uint): current block gaslimit
block.number (uint): current block number
block.timestamp (uint): current block timestamp as seconds since unix epoch
gasleft() returns (uint256): remaining gas
msg.data (bytes calldata): complete calldata
msg.sender (address): sender of the message (current call)
msg.sig (bytes4): first four bytes of the calldata (i.e. function identifier)
msg.value (uint): number of wei sent with the message
tx.gasprice (uint): gas price of the transaction
tx.origin (address): sender of the transaction (full call chain)
```

## References
* [From Solidity to EOS contract development](https://www.programmersought.com/article/6940225644/)
