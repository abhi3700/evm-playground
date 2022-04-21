// addr1 transfer 3 wei to contract
// Here, `depositFor` is a payable function with these arguments: payee, releaser
await expect(
    escrowContract.connect(addr1).depositFor(addr2.address, addr3.address, { value: 3 }))
    .to.emit(escrowContract, "DepositedFor")
    .withArgs(addr1.address, addr2.address, addr3.address, 3);

const escrowId = await escrowContract.getEscrowId();
await expect(escrowId).to.eq(1);
