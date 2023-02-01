// SPDX-License-Identifier: MIT LICENSE

/* 
    DOCUMENTATION:
    - This code defines a library and contract in the Solidity programming language. 
    - The library, Lib1, contains functions that allow users to store and retrieve data from a storage slot 
        determined by the keccak256 hash of "diamond.standard.diamond.storage". 
    - The contract, LibWStorage, provides an interface for users to interact with the functions in Lib1. 
    - Specifically, setState() allows users to store an address and string in the storage slot, 
        while getState() allows them to retrieve the address and string stored in the storage slot. 
    - Finally, getPosition() returns the position of the storage slot.
*/

pragma solidity 0.8.13;

/// this library can be deployed separately though.
library Lib1 {
    /// data storage maintained in the diamond storage slot instead of
    struct S1 {
        address a;
        string name;
    }

    /// returns the keccak256 hash of "diamond.standard.diamond.storage"
    function diamondStorage() internal pure returns (S1 storage ds) {
        bytes32 position = keccak256("diamond.standard.diamond.storage");
        assembly {
            ds.slot := position
        }
    }

    /// @param _addr address to be stored
    /// @param _name name to be stored
    function setState(address _addr, string memory _name) internal {
        S1 storage ds = diamondStorage();
        ds.a = _addr;
        ds.name = _name;
    }

    /// @dev get the state of the address and string
    /// @return returns the address and string
    function getState() internal view returns (address, string memory) {
        S1 storage ds = diamondStorage();
        return (ds.a, ds.name);
    }
}

contract LibWStorage {
    /// @notice Just interact with the contract with having the data maintained in a separate library.
    /// @dev set the state of the address and string w/o having any state variables inside the contract
    function setState(address _addr, string memory _name) external {
        Lib1.setState(_addr, _name);
    }

    /// @dev calling the `getState` function of library `Lib1`
    function getState() external view returns (address, string memory) {
        return Lib1.getState();
    }

    /// @dev returns the position of the storage slot
    function getPosition() external pure returns (bytes32) {
        return keccak256("diamond.standard.diamond.storage");
    }
}
