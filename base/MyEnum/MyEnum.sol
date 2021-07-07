// SPDX-License-Identifier: MIT
/*

    About
    =====
    - declare enum
    - parse as uint. E.g. for INACTIVE, parse 0
    
    Testing
    =======

    Reference
    =========
    * https://www.youtube.com/watch?v=5ED_6FasZ68
*/

pragma solidity ^0.8.6;

contract MyEnum {
    enum STATE {
        INACTIVE, ACTIVE, PRO, CANCELLED
    }

    STATE state;

    struct User {
        STATE state;
    }

    function setToActive() external {
        state = STATE.ACTIVE;
    }

    function foo() external view {
        if (state == STATE.ACTIVE) {
            // do something
        }
    }
    
    function setState(STATE _s) external {
        state = _s;
    }
    
    function getState() external view returns(STATE) {
        return state;
    }

}