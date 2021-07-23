//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "hardhat/console.sol";

/*

Watch Video for understanding:
    - "https://youtu.be/xtDkat5f6Hs"
    - "https://github.com/abhi3700/ethio_playground_videos/blob/main/erc20_pt1.m4v"
    - "https://github.com/abhi3700/ethio_playground_videos/blob/main/erc20_pt2.m4v"

References: 
    - https://www.toptal.com/ethereum/create-erc20-token-tutorial
    - https://www.wealdtech.com/articles/understanding-erc20-token-contracts/
    - https://solidity-by-example.org/app/erc20/
*/

contract ERC20Token is ERC20{
    address public admin;

    // M-1
    constructor() ERC20("My Token", "MTN") {
        _mint(msg.sender, 10_000_000_000 * (10 ** uint256(decimals())));
        admin = msg.sender;
    }

    // M-2
    // constructor(string memory n, string memory s ) ERC20(n, s) {
    //     _name = n;
    //     _symbol = s;
    //     _mint(msg.sender, 10_000_000_000 * (10 ** uint256(decimals())));
    //     admin = msg.sender;
    // }


    function mint(address to, uint256 amount) external {
        require(msg.sender == admin, 'only admin');     // access control
        _mint(to, amount);
    }

    function burn(uint256 amount) external {
        _burn(msg.sender, amount);
    }

}