const network = 'rinkeby' // use rinkeby testnet
const provider = ethers.getDefaultProvider(network)
const address = '0xF02c1c8e6114b1Dbe8937a39260b5b0a374432bB'
provider.getBalance(address).then((balance) => {
    // convert a currency unit from wei to ether
    const balanceInEth = ethers.utils.formatEther(balance)
    console.log(`balance: ${balanceInEth} ETH`)
})

// M-2  
const balanceInEth = await provider.getBalance(address);
