//SPDX-License-Identifier: MIT

/*

In this contract, inheritance has been demonstrated.
- Contract A has some overideable functions which can be overridden by Contract B during inheritance
- Contract B has some overideable functions which can be overridden by Contract C during inheritance

Video:
https://www.youtube.com/watch?v=Ck5PUwL2D6I
*/

pragma solidity ^0.8.4;


contract A {
	function foo() public virtual returns (string memory) {
		return "A";
	}

	function bar() public virtual returns (string memory) {
		return "A";
	}

	function baz() public pure returns (string memory) {
		return "A";
	}

}

contract B is A {
	function foo() public virtual override pure returns (string memory) {
		return "B";
	}

	function bar() public virtual override pure returns (string memory) {
		return "B";
	}

}

contract C is B {
    function foo() public override pure returns (string memory) {
		return "C";
	}

	function bar() public override pure returns (string memory) {
		return "C";
	}
}
