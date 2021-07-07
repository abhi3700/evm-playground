// SPDX-License-Identifier: MIT
/*

    About
    =====
    - create child Contracts
    - store child contract address
    - cast contract pointer to address
    - call functions of child contracts
    - caveat when admin is contract

    Testing
    =======

    Reference
    =========
    - https://www.youtube.com/watch?v=Es0AfhcyXx0
*/

pragma solidity ^0.8.6;

contract LoanFactory {
    Loan[] loans;

    function createLoan() external {
        Loan loan = new Loan(100);
        loan.push(loan);
        // address(this);   // this can be stored in an array

        loan.reimburse();       // loan is a pointer to the below contract 'Loan'
    }

    // this has to be defined, otherwise the withdraw function can't be 
    // called because the contract is the admin now.
    function withdraw() external {
        loan.withdraw();
    }
}

// this gets created from inside above contract
contract Loan {
    uint256 public amount;
    address admin;

    constructor() public {
        amount = _amount;
        admin = msg.sender;         // admin will be the 'LoanFactory' address
    }

    function withdraw() external {

    }

    function reimburse() external {

    }

}