// Here, we have covered both the methods of defining function name that fails
// Refer this for more context: https://github.com/abhi3700/evm_playground/tree/main/libs/foundry#test-function-naming

contract AuthTest is Test {
    Wallet public wallet;

    function setUp() public {
        // console.log("The caller", msg.sender);
        // console.log("This contract", address(this));
        vm.prank(address(1));
        wallet = new Wallet();
    }

    function testSetOwner() public {
        // console.log("owner", wallet.owner());
        vm.prank(address(1));
        wallet.setOwner(address(1));
        assertEq(wallet.owner(), address(1));
    }

    // M-2 used for test function naming in case of failure
    function testSetOwnerbyNonOwner() public {
        vm.prank(address(1));
        wallet.setOwner(address(1));
        vm.expectRevert(); // w/o error message
        // vm.expectRevert(bytes("You are not allowed")); // with an error message
        wallet.setOwner(address(1));
    }

    // M-1 used for test function naming in case of failure
    function testFailSetOwnerMultiple() public {
        vm.startPrank(address(1));
        wallet.setOwner(address(1));
        wallet.setOwner(address(1));
        wallet.setOwner(address(1));
        wallet.setOwner(address(1));
        wallet.setOwner(address(1));
        vm.stopPrank();
        // msg.sender = address(this)
        // no need to use `expectRevert` as we have already prefixed with `testFail`.
        wallet.setOwner(address(1));
    }
}
