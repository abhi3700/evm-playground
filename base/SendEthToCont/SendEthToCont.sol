// SPDX-License-Identifier: MIT

/*

    About
    =====
    - user can invest amount >= 1000 wei
    - get the contract balance
    
    Testing
    =======

    Reference
    =========
    * https://www.youtube.com/watch?v=4k_ak3SFczc
*/


pragma solidity ^0.8.6;

contract SendEthToCont {
    mapping(address => uint256) balances;

    function Invest() external payable {
        if(msg.value < 1000) {
            revert();
        }
        balances[msg.sender] += msg.value;
    }

    function balanceOf() external view returns(uint256) {
        return address(this).balance;
    }
}