// SPDX-License-Identifier: MIT

/*

    About
    =====
    - user can receive amount from contract
    - get the contract balance
    
    Testing
    =======

    Reference
    =========
    * https://www.youtube.com/watch?v=_Nvl-gz-tRs
    * https://ethereum.stackexchange.com/a/19343/76168
*/


pragma solidity ^0.8.6;

contract SendEthfrmCont {
    mapping(address => uint256) balances;

    function Invest() external payable {
        if(msg.value < 1 ether) {      // accepts amount >= 1 ether
            revert();
        }
        balances[msg.sender] += msg.value;
    }


    function sendEther(address payable recipient, uint256 amt) external {
        // transfer 1 ETH from contract to recipient
        // recipient.transfer(1 ether);         // [NOT Recommended]

        (bool success, ) = recipient.call{value:amt}("");
        require(success, "Transfer failed.");    
    }

    function balanceOf() external view returns(uint256) {
        return address(this).balance;
    }
}