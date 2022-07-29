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

    /**
     * @brief - get back share
     * @details - if i/p: 50, & transferred ether is 200, then, the person get's back only 100 ETH, rest remains with the contract.
     *          - for record, everyone's money deposited is maintained in `balances`.
     * 
     * @param percent - percent can be [0, 100]
     * @return - bool success
     */
    function getBackShare(uint8 share) external payable returns (bool success) {
        require(percent >= 0 && percent <= 100, "percent can\'t be greater than 100");
        (bool success, ) = msg.sender.call{gas: 10000, value: (msg.value * (percent / 100))}(new bytes(0));
        require(success, "Transfer failed.");

        balances[msg.sender] += msg.value * (1 - (percent / 100));
    }


    function sendEther(address payable recipient, uint256 amt) external {
        // transfer 1 ETH from contract to recipient
        // recipient.transfer(1 ether);         // safer than send(), also has gas limit() like send() 

        // here, gas limit can be set to any value 
        (bool success, ) = recipient.call{gas: 4500, value: amt}(new bytes(0));
        require(success, "Transfer failed.");

        // NOTE: there are 3 methods: transfer, send, call
        // The most safe & recommended is `call`
        // Reference: https://solidity-by-example.org/sending-ether/

    }

    function balanceOf() external view returns(uint256) {
        return address(this).balance;
    }
}