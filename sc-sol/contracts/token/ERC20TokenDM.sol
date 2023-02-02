// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/Context.sol";
import "hardhat/console.sol";

/// @title A ERC20 Token SC
/// @author abhi3700
/// @notice A ERC20 Token
/// @dev A ERC20 token with custom decimal & pre-minted initial supply
contract ERC20TokenDM is ERC20, Ownable, Pausable {
    // ==========State variables====================================
    uint8 private immutable decimal;

    // ==========Events=============================================
    event TokenMinted(address indexed toAcct, uint256 amount);
    event TokenBurnt(address indexed fromAcct, uint256 amount);

    // ==========Constructor========================================
    constructor(string memory _name, string memory _symbol, uint8 _decimals, uint256 _initialSupply)
        ERC20(_name, _symbol)
    {
        decimal = _decimals;
        _mint(msg.sender, _initialSupply);
    }

    // ==========Functions==========================================
    function decimals() public view override returns (uint8) {
        return decimal; // custom decimal for 1 token in unit test.
    }

    function mint(address _account, uint256 _amount) external onlyOwner whenNotPaused returns (bool) {
        require(_amount > 0, "amount must be positive");
        _mint(_account, _amount);

        emit TokenMinted(_account, _amount);

        return true;
    }

    function burn(uint256 _amount) external whenNotPaused returns (bool) {
        require(_amount > 0, "amount must be positive");
        _burn(_msgSender(), _amount);

        emit TokenBurnt(_msgSender(), _amount);

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
