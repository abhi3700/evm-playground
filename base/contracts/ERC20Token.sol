//SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/Context.sol";
import "hardhat/console.sol";

/*

Watch Video for understanding:
    - "https://youtu.be/xtDkat5f6Hs"
    - "https://github.com/abhi3700/ethio_playground_videos/blob/main/erc20_pt1.m4v"
    - "https://github.com/abhi3700/ethio_playground_videos/blob/main/erc20_pt2.m4v"

References: 
    - https://www.toptal.com/ethereum/create-erc20-token-tutorial
    - https://www.wealdtech.com/articles/understanding-erc20-token-contracts/
    - https://solidity-by-example.org/app/erc20/
*/

/// @title A ERC20 Token SC
/// @author abhi3700
/// @notice A ERC20 Token
/// @dev A ERC20 token
contract ERC20Token is Ownable, Pausable, ERC20 {
    using SafeMath for uint256;

    // ==========State variables====================================

    // ==========Events=============================================
    event TokenMinted(address indexed toAcct, uint256 amount);
    event TokenBurnt(address indexed fromAcct, uint256 amount);

    // ==========Constructor========================================
    constructor(string memory _n, string memory _s) 
            ERC20(_n, _s)
            Ownable() {}

    // ==========Functions==========================================
    function mint(address _account, uint256 _amount) external onlyOwner whenNotPaused returns (bool) {
        require(_amount > 0, "amount must be positive");
        _mint(_account, _amount);

        emit TokenMinted(_account, _amount);

        return true;
    }

    function burn(address _account, uint256 _amount) external whenNotPaused returns (bool) {
        require(_amount > 0, "amount must be positive");
        _burn(_account, _amount);

        emit TokenBurnt(_account, _amount);

        return true;
    }

    // ------------------------------------------------------------------------------------------
    /// @notice Pause contract 
    function pause() public onlyOwner whenNotPaused {
        _pause();
    }

    /// @notice Unpause contract
    function unpause() public onlyOwner whenPaused {
        _unpause();
    }


}