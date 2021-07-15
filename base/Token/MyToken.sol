//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.6;

import "hardhat/console.sol";

/*
    It's not an ERC20 token.
    Just for fun!
*/

contract MyToken {
    address public owner;
    bytes32 public name;
    bytes32 public symbol;
    uint256 public totalSupply;
    mapping(address => uint256) balances;

    // event Transfer(address, uint256);

    constructor(bytes32 _name, bytes32 _symbol, uint256 _totalSupply) {
        owner = msg.sender;
        name = _name;       // "Niwas Token"
        symbol = _symbol;      // "NT"
        totalSupply = _totalSupply;
        balances[msg.sender] = _totalSupply;
        console.log("Deploying a Token with name: %s, symbol: %s, supply: %s", _name, _symbol, _totalSupply);
    }

    function Transfer(address _addr, uint256 _amount) public {
        require(balances[owner] >= _amount, "Not enough tokens");
        console.log("Transferring %s tokens from '%s' to '%s'", abi.encodePacked(_amount), abi.encodePacked(owner), abi.encodePacked(msg.sender));
        balances[owner] -= _amount;
        balances[msg.sender] += _amount;
    }

    function balanceOf(address _addr) external view returns (uint256) {
        return balances[_addr];
    }

}
