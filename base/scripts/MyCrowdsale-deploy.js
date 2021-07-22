async function main() {
    const [deployer] = await ethers.getSigners();

    console.log("Deploying contracts with the account:", deployer.address);

    console.log("Account balance:", (await deployer.getBalance()).toString());

    const MyCrowdsale = await ethers.getContractFactory("MyCrowdsale");
    const mycrowdsale = await MyCrowdsale.deploy();

    console.log("Contract address:", mycrowdsale.address);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });