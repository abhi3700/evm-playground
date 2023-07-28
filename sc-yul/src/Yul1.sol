// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.18;

contract Yul1 {
    /// @dev Simple Add operation
    function add(uint256 x, uint256 y) public pure returns (uint256 z) {
        assembly {
            z := add(x, y)
        }
    }

    /// @dev Simple Sub operation
    function sub(uint256 x, uint256 y) public pure returns (uint256 z) {
        assembly {
            if lt(x, y) { revert(0, 0) }
            z := sub(x, y)
        }
    }

    /// @dev Simple Add & then Mul operation
    function addMul(uint256 x, uint256 y) public pure returns (uint256 z) {
        assembly {
            z := mul(add(x, y), 7)
        }
    }
}
