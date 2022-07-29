// SPDX-License-Identifier: MIT
pragma solidity 0.8.5;

/* 
    Here, inside `setNum()` function, when the element is pushed into the array, 
    before confirming on-chain, the length of the array is increased by 1.
    And then, the 1st id is set as 0, otherwise, it would have been -1 (negative) i.e. unacceptable.

    NOTE: 
        - state variable type doesn't support -ve & decimal.
        - When a transaction is sent to a block all it's actions are considered confirmed i.e. 
        based on which some values can be set like `id` here.
        Either of the action if fails, the whole transaction is failed.

*/

contract TestArray {
    uint256[] private numArr;
    uint256 public id;

    function setNum(uint256 _num) external {
        numArr.push(_num);
        id = numArr.length - 1;
    }

    function getNumArr() external view returns (uint256[] memory) {
        return numArr;
    }
}