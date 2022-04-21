/* 
    This is to get the list of signers in local hardhat environment
*/


import { ethers } from 'hardhat';

[owner, addr1, addr2] = await ethers.getSigners();