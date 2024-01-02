import { ethers } from "ethers";

async function isContractAddress(address: string, provider: ethers.providers.Provider): Promise<boolean> {
    // Check if the address is well-formed
    if (!ethers.utils.isAddress(address)) {
        return false;
    }

    // Check if the address is a contract (has associated code)
    const code = await provider.getCode(address);
    return code !== '0x'; // if code is '0x', it's an EOA (Externally Owned Account), not a contract
}

async function main() {
    // Example usage
    const provider = new ethers.providers.JsonRpcProvider('YOUR_PROVIDER_URL');
    const address = '0x...'; // Replace with the address you want to check

    const isValidContract = await isContractAddress(address, provider);
    console.log(`Is valid contract: ${isValidContract}`);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
