// SPDX-License-Identifier: MIT

pragma solidity 0.8.6;

import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";

/// @title A Cappped ERC20 Token SC
/// @author abhi3700
/// @notice A Capped ERC20 Token
/// @dev A ERC20 token as capped supply during deployment premint some addresses which gives `totalSupply` <= _cap. Also, custom decimal
contract Token is ERC20Capped {
    uint8 private immutable customDecimals;

    constructor(
        string memory _erc20Name,
        string memory _erc20Symbol,
        uint8 _decimals,
        uint256 _cap,
        address[] memory _mintAddresses,
        uint256[] memory _mintAmounts
    ) ERC20(_erc20Name, _erc20Symbol) ERC20Capped(_cap) {
        require(_mintAddresses.length == _mintAmounts.length, "must have same number of mint addresses and amounts");

        customDecimals = _decimals;

        for (uint i; i < _mintAddresses.length; i++) {
            require(_mintAddresses[i] != address(0), "cannot have a non-address as reserve");
            ERC20._mint(_mintAddresses[i], _mintAmounts[i]);
        }

        require(_cap >= totalSupply(), "total supply of tokens cannot exceed the cap");
    }

    function decimals() public view override returns (uint8) {
        return customDecimals;
    }
}
