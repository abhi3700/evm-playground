// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Fee {
    /// @dev precision loss. division first
    function caculateLowFee() public pure returns (uint256) {
        uint256 coins = 2;
        uint256 Total_coins = 10;
        uint256 fee = 15;
        return ((coins / Total_coins) * fee);
    }

    /// @dev no precision loss. multiplication first
    function caculateHighFee() public pure returns (uint256) {
        uint256 coins = 2;
        uint256 Total_coins = 10;
        uint256 fee = 15;
        return ((coins * fee) / Total_coins);
    }
}
