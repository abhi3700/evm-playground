// SPDX-License-Identifier: MIT
/*

    About
    =====
    1. assembly syntax
    2. read and store data
    3. Assembly eg 1: detect if addres is a smart contract
    4. Assembly eg 2: cast bytes to bytes32

    
    Testing
    =======

    Reference
    =========
    * https://www.youtube.com/watch?v=r4yKide6jiU
*/

pragma solidity ^0.8.6;

contract A {
    function foo() external {
        uint a;
        uint b;
        uint c;

        // slot 1, slot 2, slot 3
        c = a + b;

        uint size;
        address addr = msg.sender;

        assembly { 
            c := add(1, 2)

            // 2.
            let a := mload(0x40)        // load the next available slot
            mstore(a, 2)        // temporary
            sstore(a, 10)       // persisted

            // 3.
            size := extcodesize(addr)
        }

        // 3. detect if address is a smart cotnract
        if (size > 0) {
            return true;
        } else {
            return false;
        }

        // 4.
        bytes memory data = new bytes(10);

        // bytes32 dataB32 = bytes32(data);     // not allowed bcoz 10*32

        assembly {
            // fetch the 2nd slot, So add(), shift by 32 bytes. 1st slot is reserved for size of bytes
            dataB32 := mload(add(data, 32))
        }
    }
}