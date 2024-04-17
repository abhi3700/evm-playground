# Foundry `anvil`

## Commands

#### Run chisel

```sh
chisel                                                                                                                                                     ⏎
Welcome to Chisel! Type `!help` to show available commands.
➜
```

Now, if you run `block.number` i.e. the latest block number:

```sh
chisel 
Welcome to Chisel! Type `!help` to show available commands.
➜ block.number
Type: uint256
├ Hex: 0x0000000000000000000000000000000000000000000000000000000000000001
├ Hex (full word): 0x0000000000000000000000000000000000000000000000000000000000000001
└ Decimal: 1
➜ 
```

#### Connect to a specific RPC/Node url

```sh
❯ chisel --rpc-url $NOVA_RPC_URL 
Welcome to Chisel! Type `!help` to show available commands.
➜ block.number
Type: uint256
├ Hex: 0x0000000000000000000000000000000000000000000000000000000000053aad
├ Hex (full word): 0x0000000000000000000000000000000000000000000000000000000000053aad
└ Decimal: 342701
➜ 
```

#### Load contract code with interface

<details><summary>Details:</summary>

Below is a Counter contract that has 2 functions `setNumber` and `increment`.

```sh
chisel --rpc-url http://127.0.0.1:8545
Welcome to Chisel! Type `!help` to show available commands.
➜ !source
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {Vm} from "forge-std/Vm.sol";

contract REPL {
    Vm internal constant vm = Vm(address(uint160(uint256(keccak256("hevm cheat code")))));

    /// @notice REPL contract entry point
    function run() public {}
}

➜ interface ICounter {
    // Declares the public variable 'number' for external access
    function number() external view returns (uint256);

    // Event declaration for setting a new number
    event NumberSet(address indexed caller, uint256 newNumber);

    // Event declaration for incrementing the number
    event Incremented(address indexed caller);

    // Function to set a new number
    function setNumber(uint256 newNumber) external;

    // Function to increment the number
    function increment() external;
}
➜ !source
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {Vm} from "forge-std/Vm.sol";

interface ICounter {
    // Declares the public variable 'number' for external access
    function number() external view returns (uint256);

    // Event declaration for setting a new number
    event NumberSet(address indexed caller, uint256 newNumber);

    // Event declaration for incrementing the number
    event Incremented(address indexed caller);

    // Function to set a new number
    function setNumber(uint256 newNumber) external;

    // Function to increment the number
    function increment() external;
}

contract REPL {
    Vm internal constant vm = Vm(address(uint160(uint256(keccak256("hevm cheat code")))));

    /// @notice REPL contract entry point
    function run() public {}
}
➜ ICounter counter = ICounter(0x5fbdb2315678afecb367f032d93f642f64180aa3)
➜ counter.number()
Type: uint256
├ Hex: 0x0000000000000000000000000000000000000000000000000000000000000004
├ Hex (full word): 0x0000000000000000000000000000000000000000000000000000000000000004
└ Decimal: 4
➜ counter.setNumber(42);
➜ counter.number()
Type: uint256
├ Hex: 0x000000000000000000000000000000000000000000000000000000000000002a
├ Hex (full word): 0x000000000000000000000000000000000000000000000000000000000000002a
└ Decimal: 42
➜ counter.increment();
➜ counter.number()
Type: uint256
├ Hex: 0x000000000000000000000000000000000000000000000000000000000000002b
├ Hex (full word): 0x000000000000000000000000000000000000000000000000000000000000002b
└ Decimal: 43
```

Contract code loaded with interface. Also, setter and getter functions called.

</details>
