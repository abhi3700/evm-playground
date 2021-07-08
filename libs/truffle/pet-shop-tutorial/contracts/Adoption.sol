// SPDX-License-Identifier: MIT
/*

    About
    =====
    - add max 16 pets into the storage variable        

    Testing
    =======

    Reference
    =========
    * https://www.youtube.com/watch?v=r4yKide6jiU
*/

pragma solidity ^0.8.6;

contract Adoption {
    address[16] public adopters;        // max 16, so defined

    function adopt(uint256 petID) external returns(uint256) {
        require(petID >= 0 && petID <= 15, "pet id must be between 0 and 15");

        adopters[petID] = msg.sender;

        return petID;       // indicate success
    }

    function getAdopters() external view returns(address[16] memory) {
        return adopters;
    }

}