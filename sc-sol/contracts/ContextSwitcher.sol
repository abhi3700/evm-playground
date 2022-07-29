//SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import "hardhat/console.sol";
// import "@openzeppelin/contracts/math/SafeMath.sol";


/*
Inter-Contract Execution
- call, callcode [DEPRECATED], delegatecall
- DELEGATECALL basically says that I'm a contract and I'm allowing (delegating) you to do whatever you want to my storage. 
    DELEGATECALL is a security risk for the sending contract which needs to trust that the receiving contract will treat the storage well.

    DELEGATECALL was a new opcode that was a bug fix for CALLCODE which did not preserve msg.sender and msg.value. 
    If Alice invokes Bob who does DELEGATECALL to Charlie, the msg.sender in the DELEGATECALL is Alice (whereas if CALLCODE was used the msg.sender would be Bob).

- `call` will make change in the callee contract storage variables (one that is called, A->B, B is callee). 
- `delegatecall` will make change in the caller contract storage variables (one that calls the callee, A->B, A is caller). Used normally in case of deployed libraries.
- For more, refer https://ethereum.stackexchange.com/a/3672/76168

- NOTE: here, source code of "Base contract" is not needed, just its address.

Watch Video for understanding:
    - "https://github.com/abhi3700/ethio_playground_videos/blob/main/context_switcher_contract_demo.m4v"

References: 
    - https://gist.github.com/ConsenSys-Academy/de1b2000f3682f0cfba784d0cb5400e7/b49ed44ad64fd533c09775f9688d615100ad53c1
*/

contract Base {
  uint public num;
  address public sender;

  function setNum(uint _num) public {
    num = _num;
    sender = msg.sender;
    // msg.sender is FirstCaller if invoked by FirstCaller.callSetNum() or FirstCaller.setBaseNum()
    // msg.sender remains unchanged, if invoked by SecondCaller.callThrough() or FirstCaller.delegatecallSetNum()
  }
}

contract FirstCaller {
  uint public num;
  address public sender;

  function setBaseNum(address _base, uint _num) public{
      Base base = Base(_base);
      base.setNum(_num);
      sender = msg.sender;
  }

  function callSetNum(address _base, uint _num) public {
    // M-1
    // (bool status, bytes memory returnData) = _base.call(abi.encodeWithSignature("setNum(uint256)", _num)); // Base's num is set     [DEPRECATED]
    // (bool status, bytes memory returnData) = _base.call(abi.encodePacked(bytes4(keccak256("setNum(uint256)")), _num)); // Base's num is set                as per v0.8.6
    // M-2
    (bool status, ) = _base.call(abi.encodePacked(bytes4(keccak256("setNum(uint256)")), _num)); // Base's num is set                as per v0.8.6
    if (!status) {
        revert();
    }
    sender = msg.sender;
  }

  // [DEPRECATED] as per v0.8.4
/*  function callcodeSetNum(address _base, uint _num) public {
    // M-1
    // (bool status, bytes memory returnData) = _base.callcode(abi.encodeWithSignature("setNum(uint256)", _num)); // Base's num is set     [DEPRECATED]
    // (bool status, bytes memory returnData) = _base.callcode(abi.encodePacked(bytes4(keccak256("setNum(uint256)")), _num)); // Base's num is set                as per v0.8.6
    // M-2
    (bool status, ) = _base.callcode(abi.encodePacked(bytes4(keccak256("setNum(uint256)")), _num)); // Base's num is set                as per v0.8.6
    if (!status) {
        revert();
    }
    sender = msg.sender;
  }
*/
  function delegatecallSetNum(address _base, uint _num) public {
    // M-1
    // (bool status, bytes memory returnData) = _base.delegatecall(abi.encodeWithSignature("setNum(uint256)", _num)); // Base's num is set
    // (bool status, bytes memory returnData) = _base.delegatecall(abi.encodePacked(bytes4(keccak256("setNum(uint256)")), _num)); // Base's num is set        as per v0.8.6
    // M-2
    (bool status, ) = _base.delegatecall(abi.encodePacked(bytes4(keccak256("setNum(uint256)")), _num)); // Base's num is set        as per v0.8.6
    if (!status) {
        revert();
    }
    sender = msg.sender;
  }
}

contract SecondCaller {
    function callThrough(FirstCaller _fc, Base _base, uint _num) public {
        _fc.delegatecallSetNum(address(_base), _num);
    }
}