---
title: Test Contract (as SC Owner) withdraws ETH
---

For instance, there is a SC whose owner is `msg.sender` (set in the `constructor` function) and there is a `withdraw()` function (only called by Owner):

```solidity
// Contract.sol
contract Contract {

    constructor() {
        owner = msg.sender;
    }

    function withdraw() external {
        if (msg.sender != owner) {
            revert OnlyOwner();
        }

        (bool success,) = owner.call{value: _amount}("");
        if (!success) {
            revert TransferOnlyToOwnerFailed();
        }

    }
}
```

Now, during test, we need to withdraw as owner. And when doing this, we need to ensure a `receive()` function defined. Otherwise, make the owner as some other address (not the contract).

> By default, `ContractTest` becomes the deployer of the `Contract.sol` file. Hence, the owner is a contract. This implies that when withdrawing the ETH from the SC function, we need to add `receive()` function beforehand:

```solidity
// Contract.t.sol

contract ContractTest is Test {
    receive() external payable {}

    testWithdraw() {
        // deposit some eth

        // owner withdraws all eth
    }
}
```
