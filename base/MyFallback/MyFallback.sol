// SPDX-License-Identifier: MIT
/*

    About
    =====
    - receive Ether w/o any function
    - fallback (if there is no other function)
    - declare fallback function
    - difference with regular functions
    - send some data
    - send some Ether
    - Gas stipend
    - Reject incoming calls
    - E.g. 1: Call function that does not exist
    - E.g. 2: Send Ether from regular address
    - E.g. 3: Send Ether from smart contract

    
    Testing
    =======

    Reference
    =========
    * https://www.youtube.com/watch?v=5fjJxjX3vV0
*/

pragma solidity ^0.8.6;

contract A {
    // only 1 fallback function is possible
    // no arg can't be parsed within bracket
    // only visibility is external
    function() payable external  {
        bytes msg.data;
        // uint, bool
        // assembly 

        revert('');     // for rejecting calls
        
        // for filtering
        if (msg.data.length > 0) {
            revert('');
        }
    }

}

contract B {
    function foo() external {
        A a = new A();
        InterfaceA(address(a)).doesNotExist();

        // Send Ether from Smart Contract
        address payable a_payable = address(uint160(address(a)));
        a_payable.transfer(1 Ether);

    }
}

contract InterfaceA {
    function doesNotExist() external;
}