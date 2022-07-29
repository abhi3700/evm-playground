// SPDX-License-Identifier: MIT

pragma solidity ^0.8.6;

contract interfaceB{
    function hello() external pure returns(string memory);
}

contract B {
    function hello() external pure returns(string memory) {
        return "hello world";
    }

    function foo() external {
        // whatever
    }
}