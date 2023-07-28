// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Counter.sol";

contract Yul1Test is Test {
    Counter public counter;

    function setUp() public {
        counter = new Counter();
        assertEq(counter.count(), 20);
    }

    function testIncrement() public {
        counter.increment();
        assertEq(counter.count(), 21);
        counter.increment();
        assertEq(counter.count(), 22);
    }

    function testDecrement() public {
        counter.decrement();
        assertEq(counter.count(), 19);
        counter.decrement();
        assertEq(counter.count(), 18);
    }

    function testSet() public {
        counter.set(100);
        assertEq(counter.count(), 100);
    }

    function testReset() public {
        counter.reset();
        assertEq(counter.count(), 0);
    }
}
