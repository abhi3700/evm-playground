/* 
    This is to verify that the receiver's ETH balance has increased by transferred amount
*/

// payee's balance before release
const provider = ethers.provider;
const balanceInEthBefore = await provider.getBalance(addr2.address);

// addr3 release amount to payee
await expect(escrowContract.connect(addr3).release(escrowId))
    .to.emit(escrowContract, "Released")
    .withArgs(addr2.address, addr3.address, 3);

// payee's balance after release
const balanceInEthAfter = await provider.getBalance(addr2.address);

// verify the payee's balance is increased by 3 wei
await expect(balanceInEthAfter.sub(balanceInEthBefore)).to.eq(3);
