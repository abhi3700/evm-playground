/* 
    set timestamp for testing
*/

// SPDX-License-Identifier: MIT
pragma solidity version ^0.8.0;

contract VaultTest is Vault {
    function testDepositFour() public {
        vm.startPrank(alice);

        token.approve(address(acvault), 1e18);
        acvault.deposit(IDepositToken(address(token)), 1e18); // 1st deposit

        console.log("========");
        // NOTE: set timestamp to 2 months later
        vm.warp(block.timestamp + 2 * ONE_MONTH);

        token.approve(address(acvault), 15e18);
        acvault.deposit(IDepositToken(address(token)), 15e18); // 2nd deposit

        console.log("========");
        // NOTE: set timestamp to 3 months later
        vm.warp(block.timestamp + 3 * ONE_MONTH);

        token.approve(address(acvault), 20e18);
        acvault.deposit(IDepositToken(address(token)), 20e18); // 2nd deposit

        console.log("========");
        // NOTE: set timestamp to 4 months later
        vm.warp(block.timestamp + 4 * ONE_MONTH);

        token.approve(address(acvault), 25e18);
        acvault.deposit(IDepositToken(address(token)), 25e18); // 2nd deposit

        vm.stopPrank();
    }
}
