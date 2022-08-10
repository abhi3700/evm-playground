/* 
    This is to get the list of signers in local hardhat environment

    NOTE: Max. 20
*/

import { ethers } from "hardhat";

[owner, addr1, addr2] = await ethers.getSigners();
