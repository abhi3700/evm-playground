//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import '@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol';
import '@openzeppelin/contracts/access/Ownable.sol';
import '@openzeppelin/contracts/security/Pausable.sol';
import '@openzeppelin/contracts/utils/math/SafeMath.sol';
import "hardhat/console.sol";


contract SendERC20frmtoCont is Ownable, Pausable {
    using SafeMath for uint256;
    using SafeERC20 for IERC20;

    // State variables===================================================================================
    IERC20 public token;

    uint256 public totalDepositedAmount;
    uint256 public totalWithdrawnAmount;

    mapping(address => uint256) public balances;

    // ===============EVENTS============================================================================================
    event TokenDeposited(address indexed sender, uint256 amount, uint256 currentTimestamp);
    event TokenWithdrawn(address indexed receiver, uint256 amount, uint256 currentTimestamp);

    //================CONSTRUCTOR================================================================
    /// @notice Constructor
    /// @param _token ERC20 token
    constructor(
        IERC20 _token
    ) {
        require(address(_token) != address(0), "Invalid address");
        token = _token;

        totalDepositedAmount = 0;
        totalWithdrawnAmount = 0;
    }

    //=================FUNCTIONS=================================================================
    /// @notice Deposit function accessed by anyone
    /// @dev NOTE: no `payable` keyword to be used for the function
    /// @param _amount vesting amount
    function deposit(uint256 _amount) external whenNotPaused {
        require( _amount > 0, "amount must be positive");

        totalDepositedAmount = totalDepositedAmount.add(_amount);

        // update the balance of caller
        balances[msg.sender] = balances[msg.sender].add(_amount);

        // transfer to SC using delegate transfer
        // NOTE: the tokens has to be approved first by the caller to the SC using `approve()` method.
        // It's like the caller gives the permission to SC to call the `transferFrom` method.
        bool success = token.transferFrom(msg.sender, address(this), _amount);
        require(success, "Token transferFrom failed");    
        
        emit TokenDeposited(msg.sender, _amount, block.timestamp);
    }

    // ------------------------------------------------------------------------------------------
    /// @notice withdraw 
    /// @dev Anyone can withdraw deposited amount
    /// @param _token Vesting token contract
    /// @param _amount withdraw amount
    function withdraw(IERC20 _token, uint256 _amount) external whenNotPaused {
        require(token == _token, "invalid token address");

        require(_amount > 0, "withdrawable amount must be positive");
        require(_amount <= balances[msg.sender], "Can not withdraw more than its balance");

        // update the balance of caller
        balances[msg.sender] = balances[msg.sender].sub(_amount);

        totalWithdrawnAmount = totalWithdrawnAmount.add(_amount);

        // SC receive tokens
        bool success = token.transfer(msg.sender, _amount);
        require(success, "token transfer failed");
        
        emit TokenWithdrawn(msg.sender, _amount, block.timestamp);
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