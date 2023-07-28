// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.18;

import "forge-std/console.sol";

contract Yul1 {
    /// @dev Simple Add operation
    function add(uint256 x, uint256 y) public pure returns (uint256) {
        // consumes: 5485 gas
        assembly {
            let result := add(x, y)
            mstore(0x0, result)
            return(0x0, 32)
        }

        // consumes: 5506 gas
        // assembly {
        //     z := add(x, y)
        // }

        // solidity
        // z = x + y;
    }

    /// @dev Simple Sub operation
    // consumes 5554 (w/o z) & 5562 (w/ z) gas
    // function sub(uint256 x, uint256 y) public pure returns (uint256 z) {
    //     assembly {
    //         if gt(y, x) {
    //             z := sub(y, x) // gas: 8
    //             mstore(0x0, z)
    //             return(0x0, 32)
    //         }
    //         if gt(x, y) {
    //             z := sub(x, y) // gas: 8
    //             mstore(0x0, z)
    //             return(0x0, 32)
    //         }
    //     }
    // }

    // consumes 5554 (w/o z) & 5562 (w/ z) gas
    function sub(uint256 x, uint256 y) public pure returns (uint256) {
        assembly {
            switch gt(y, x)
            case true {
                // z := sub(y, x) // gas: 8
                mstore(0x0, sub(y, x))
                return(0x0, 32)
            }
            case false {
                // z := sub(x, y) // gas: 8
                mstore(0x0, sub(x, y))
                return(0x0, 32)
            }
        }
    }

    /// @dev Simple Add & then Mul operation
    function addMul(uint256 x, uint256 y) public pure returns (uint256 z) {
        assembly {
            z := mul(add(x, y), 7)
        }
    }

    /// @dev Simple Add & then Div operation
    function addDiv(uint256 x, uint256 y) public pure returns (uint256 z) {
        assembly {
            z := div(add(x, y), 7)
        }
    }

    // TODO:
    // - Add log, pow, and other arithmetic operations ??
    // - Here, add(), sub() internal functions can be used inside addMul, addDiv ??
}
