//SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "hardhat/console.sol";


contract ERC20Token is ERC20{
    address public admin;

    constructor() ERC20("My Token", "MTN") {
        _mint(msg.sender, 1000000 * (10 ** uint256(decimals())));
        admin = msg.sender;
    }


    function mint(address to, uint256 amount) external {
        require(msg.sender == admin, 'only admin');     // access control
        _mint(to, amount);
    }

    function burn(uint256 amount) external {
        _burn(msg.sender, amount);
    }

}