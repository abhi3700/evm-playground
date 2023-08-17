---
title: Concatenate string and uint
---

We need to convert `uint` to `String` using `String.sol` (OpenZeppelin) library.

**Code**:

```solidity
// for Foundry
import "openzeppelin-contracts/contracts/utils/Strings.sol";

using Strings for uint256;

function concat(string memory _a, uint _b) internal pure returns (string memory) {
    return string(abi.encodePacked(_a, _b.toString()));
}
```

> NOTE: `abi.encodePacked` function can only concatenate bytes, strings, not numbers.
