/* 
    
    In Solidity, you can represent 0.1% using fixed-point arithmetic with an appropriate scaling factor. 
    Solidity does not have native support for floating-point numbers, so you'll need to work with integers and adjust the scale accordingly.

    Here's an example of how you could represent 0.1% as a state variable in a Solidity contract.

    In this example, we use a scaling factor of 100,000 to represent percentages as integers. 
    The constant POINT_ONE_PERCENT represents 0.1% and is calculated as SCALING_FACTOR / 1000. 
    The calculatePercentage function demonstrates how you can apply the 0.1% to a given amount using integer arithmetic.
*/
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Percentage {
    uint256 private constant SCALING_FACTOR = 100000; // This represents 100% (1 in decimal representation)
    uint256 public constant POINT_ONE_PERCENT = SCALING_FACTOR / 1000; // This represents 0.1% (0.001 in decimal representation)

    // Function to demonstrate usage of 0.1% representation
    function calculatePercentage(uint256 amount) public pure returns (uint256) {
        return (amount * POINT_ONE_PERCENT) / SCALING_FACTOR;
    }
}
