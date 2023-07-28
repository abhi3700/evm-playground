// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Yul1.sol";

contract Yul1Test is Test {
    Yul1 public yul1;

    function setUp() public {
        yul1 = new Yul1();
    }

    function testAdd() public {
        uint256 y1 = yul1.add(1, 2);
        assertEq(y1, 3);
    }

    function testSub() public {
        uint256 y1 = yul1.sub(2, 1);
        assertEq(y1, 1);
    }

    // function testAddMul() public {
    //     uint256 y1 = yul1.addMul(1, 2);
    //     assertEq(y1, 21);
    // }

    // function testAddDiv() public {
    //     uint256 y1 = yul1.addDiv(1, 2);
    //     assertEq(y1, 0);
    // }
}
