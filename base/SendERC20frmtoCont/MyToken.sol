//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "hardhat/console.sol";

contract MyToken is ERC20{
    address public admin;

    constructor() ERC20("My Token", "MTN") {
        _mint(msg.sender, 10_000_000_000 * (10 ** uint256(decimals())));        // 10 B tokens
        admin = msg.sender;
    }

}