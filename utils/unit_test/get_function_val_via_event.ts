/* 
    Get function (non-view) return value from event filtering system in a transaction.
    > A transaction can have multiple events fired. Out of which the required event with 
    arguments has to be filtered & then used.
*/

const txResponse = await stfxVaultproxyContract.createNewStf(_stf);
const txReceipt = await txResponse.wait();
const NewFundCreatedEvent = txReceipt.events.find(
  (event: any) => event.event === "NewFundCreated"
);
const {
  baseToken,
  fundraisingPeriod,
  entryPrice,
  targetPrice,
  liquidationPrice,
  leverage,
  tradeDirection,
  stfxAddress,
  msgSender,
  now,
} = NewFundCreatedEvent.args;

// Verify that the event is fired by the contract on calling the function
// expect(await stfxVaultproxyContract.createNewStf(_stf)).to.emit(
//   stfxVaultproxyContract,
//   "NewFundCreated"
// );

console.log(`Created New STF address: ${stfxAddress}\n`);
