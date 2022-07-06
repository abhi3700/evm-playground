/* 
Name	Decimals	 
wei	    0	 
kwei	3	 
mwei	6	 
gwei	9	 
szabo	12	 
finney	15	 
ether	18
*/

// Get the ERC-20 token name
await daiContract.name();
// 'Dai Stablecoin'

// Get the ERC-20 token symbol (for tickers and UIs)
await daiContract.symbol();
// 'DAI'

// Get the balance of an address
balance = await daiContract.balanceOf("ricmoo.firefly.eth");
// { BigNumber: "3118000455884268201631" }

// Format the DAI for displaying to the user
ethers.utils.formatUnits(balance, 18); // divide by 10^18
// '3118.000455884268201631'

// ------
const oneGwei = BigNumber.from("1000000000");
const oneEther = BigNumber.from("1000000000000000000");

ethers.utils.formatUnits(oneGwei, 0);
// '1000000000'

ethers.utils.formatUnits(oneGwei, "gwei"); // divide by 10^9
// '1.0'

ethers.utils.formatUnits(oneGwei, 9); // divide by 10^9
// '1.0'

ethers.utils.formatUnits(oneEther); // by default, divide by 10^18
// '1.0'

ethers.utils.formatUnits(oneEther, 18); // divide by 10^18
// '1.0'

// =======
ethers.utils.parseUnits("1.0"); // (by default )multiply with 10^18
// { BigNumber: "1000000000000000000" }

ethers.utils.parseUnits("1.0", "ether"); // multiply with 10^18
// { BigNumber: "1000000000000000000" }

ethers.utils.parseUnits("1.0", 18); // multiply with 10^18
// { BigNumber: "1000000000000000000" }

ethers.utils.parseUnits("121.0", "gwei"); // multiply with 10^9
// { BigNumber: "121000000000" }

ethers.utils.parseUnits("121.0", 9); // multiply with 10^9
// { BigNumber: "121000000000" }

// ========
ethers.utils.parseEther("1.0"); // multiply with 10^18
