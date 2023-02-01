// SPDX-License-Identifier: MIT LICENSE

/* 
    - This code defines a library and contract in the Solidity programming language. 
    - The library, Lib1, contains functions that allow users to store and retrieve data from a storage slot. 
    - The contract, LibWStorage, provides an interface for users to interact with the functions in Lib1. 
    - Specifically, setState() allows users to store an address and string in the storage slot, 
        while getState() allows them to retrieve the address and string stored in the storage slot. 
    - Finally, getPosition() returns the position of the storage slot.
*/

pragma solidity 0.8.13;

library Lib1 {
    struct S1 {
        address a;
        string name;
    }

    function diamondStorage() internal pure returns (S1 storage ds) {
        bytes32 position = keccak256("diamond.standard.diamond.storage");
        assembly {
            ds.slot := position
        }
    }

    function setState(address _addr, string memory _name) internal {
        S1 storage ds = diamondStorage();
        ds.a = _addr;
        ds.name = _name;
    }

    function getState() internal view returns (address, string memory) {
        S1 storage ds = diamondStorage();
        return (ds.a, ds.name);
    }
}

contract LibWStorage {
    function setState(address _addr, string memory _name) external {
        Lib1.setState(_addr, _name);
    }

    function getState() external view returns (address, string memory) {
        return Lib1.getState();
    }

    function getPosition() external pure returns (bytes32) {
        return keccak256("diamond.standard.diamond.storage");
    }
}
