// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.13;

contract Storage {
    uint256 public num;

    constructor() {
        num = 20;
    }

    function set(uint256 _num) public {
        num = _num;
    }

    // function get() public view returns (uint256) {
    //     return num;
    // }
}
