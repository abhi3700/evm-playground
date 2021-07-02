// SPDX-License-Identifier: MIT

pragma solidity ^0.8.6;

contract Car {
    bool brake_applied;

    constructor() public { 
        brake_applied = false;          // initialize 
    }
}