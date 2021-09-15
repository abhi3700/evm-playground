// SPDX-License-Identifier: MIT License
pragma solidity ^0.8.0;

/*
Title: Family Tree
Description: Create a family tree with each family having many children with attribute like eth_address, name, home_address, age.
Image: ./FamilyTree.png
Implementation:
=====
Mapping of key/value
    - key: address
    - value: array of struct

Lesson:
======
    - if `bytes32` is used instead of `string`, then it doesn't accept value like this:
    ```
    380 FF, Sector 86
    ```
    Reason: Not accepted: empty space ' 
    Reference: https://stackoverflow.com/a/50282529/6774636
*/

contract Family {
    struct Children {
        address addr;
        string name;
        string homeAddress;
        uint256 age;
    }

    mapping(address => Children[]) public family;
    
    // @notice Add children to a family
    function addChildren(
        address familyAddr, 
        address childrenAddr,
        string memory childrenName,
        string memory childrenHomeAddress,
        uint256 childrenAge
    ) external {
        Children[] memory c = new Children[](1);
        c[0].addr = childrenAddr;
        c[0].name = childrenName;
        c[0].homeAddress = childrenHomeAddress;
        c[0].age = childrenAge;
        family[familyAddr].push(c[0]);
    }
    
    // @notice Get a children details of a family
    function getChildren(address familyAddr, uint256 childrenNo) public view returns (Children memory) {
        return family[familyAddr][childrenNo];
    }
}