// Here, we are setting a signer address (EOA) for the next operation.

// global state variable
Wallet public wallet;

// setup
function setUp() {
    wallet = new Wallet();
}

// set caller for next call
vm.prank(address(0));
wallet.setOwner(address(1));

contract AuthTest is Test {
    Wallet public wallet;

    function setUp() public {
        // console.log("The caller", msg.sender);       // 0x1804c8AB1F12E6bbf3894d4083f33e07309d1f38
        // console.log("This contract", address(this)); // 0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496
        vm.prank(address(1));   // 0x0000000000000000000000000000000000000001
        wallet = new Wallet();  // Wallet@0x522B3294E6d06aA25Ad0f1B8891242E335D3B459 (deployed contract address)
    }

    function testSetOwner() public {
        // console.log("owner", wallet.owner()); // 0x0000000000000000000000000000000000000001
        vm.prank(address(1));   // set caller to 0x01, by default the caller would be `address(this)` i.e. the contract itself - `0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496`
        wallet.setOwner(address(2)); // caller (msg.sender) is 0x01
        assertEq(wallet.owner(), address(2)); // assertion for actual owner address & expected address: 0x02
    }

    function testFailSetOwnerMultiple() public {
        vm.startPrank(address(1));      // set msg.sender to 0x01
        wallet.setOwner(address(1));
        wallet.setOwner(address(1));
        wallet.setOwner(address(1));
        wallet.setOwner(address(1));
        wallet.setOwner(address(1));
        vm.stopPrank();     // till here, the msg.sender is 0x01
        // msg.sender = address(this)
        wallet.setOwner(address(1));  // here, it's back to `address(this)`
    }
}
