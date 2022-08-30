//SPDX-License-Identifier: MIT
pragma solidity 0.8.6;

import "hardhat/console.sol";

contract Num {
    uint256 public num;

    constructor(uint256 _num) {
        num = _num;
    }

    function update(uint256 _num) external {
        num = _num;
    }
}
