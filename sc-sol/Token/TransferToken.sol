// SPDX-License-Identifier: MIT


/*

    About
    =====
    - import ERC20 token
    - learn to use the ERC20 token defined functions
    - transfer()
    - transferFrom()/ approve()
    
    Testing (In each cases, the contract is re-deployed)
    =======

    Reference
    =========
    https://www.youtube.com/watch?v=-5j6Ho0Bkfk

*/

pragma solidity ^0.8.6;

import 'Token.sol';

contract TransferToken {

    function transfer() external {
        Token t = Token(0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB);            // contract address of ERC token
        t.transfer(msg.sender, 100);        // transfers token to a recipient (whoever calls this function)
    }

    function transferFrom(address recipient, uint256 amount) external {
        Token t = Token(0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB);            // contract address of ERC token
        t.transferFrom(msg.sender, recipient, amount);
    }

}


// another contract 'Owner' which calls functions of contract 'TransferToken', approve the contract 'TransferToken' to transfer some amount which can't be exceeded.
// And then, the `transferFrom()` can be called with an amount <= set approved_amount
// Approval is used in 'DEX', where an amount is authorized to trade.

contract Owner {
    function approve(address recipient, uint256 amount) external {
        Token t = Token(0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB);            // contract address of ERC token
        t.approve(0xEA674fdDe714fd979de3EdF0F56AA9716B898ec8, amount);          // address of TransferToken

        TransferToken t2 = TransferToken(0xEA674fdDe714fd979de3EdF0F56AA9716B898ec8)
        t.transferFrom(recipient, amount);
    }
}