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

    function getName() public view returns(string memory) {
        return name;
    }

    function sayHello(string memory user ) public {
        hello = string(abi.encodePacked("Hello ", user));
    }


}