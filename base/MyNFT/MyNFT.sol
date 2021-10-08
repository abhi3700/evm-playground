//SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC1155/ERC1155.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

/*
	@notice This NFT contract uses ERC1155 standard 
*/
contract MyNFT is ERC1155, Ownable {
	uint256 public constant ARTWORK = 0;
	uint256 public constant PHOTO = 1;

	// the URI directs to metadata host of an NFT asset storage
	constructor() ERC1155("") {
		// internal minting
		_mint(msg.sender, ARTWORK, 2, "");
		_mint(msg.sender, PHOTO, 3, "");
	}

	/*	
		@notice external mint by owner 
		@dev only Owner has the permission to mint
		@to account to which tokens are to be transferred
		@id token id
		@amount token amount
	*/	
	function mint(
		address to,
		uint256 id,
		uint256 amount) public onlyOwner
	{
		_mint(to, id, amount, "");
	}

	/*	
		@notice burn function
		@dev anyone can burn NFT. Only verify that the caller is the owner of the asset getting requested for burn.
		@from owner account of the token id
		@id token id
		@amount token amount
		@pre the caller for burning should be the owner of the NFT token
	*/	
	function burn(
		address from,
		uint256 id,
		uint256 amount) public 
	{
		require(msg.sender == account, "the requester is not the owner of the token");
		_burn(account, id, amount);
	}
}