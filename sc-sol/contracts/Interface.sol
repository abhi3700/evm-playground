//SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

// import "hardhat/console.sol";


/*
Interface:
    - My article: https://abhi3700.medium.com/smart-contract-eosio-vs-eth-lesson-3-746e77deb3a7

Watch Video for understanding:
    - "https://www.youtube.com/watch?v=tbjyc-VQaQo"

References:


*/

contract Counter {
    
    uint private num;

    function inc() external {
        num += 1;
    }

    function dec() external {
        num -= 1;
    }

    function getNum() external view returns (uint256) {
        return num;
    }
    
}

contract CallInterface {

    function incCounter(address _counterSCAddr) external {
        Counter(_counterSCAddr).inc();
    }

    function decCounter(address _counterSCAddr) external {
        Counter(_counterSCAddr).dec();
    }

    function getCounterNum(address _counterSCAddr) external view returns (uint256) {
        return Counter(_counterSCAddr).getNum();
    }
}