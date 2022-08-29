//SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import "hardhat/console.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";


/*
* Shown Reentrancy Attack
* Remediations
    - Checks-Effects-Interactions (order of execution: Internal storage variables >> External call)
    - Use OpenZeppelin ReentrancyGuard modifier

Watch Video for understanding:
    - "https://github.com/abhi3700/ethio_playground_videos/blob/main/simple_dao_reentrancy_contract_demo.m4v"
    - "https://github.com/abhi3700/ethio_playground_videos/blob/main/reentrancy_attack_demo.m4v"

References: 
    - https://blog.openzeppelin.com/reentrancy-after-istanbul/
*/

contract SimpleDAO is ReentrancyGuard {
    mapping( address => uint256 ) balances;
    address public admin;

    constructor() {
        admin = msg.sender;
    }

    function donate() external payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 _amount) external nonReentrant() {
        require(balances[msg.sender] >= _amount, "Insufficient balance");

        // Code snippet with reentrancy attack

        // (bool success, ) = msg.sender.call{gas: 10000, value:_amount}(new bytes(0));
        // require(success, "Transfer failed.");        
        // balances[msg.sender] -= _amount;

        // Code snippet with reentrancy attack solved.
        balances[msg.sender] -= _amount;
        (bool success, ) = msg.sender.call{gas: 10000, value:_amount}(new bytes(0));
        require(success, "Transfer failed.");        
    } 

    function balanceOf(address _addr) external view returns(uint256) {
        return balances[_addr];
    }

}