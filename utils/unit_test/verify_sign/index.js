const main = async () => {
  require("dotenv").config();
  const { API_URL, DEPLOYER_PRIVATE_KEY } = process.env;
  const { ethers } = require("ethers");
  const { hashMessage } = require("@ethersproject/hash");
  const provider = new ethers.providers.AlchemyProvider("ropsten", API_URL);

  const message = "Ownership proof of Sender";
  const walletInst = new ethers.Wallet(DEPLOYER_PRIVATE_KEY, provider);
  const signMessage = walletInst.signMessage(message);

  const messageSigner = signMessage.then((value) => {
    const verifySigner = ethers.utils.recoverAddress(
      hashMessage(message),
      value
    );
    return verifySigner;
  });

  try {
    console.log(
      "Success! The message: " +
        message +
        " was signed with the signature: " +
        (await signMessage)
    );
    console.log("The signer was: " + (await messageSigner));
  } catch (err) {
    console.log(
      "Something went wrong while verifying your message signature: " + err
    );
  }
};

main();
