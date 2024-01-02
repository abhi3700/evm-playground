/**
 * Get a signer from a private key
 */

import {ethers, Wallet} from "ethers";

function main() {
    const signer: Wallet = new ethers.Wallet(
        "0x" + process.env.ETHEREUM_PRIVATE_KEY
    );

    console.log(`Address: ${signer.address}`);
}