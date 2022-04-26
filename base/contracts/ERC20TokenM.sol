//SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "hardhat/console.sol";


/// @title A ERC20 Token SC
/// @author abhi3700
/// @notice A ERC20 Token
/// @dev A ERC20 token as pre-minted during deployment
contract StableCoin is ERC20, Ownable, Pausable {
    constructor(
        string memory name,
        string memory symbol,
        uint256 initialSupply
    ) ERC20(name, symbol) {
        _mint(msg.sender, initialSupply);
    }
}
