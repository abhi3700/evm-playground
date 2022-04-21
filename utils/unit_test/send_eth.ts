// deploy escrow contract
const EscrowFactory = await ethers.getContractFactory("Escrow");
escrowContract = await EscrowFactory.deploy();
await escrowContract.deployed();

// addr1 sends 1 ether transaction to contract
await addr1.sendTransaction({
    to: escrowContract.address,
    value: ethers.utils.parseEther("1.0"), // Sends exactly 1.0 ether,
});
