// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

/*

    Delegatecall
    ============
    delegatecall is a low level function similar to call.

    When contract A executes delegatecall to contract B, B's code is excuted

    with contract A's storage, msg.sender and msg.value.


    Source: https://solidity-by-example.org/delegatecall/
*/

// NOTE: Deploy this contract first
contract B {
    // NOTE: storage layout must be the same as contract A
    uint public num;
    address public sender;
    uint public value;      // storing the payable data i.e. amount of Wei sent.

    function setVars(uint _num) public payable {
        num = _num;
        sender = msg.sender;
        value = msg.value;
    }
}

contract A {
    uint public num;
    address public sender;
    uint public value;      // storing the payable data i.e. amount of Wei sent.

    function callDelegate(address _contract, uint _num) public payable returns (bool) {
        // A's storage is set, B is not modified.
        // unused variable can be replace with _ (underscore)
        (bool success, bytes memory data) = _contract.delegatecall(
            abi.encodeWithSignature("setVars(uint256)", _num)
        );

        return success;
    }
}
