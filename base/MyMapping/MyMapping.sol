// SPDX-License-Identifier: MIT

/*

    About
    =====
    - declare
    - CRUD
    - exotic mapping-1: nested mappings 
    - exotic mapping-2: array inside mapping
    
    Testing (In each cases, the contract is re-deployed)
    =======

    Reference
    =========
*/


pragma solidity ^0.8.6;

contract MyMapping {
	mapping(address => uint) balances;

	// an address has mappings of address with approved status (bool)
	/*
		{
			"0x3432sfsd...": {
				"0x3fwe245...": 1,
				"0x4df435d...": 0
			},
			"0x73232sfsd...": {
				"0x783264832we245...": 1,
				"4ew32f435d...": 0
			}

		}
	*/
	mapping(address => mapping(address => bool)) approved;
	mapping(address => uint[]) scores;			

	function addBalance(address addr, uint val) external {
		if (balances[addr] != 0) {
			balances[addr] += val;
		} else {
			balances[addr] = val;
		}
	}

	function subBalance(address addr, uint val) external {
		if (balances[addr] != 0) {
			balances[addr] -= val;
		}
	}

	function getBalance(address addr) external view returns(uint) {
		return balances[addr];
	}

	function delAddr(address addr) external {
		if (abi.encodePacked(balances[addr]).length > 0) {
			delete balances[addr];
		}
	}


	// exotic mapping-1
	// C- create, U- update
	function setSpenderStatus(address addr, address sp, bool status) external {
		approved[addr][sp] = status;
	}

	// R- Read
	function getSpenderStatus(address addr, address sp) external view returns(bool) {
		if (abi.encodePacked(approved[addr][sp]).length > 0) {
			return approved[addr][sp];
		}
		return false;
	}

	// D- Delete
	function delSpender(address addr, address sp) external {
		if (abi.encodePacked(approved[addr][sp]).length > 0) {
			delete approved[addr][sp];
		}
	}

	// exotic mapping-2
	// C- create, U- update
	function setScore(address addr, uint sc) external {
		scores[addr].push(sc);
	}

	// R- Read
	function getScore(address addr) external view returns(uint[] memory) {
		return scores[addr];
	}

	// D- Delete
	function delScore(address addr) external {
		if (abi.encodePacked(scores[addr]).length > 0) {
			delete scores[addr];
		}
	}


}