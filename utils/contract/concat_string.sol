// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract AbiEncodings {
    string public hello;

    /// Use encodePacked.
    function sayHello(string memory user) public {
        hello = string(abi.encodePacked("Hello ", user)); // "Hello {user}"
    }
}
