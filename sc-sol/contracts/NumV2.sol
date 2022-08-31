//SPDX-License-Identifier: MIT
pragma solidity 0.8.6;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "hardhat/console.sol";

contract NumV2 is Initializable {
    uint256 public num;

    function initialize(uint256 _num) external initializer {
        num = _num;
    }

    function update(uint256 _num) external {
        num = _num;
    }

    function increment() external {
        ++num;
    }
}
