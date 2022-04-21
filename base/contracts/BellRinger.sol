//SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract BellRinger {
    // counter of how many times the bell rung
    uint256 public bellRung;

    // event for ringing a bell
    event BellRung(uint256 rangForTheNthTime, address whoRangIt);

    // Ring the bell
    function ringTheBell() public {
        bellRung++;

        emit BellRung(bellRung, msg.sender);
    }

    
}
