---
title: Use ERC20 safe methods for token transfers
---

If **OpenZeppelin** used, then do like this:

```solidity
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract MyVault {
    using SafeERC20 for IERC20;

    IERC20 public token;

    constructor(address _tokenAddress) {
        token = IERC20(_tokenAddress);
    }

    function transferTokens(address recipient, uint256 amount) public {
        token.safeTransfer(recipient, amount);
    }

    // Other functions and logic for your vault contract
}
```

---

If **Solmate** used, then do like this:

````solidity

```solidity
pragma solidity ^0.8.0;

import {ERC20} from "solmate/tokens/ERC20.sol";
import {SafeTransferLib} from "solmate/utils/SafeTransferLib.sol";

contract MyVault {
    using SafeTransferLib for ERC20;

    ERC20 public token;

    constructor(address _tokenAddress) {
        token = ERC20(_tokenAddress);
    }

    function transferTokens(address recipient, uint256 amount) public {
        token.safeTransfer(recipient, amount);
    }

    // Other functions and logic for your vault contract
}
````
