# Transfer ETH

## Applications

- Transfer ETH from from SC to an account (SC or EOA).

## Coding

- Below is the code snippet to transfer ETH from SC to an account (SC or EOA).

```solidity
// bad
contract Vulnerable {
    function withdraw(uint256 amount) external {
        // This forwards 2300 gas, which may not be enough if the recipient
        // is a contract and gas costs change.
        msg.sender.transfer(amount);
    }
}

// good
contract Fixed {
    function withdraw(uint256 amount) external {
        // This forwards all available gas. Be sure to check the return value!
        (bool success, ) = msg.sender.call.value(amount)("");
        require(success, "Transfer failed.");
    }
}
```

## Problem

- Both the methods: `transfer`, `send` use exactly `2300` gas. But, the Ethereum or EVM chain can have a dynamic gas requirement which can revert this transaction even if there is sufficient ETH to transfer.

## Solution

- Hence, use `call` where a fixed no. like `2300` can be parsed or it can be left blank to automatically decide based on the network requirement.

## References

- https://consensys.github.io/smart-contract-best-practices/development-recommendations/general/external-calls/#dont-use-transfer-or-send
