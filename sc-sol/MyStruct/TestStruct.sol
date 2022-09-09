//SPDX-License-Identifier: MIT

/* 

    Learning:
        - In case of nesting mapping i.e. mapping of struct with a mapping inside, 
        in order to get info, `storage` has to be used instead of `memory`

*/

pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract TestStruct {
    struct House {
        uint256 lights;
        uint256 fans;
        mapping(uint256 => uint256) accounts;
    }
    mapping(uint256 => House) houses;

    constructor(
        uint256 _houseId,
        uint256 _accountId,
        uint256 _accountVal,
        uint256 _nL,
        uint256 _nf
    ) {
        House storage h = houses[_houseId];
        h.accounts[_accountId] = _accountVal;
        h.lights = _nL;
        h.fans = _nf;
    }

    function getAccount(uint256 _houseId, uint256 _accountId)
        public
        view
        returns (uint256)
    {
        // Type struct TestStruct.House is only valid in storage because it contains a (nested) mapping.
        House memory h = houses[_houseId];
        // House storage h = houses[_houseId];
        return h.accounts[_accountId];
    }
}
