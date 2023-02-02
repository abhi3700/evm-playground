//SPDX-License-Identifier: MIT
pragma solidity 0.8.6;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "hardhat/console.sol";


/// @title A ERC20 Token SC
/// @author abhi3700
/// @notice A ERC20 Token
/// @dev A ERC20 token as upgradeable
contract TokenUpgradeable is Initializable, ERC20Upgradeable, OwnableUpgradeable {
    // constructor() ERC20Upgradeable("MyToken", "MTN") {}

    function initialize() external initializer {
        __ERC20_init("MyToken", "MTN");
        __Ownable_init();
    }

    function mint(address to, uint256 amount) external {
        _mint(to, amount);
    }
}
