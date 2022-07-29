// SPDX-License-Identifier: MIT
/*

    About
    =====
    - modifier syntax
    - passing arguments
    - chaining modifiers
    - example for access control
    
    Testing
    =======

    Reference
    =========
    * https://www.youtube.com/watch?v=RobaQulUzsY
*/

pragma solidity ^0.8.6;

contract MyModifier {

    uint a;
    function foo(uint _a) external myModifier1(_a) myModifier2(_a) {
        // executed after modifier 1 & 2
    }

    // by default internal
    modifier myModifier1() {
        require(admin == msg.sender, "only admin");
        _;
    }

    modifier myModifier2() {
        require(a == 1, "my error message");
        _;
    }

}