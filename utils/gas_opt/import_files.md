# Import files

## About
* Always import needed functions from a library file.
* Use like this:
```c
// If all functions used
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

// If only few functions used
import {add, sub, mul, div} from "@openzeppelin/contracts/utils/math/SafeMath.sol";
```

## References:
* Follow [this](https://docs.soliditylang.org/en/v0.8.11/layout-of-source-files.html#importing-other-source-files) for different ways to import files in Solidity

