async function main() {
    const [deployer] = await ethers.getSigners();

    console.log("Deploying contracts with the account:", deployer.address);

    console.log("Account balance:", (await deployer.getBalance()).toString());

    const ERC20Token = await ethers.getContractFactory("ERC20Token");
    const erc20token = await ERC20Token.deploy();

    console.log("Contract address:", erc20token.address);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });