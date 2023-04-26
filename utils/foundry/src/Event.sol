// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract Event {
    event Transfer(address indexed from, address indexed to, uint256 amount, bytes32 message);

    function transfer(address from, address to, uint256 amount, bytes32 message) public {
        emit Transfer(from, to, amount, message);
    }

    function transferMany(address from, address[] calldata to, uint256[] calldata amount, bytes32[] calldata purpose)
        public
    {
        for (uint256 i = 0; i < to.length; ++i) {
            emit Transfer(from, to[i], amount[i], purpose[i]);
        }
    }
}
