// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

contract SetGet {
	uint value;

	function getValue() external view returns(uint) {
		return value;
	}

	function setValue(uint _value) external {
		value = _value;
	}
}

