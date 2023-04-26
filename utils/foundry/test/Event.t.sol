// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "forge-std/console.sol";
import "forge-std/Test.sol";
import {Event} from "src/Event.sol";

contract EventTest is Test {
    Event public e;

    // redeclared event
    event Transfer(address indexed from, address indexed to, uint256 amount, bytes32 purpose);

    function setUp() public {
        e = new Event();
    }

    // this function checks for all 3 indexed params & data
    function testEmitTransferEvent() public {
        // tell foundry which data to check for
        // (index_instruct, index_instruct, index_instruct, rest_data_check_instruct)
        vm.expectEmit(true, true, false, true);

        // emit the expected event
        emit Transfer(address(1), address(2), 100, bytes32("fun"));

        // call the function that should emit the actual event
        e.transfer(address(1), address(2), 100, bytes32("fun"));
    }

    // this function checks for only 1st index i.e. would return no error even when
    // the 2nd, 3rd params are not matching.
    function testEmitTransferEventOnly1param() public {
        vm.expectEmit(true, false, false, false);
        emit Transfer(address(1), address(2), 100, bytes32("fun1"));
        e.transfer(address(1), address(3), 104, bytes32("fun1"));
    }

    function testEmitManyTransferEvent() public {
        address[] memory to = new address[](2);
        to[0] = address(123);
        to[1] = address(456);

        uint256[] memory amounts = new uint256[](2);
        amounts[0] = 777;
        amounts[1] = 999;

        bytes32[] memory purposes = new bytes32[](2);
        purposes[0] = bytes32("funding");
        purposes[1] = bytes32("meal");

        for (uint256 i = 0; i < to.length; ++i) {
            vm.expectEmit(true, true, false, true);
            emit Transfer(address(1), to[i], amounts[i], purposes[i]);
            e.transfer(address(1), to[i], amounts[i], purposes[i]);
        }
    }
}
