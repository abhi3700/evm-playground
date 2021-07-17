//SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

import "hardhat/console.sol";
// import "@openzeppelin/contracts/math/SafeMath.sol";


/*
References: 
    - https://ethereumdev.io/interact-with-other-contracts-from-solidity/
*/

contract Counter {
    // using SafeMath for uint256;

    uint256 private _count;
    address private _owner;
    address private _factory;

    constructor(address owner) {
        _owner = owner;
        _factory = msg.sender;
    }

    modifier onlyOwner(address caller) {
        require(_owner == caller, "You're not the owner of the contract.");
        _;
    }

    modifier onlyFactory() {
        require(_factory == msg.sender, "You need to user the factory.");
        _;
    }

    function getCount() public view returns(uint256) {
        return _count;
    }

    function increment(address caller) public onlyFactory() onlyOwner(caller) {
        ++_count;
    }

}

contract FactoryContract {
    mapping( address => Counter ) _counters;

    /*
    check if the person already owns a counter. If he does not own a counter we instantiate a new counter 
    by passing his address to the Counter constructor and assign the newly created instance to the mapping.
    */
    function createCounter() public {
        require(_counters[msg.sender] == Counter(address(0)));
        _counters[msg.sender] = new Counter(msg.sender);
    }

    function increment(address account) public {
        require(_counters[account] != Counter(address(0)));          // check that it has a Counter contract
        _counters[account].increment(account);
    }

    // count of any address
    function getCount(address account) public view returns (uint256) {
        require(_counters[account] != Counter(address(0)));          // check that it has a Counter contract
        return _counters[account].getCount();
    }

    // it refers to the above function, so no need to write twice.
    // only the caller's count
    function getMyCount() public view returns (uint256) {
        return getCount(msg.sender);
    }
}