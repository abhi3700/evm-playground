// SPDX-License-Identifier: MIT


/*

    About
    =====
    - declare constructor
    - call other functions
    - call constructor from parent constructor
    
    Testing
    =======

    Reference
    =========
    https://www.youtube.com/watch?v=ADVifGOanVU

*/

pragma solidity ^0.8.6;

contract MyParentConstructor {
    constructor(uint _a) public {
        // do something
    }
}

contract MyConstructor {
    uint256 a;
    address admin;

/*    constructor(uint _a) {
        admin = msg.sender;
        foo();
    }
*/
    constructor(uint _a) MyParentConstructor(_a) {
        // it can be empty
    }


    function foo() external {
        a = 2;
    }
}
