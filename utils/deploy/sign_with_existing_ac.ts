import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";
import { config as dotenvConfig } from "dotenv";
import { resolve } from "path";
dotenvConfig({ path: resolve(__dirname, "./.env") });

const PAID_CHAIN_URL = process.env.PAID_CHAIN_URL || "";
const DEPLOYER_PRIVATE_KEY = process.env.DEPLOYER_PRIVATE_KEY || "";

async function main(): Promise<void> {
  // Now, import the account available on paid chain
  const provider = ethers.getDefaultProvider(PAID_CHAIN_URL);
  const acc1/*: SignerWithAddress*/  = new ethers.Wallet(`0x${DEPLOYER_PRIVATE_KEY}`, provider);
  console.log("Deployer: " + acc1.address);
  // console.log(typeof(acc1.address));

  // use the `inc()` function
  await incrementer.connect(acc1).inc().then((tx: any) => {
    return tx.wait().then((receipt: any) => {
        // This is entered if the transaction receipt indicates success
        return true;
    }, (error: any) => {
        // This is entered if the status of the receipt is failure
        return error.checkCall().then((error: any) => {
            console.log("Error", error);
            return false;
        });
    });
  });
  console.log("After inc():");
  console.log(`value: ${await incrementer.getValue()}`);
  console.log(`Last caller: ${await incrementer.getLastCaller()}`);

}