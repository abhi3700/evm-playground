/* 
    import a deployed SC
*/

const BoxFactory: ContractFactory = await ethers.getContractFactory('Box');
const box: Contract = await BoxFactory.attach('0xD7fBC6865542846e5d7236821B5e045288259cf0');
await box.store(42); 
(await box.retrieve()).toString()       // '42'
