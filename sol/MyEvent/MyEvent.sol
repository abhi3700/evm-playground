// SPDX-License-Identifier: MIT
/*

    About
    =====
    - declare event
    - emit event
    
    Testing
    =======

    Reference
    =========
    * https://www.youtube.com/watch?v=jaMHPT-78HM
*/

pragma solidity ^0.8.6;

contract MyEnum {
    event NewTrade(
        uint date,
        address from,
        address to,
        uint256 amount
    );

    function trade(address to,  uint256 amount) external {
        emit NewTrade(block.timestamp, msg.sender, to, amount);
    }
}