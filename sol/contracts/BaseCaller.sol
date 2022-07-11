//SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import "hardhat/console.sol";
// import "@openzeppelin/contracts/math/SafeMath.sol";


/*
Inter-Contract Execution
- instantiating the contract & calling it's function.
- NOTE: here, source code of "Base contract" should be known beforehand.

Watch Video for understanding:
    - "https://github.com/abhi3700/ethio_playground_videos/blob/main/base_caller_contracts_demo.m4v"

References: 
    - https://gist.github.com/critesjosh/50eb7f243cf960ebf6240fae52c14e63
*/

contract Base {
    
    uint x;
    
    constructor() {
        x = 10;
    }
    
    function setX(uint _x) public returns(bool) {
        x = _x;
        return true;
    }
    
    function getX() public view returns(uint) {
        return x;
    }
}

contract Caller {
    
    function getBaseX(address baseAddress) public view returns(uint) {
        Base baseContract = Base(baseAddress);
        return baseContract.getX();
    }
    
}