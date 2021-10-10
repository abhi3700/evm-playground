# Learn NFT

## About
* NFTs (Non-Fungible Tokens) can be summed up with one word: "unique". These are smart contracts deployed on a blockchain that represent something unique.
* Unlike FT, Non-fungible tokens have token ids. Fungible tokens (FT) are all identical.
* All NFTs have what’s called metadata. Each `tokenId` has a specific `tokenURI` that defines this API call, which returns a JSON object that looks something like this:
```json
{
    "name": "You NFT token name",
    "description": "Something Cool here",
    "image": "https://ipfs.io/ipfs/QmTgqnhFBMkfT9s8PHKcdXBn1f5bG3Q5hmBaR4U6hoTvb1?filename=Chainlink_Elf.png",
    "attributes": [...]
}
```
* You’ll notice the metadata has four distinct keys.
	- _name_ which defines the tokenIds human-readable name
	- _description_ which gives some background information on the token
	- _image_ which is another URI to an image
	- _attributes_ which allow you to display the stats of your token

> It’s important that if your NFT interacts with other NFTs to make sure that the attributes on the `tokenURI` match the attributes of your NFT smart contract, otherwise you may get confused when battles or interactions don’t pan out as expected!

* Problem of storing data on-chain:

> Basically, what the community found out was that storing images is really taxing and expensive to do on Ethereum. If you want to store a 8 x 8 picture, storing this much data is pretty cheap, but if you want a picture with decent resolution, you’ll need to spend a lot more.

> The cost of data storage is (about) 640k gas per Kb of data. If the current gas price is approximately 50 Gwei or 0.000000050 ETH, and 1 ETH equals $600 presently, you’ll be spending $20. $20 to add that to the blockchain. This didn’t really excite NFT creators.

* Storing metadata on-chain & off-chain: The _name_, _description_, and _attributes_ are easy to store on-chain, but the _image_ is the hard part. It would be better if we could store our images on-chain so that they can’t go down or get hacked. That's why __IPFS__. This is to ensure the NFT asset with image is not duplicated elsewhere. And this is ensured by creating a hash based on the image & directed to a link of IPFS like `https://ipfs.io/ipfs/QmTgqnhFBMkfT9s8PHKcdXBn1f5bG3Q5hmBaR4U6hoTvb1?filename=Chainlink_Elf.png`. This is ideal for storing images since it means that every time the image is updated, the on-chain hash/tokenURI also has to change, meaning that we can have a record of the history of the metadata. It’s also really easy to add an image onto IPFS and doesn’t require running a server!

## Standards
* ERC721
* ERC1155: ERC721 + batch transfer of tokens (with different ids).
	- very helpful for games, where a user buying weapons of different type (or id) which is gettting transferred at a time (i.e. batch transfer).

## Marketplace
This is an example where the technicality will be explained:

* Whenever a user creates an NFT, it gets created with one standard like ERC721.
* Thereafter the minting right of the token is reserved with the creator. Now, minting process can be of 2 types:
	1. Minting __NOT__ allowed after the NFT creation. Meaning the no. which is minted during the creation of a token type/id is final.
	2. Minting is allowed after the NFT creation. Meaning additional no. can be generated based on the requirement of market. E.g. items on Amazon marketplace gets created when there is a demand from the customer.


## Coding
* 

## References
* [Ultimate NFT Programming Tutorial - FULL COURSE](https://youtu.be/tBMk1iZa85Y)
* [How to Make an NFT and Render it on the OpenSea Marketplace](https://www.freecodecamp.org/news/how-to-make-an-nft-and-render-on-opensea-marketplace/)
* [Build, Deploy, and Sell Your Own Dynamic NFT | Chainlink](https://blog.chain.link/build-deploy-and-sell-your-own-dynamic-nft/)
* [ERC-1155 proposal](https://github.com/ethereum/EIPs/blob/master/EIPS/eip-1155.md)



