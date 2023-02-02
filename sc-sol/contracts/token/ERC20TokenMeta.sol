// SPDX-License-Identifier: MIT

pragma solidity 0.8.6;

import "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/// @title A ERC20 Token SC
/// @author abhi3700
/// @notice A ERC20 Token
/// @dev A ERC20 token with metadata: name, symbol, decimals
contract Token is ERC20 {
    uint8 private immutable customDecimals;

    constructor(
        string memory _erc20Name,
        string memory _erc20Symbol,
        uint8 _decimals
    ) ERC20(_erc20Name, _erc20Symbol) {
        customDecimals = _decimals;
    }

    function decimals() public view override returns (uint8) {
        return customDecimals;
    }
}
