//SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

contract CrowdFunding {
    // Defines a new type with two fields.
    struct Funder {
        address addr;
        uint256 amount;
    }

    struct Campaign {
        address payable beneficiary;
        uint256 fundingGoal;
        uint256 numFunders;
        uint256 amount;
        mapping (uint256 => Funder) funders;
    }

    uint256 public numCampaigns;
    mapping (uint256 => Campaign) public campaigns;

    function newCampaign(address payable _beneficiary, uint256 _goal) public returns (uint256) {
        uint256 campaignID = ++numCampaigns; // campaignID is return variable
        // Creates new struct and saves in storage. We leave out the mapping type.
        Campaign storage c = campaigns[campaignID]; 
        
        c.beneficiary = _beneficiary;
        c.fundingGoal = _goal;
        c.numFunders = 0;
        c.amount = 0;

        return campaignID;
    }

    function contribute(uint256 campaignID) public payable {
        Campaign storage c = campaigns[campaignID];
        // Creates a new temporary memory struct, initialised with the given values
        // and copies it over to storage.
        // Note that you can also use Funder(msg.sender, msg.value) to initialise.
        c.funders[c.numFunders++] = Funder({addr: msg.sender, amount: msg.value});
        c.amount += msg.value;
    }

    function checkGoalReached(uint256 campaignID) public returns (bool reached) {
        Campaign storage c = campaigns[campaignID];
        if (c.amount < c.fundingGoal)
            return false;
        uint256 amount = c.amount;
        c.amount = 0;
        c.beneficiary.transfer(amount);
        return true;
    }
}