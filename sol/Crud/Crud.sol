// SPDX-License-Identifier: MIT

pragma solidity ^0.8.6;

contract Crud {
	uint[] myArray;

	function create(uint e) external {
		myArray.push(e);
	}

	function read() external view returns(uint) {
		return myArray.length;
	}
}