---
title: How to check if a function exists in Solidity contract
---

```solidity
function checkIfFunctionExist(address _contract, string memory functionSignature) public pure returns (bool) {
    (bool exist, ) = _contract.call(abi.encodeWithSignature(functionSignature));

    return exist;
}
```
