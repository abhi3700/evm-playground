/* 
    Get ERC20 token balance of an address before & after minting
*/

// get the balance of addr2 before mint
const balanceAddr2Before: BigNumber =
    await erc20TokenContract.balanceOf(addr2.address);

		...
		...

// get the balance of addr2 after mint
const balanceAddr2After: BigNumber = await erc20TokenContract.balanceOf(
    addr2.address
);

await expect(balanceAddr2After.sub(balanceAddr2Before)).to.eq(
    BigNumber.from(String(1))
);
