// SPDX-License-Identifier: MIT

/*

    About
    =====
    - there are 2 contracts
        - A. this contract has balances of multiple accounts maintained.
        - B. this contract has fallback() & attack() functions
    - get the contract balance of both the contracts
    
    Testing
    =======

    Reference
    =========
    * https://www.youtube.com/watch?v=4Mm3BCyHtDY
*/


pragma solidity ^0.8.6;

contract EtherStore {
    mapping(address => uint256) balances;

    function deposit() external payable {
        if (msg.value < 1 eth) {
            revert();
        }
        balances[msg.sender] += msg.value;
    }


    function withdraw(uint256 _amount) external {
        // ensure balance
        require(balances[msg.sender] >= _amount);

        // send ether to the caller
        // msg.sender.transfer(_amount);    // [DEPRECATED]
        (bool success, ) = msg.sender.call{value:_amount}("");
        require(success, "Transfer failed.");

        // update balances
        balances[msg.sender] -= _amount;
    }

    function balanceOf() external view returns(uint256) {
        return address(this).balance;
    }
}

contract Attack()