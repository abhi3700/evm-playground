---
title: Error w Args
---

For instance, a contract has an error with argument:

```solidity
// Contract.sol
error CannotEnd(uint256);
```

```solidity
// Contract.t.sol
function testEnd() public {
    skip(29 days);
    console2.log("now", block.timestamp);
    vm.expectRevert(abi.encodeWithSignature("CannotEnd(uint256)", block.timestamp));
    time.end();
}
```
