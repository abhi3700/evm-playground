/* 
    Normally, for testing we have 20 addresses available from `ethers.getSigners()`. 
    
    But, we can generate more signers using this function

    CONS:
    - the type should have been `SignerWithAddress` instead of `Signer`
*/

export const randomSigners = (amount: number): Signer[] => {
  const signers: Signer[] = [];
  for (let i = 0; i < amount; i++) {
    signers.push(ethers.Wallet.createRandom());
  }
  return signers;
};
