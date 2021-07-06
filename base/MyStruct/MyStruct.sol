// SPDX-License-Identifier: MIT

/*

    About
    =====
    - declare
    - CRUD
    - exotic mapping-1: Array of struct
    - exotic mapping-2: Mapping of struct
    
    Testing (In each cases, the contract is re-deployed)
    =======

    Reference
    =========
*/


pragma solidity ^0.8.6;

contract MyStruct {
	struct User {
		address addr;
		uint score;
		string name;
	}
	
	User[] users;
	mapping(address => User) userList2;
	// uint mappingLen;	// M-1
	address[] mappingKeyArr;	// M-2


	function setName(address _addr, string calldata n) external {
		User[] storage u = users;
		bool found = false;
		
		for (uint i=0; i<u.length; ++i) {
		    if (u[i].addr == _addr) {           // found
		        u[i].name = n;
		        found = true;
		        break;
		    }
		}
		if (!found) {       // not found
		    u.push(User(_addr, 0, n));
		}
		
	}

	function setScore(address _addr, uint s) external {
		User[] storage u = users;
		bool found = false;
		
		for (uint i=0; i<u.length; ++i) {
		    if (u[i].addr == _addr) {           // found
		        u[i].score = s;
		        found = true;
		        break;
		    }
		}
		if (!found) {       // not found
		    u.push(User(_addr, s, ""));
		}
	}

	function getName(address _addr) external view returns(string memory) {
	    string memory n = "";
		for (uint i=0; i<users.length; ++i) {
		    if (users[i].addr == _addr) {
		        n = users[i].name;
		        break;
		    }
		}
		return n;
	}

	function getScore(address _addr) external view returns(uint) {
	    uint s = 0;
		for (uint i=0; i<users.length; ++i) {
    	    if (users[i].addr == _addr) {
    	        s = users[i].score;
    	        break;
    	    }
		}
		return s;
	}

	function delAddr(address _addr) external {
	    User[] storage u = users;
	    
	    for (uint i=0; i<u.length; ++i) {
	        if (u[i].addr == _addr) {
	            delete u[i];
	            break;
	        }
	    }
	    
	}

	// add the user (with struct) in a mapping with address as key
	// basically, looks like this:
	/*
		{
			"0x52bc44d5378309EE2abF1539BF71dE1b7d7bE3b5": {
					"0x52bc44d5378309EE2abF1539BF71dE1b7d7bE3b5",
					0,
					"abhijit"
			},
			"0xEA674fdDe714fd979de3EdF0F56AA9716B898ec8": {
					"0xEA674fdDe714fd979de3EdF0F56AA9716B898ec8",
					4,
					"ramesh"
			},
		}
	*/
	function addUsertoMap(address _addr) external {
		// check that the address is available inside the users array;
		for(uint i = 0; i < users.length; ++i) {
			if (users[i].addr == _addr) {
				userList2[_addr] = users[i];
				// ++mappingLen;		// M-1
				mappingKeyArr.push(_addr);		// M-2
				break;
			}
		}
	}

	function getNamefromMapping(address _addr) external view returns(string memory) {
		string memory name = "";
		for(uint i=0; i < mappingKeyArr.length; ++i) {
			if(mappingKeyArr[i] == _addr) {
				name = userList2[_addr].name;
				break;
			}
		}

		return name;
	}

	function getScorefromMapping(address _addr) external view returns(uint) {
		uint score = 0;
		for(uint i=0; i < mappingKeyArr.length; ++i) {
			if(mappingKeyArr[i] == _addr) {
				score = userList2[_addr].score;
				break;
			}
		}

		return score;
	}
	
	function getMappingLen() external view returns(uint) {
		// return mappingLen;	// M-1
		return mappingKeyArr.length;	// M-2
	}

}