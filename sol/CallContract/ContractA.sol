// SPDX-License-Identifier: MIT

pragma solidity ^0.8.6;

import 'ContractB.sol';

contract A {
    address addressB;

    function setAddress(address _addr) external {
        addressB = _addr;
    }

    function callHello() external view returns(string memory){
        InterfaceB b = InterfaceB(addressB);
        return b.hello();
    }

}