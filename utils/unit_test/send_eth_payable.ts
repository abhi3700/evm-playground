/* 
    This is a situation where a payer deposit some money to an escrow contract with info: payee, releaser.
    Only assigned releaser can release the money to the payee.

    So, in order to receive ETH from the payer, the function - `depositFor` is defined as payable.

    This is the unit test for doing simulating this locally.
*/


// addr1 transfer 3 wei to contract
// Here, `depositFor` is a payable function with these arguments: payee, releaser
await expect(
    escrowContract.connect(addr1).depositFor(addr2.address, addr3.address, { value: 3 }))
    .to.emit(escrowContract, "DepositedFor")
    .withArgs(addr1.address, addr2.address, addr3.address, 3);

const escrowId = await escrowContract.getEscrowId();
await expect(escrowId).to.eq(1);
