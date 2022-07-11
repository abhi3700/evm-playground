// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

contract Hello {
    address public owner;
    string public hello;
    string public name;

    constructor() { 
        owner = msg.sender;
        // hello = "Hello world";
    }

    function setName(string memory _name) public {
        name = _name;
    }

    function sayHello(string memory user ) external {
        hello = string(abi.encodePacked("Hello ", user));
    }


}