//SPDX-License-Identifier: MIT

pragma solidity >= 0.6.4 <= 0.9.0;

import "hardhat/console.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

/**
 * @title Crowdsale
 * @author abhi3700
 * @notice Crowdsale contract is used as a mode of investment of ETH & getting back MTN tokens
 * in return.
 * @dev Using this contract people will be able to send Ethers to this contract &
 * in return receive MTN tokens.
 * 
 * Token contract - "./ERC20Token.sol"
 * Workflow:
 *      - to manually transfer the minted public sale tokens at once from MainToken to the Vether contract.
 *      - Now, a person when transfers ETH to Crowdsale contract, in return give proportionate value of MTN tokens
 * Images:
 *      - ../../img/crowdsale_pt1.jpg
 *      - ../../img/crowdsale_pt2.jpg
 * Videos:
 *      - "https://github.com/abhi3700/ethio_playground_videos/blob/main/crowdsale_w_erc20.m4v"
 * References:
 *      - https://docs.openzeppelin.com/contracts/2.x/api/crowdsale
 */

contract MyCrowdsale is ReentrancyGuard {
    using SafeMath for uint256;


    address payable public treasuryAddress;
    address payable public mainTokenAddress;

    uint256 icoRate;             // rate per ETH, calculated inside a function here.
    uint256 public weiRaised;              // amount of wei raised
    address public admin;
    // IERC20 token;
    // uint256 public balanceofPublicSaleTokens;           // [OPTIONAL] will be updated by calling setBalancePublicSaleTokens()



    event Invest(address indexed user, uint256 amountDeposited, uint256 amountReceived);

    // define all the mining calculations here so that it doesn't have to
    // called from MainToken contract
    // constructor(address payable _treasuryAddress, uint256 icoRate) {
    constructor() {
        // require(treasuryAddress != payable(address(0));
        treasuryAddress = payable(address(0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB));             // testing
        // treasuryAddress = _treasuryAddress;             // all the ETH transfers are stored in this address.
        icoRate = 10_000 * 10 ** 18;                               // Testing: 1 ETH -> 10,000 BOOT tokens.
        admin = msg.sender;
    }


    function setMainTokenAddress(address payable _mainTokenAddress) external {
        require(admin == msg.sender, "Only Admin can set this");
        mainTokenAddress = _mainTokenAddress;
    }

    function deposit() external payable nonReentrant {
        // 0. checks
        require(msg.sender != address(0));

        uint256 weiAmount = msg.value;
        require(weiAmount != 0);
        
        // ------------------------------------------------------------------
        // 1. calculate the tokens to be transferred for the weiAmount transferred
        uint256 tokens = _getTokenAmount(weiAmount);

        // ------------------------------------------------------------------
        // 2. add the wei amount raised to date
        weiRaised = weiRaised.add(weiAmount);

        // ------------------------------------------------------------------
        // 3. forward weiAmount to treasury address
        // v0.8.6
        (bool success, ) = treasuryAddress.call{value:msg.value}("");               // send ETH to treasuryAddress
        require(success, "Transfer failed.");        

        // v0.6.4
        // treasuryAddress.call.value(msg.value)("");                                 // send ETH to treasuryAddress

        // ------------------------------------------------------------------
        // 4. send BOOT tokens to the ICO participator
        IERC20 tcontract = IERC20(mainTokenAddress);
        // require(tcontract.allowance(address(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4), address(this)) >= weiAmount, "Not permitted to spend.");
                
        require(tcontract.transfer(msg.sender, tokens), "Don't have enough balance");       // transfer tokens to the caller
        require(tcontract.approve(msg.sender, tokens), "Don't have enough balance");        // approve tokens for the caller to spend

        emit Invest(msg.sender, msg.value, tokens);
    }



    /**
    * @dev Override to extend the way in which ether is converted to tokens.
    * @param _weiAmount Value in wei to be converted into tokens
    * @return Number of tokens that can be purchased with the specified _weiAmount
    */
    function _getTokenAmount(uint256 _weiAmount) 
            internal view 
            returns (uint256)
    {
        return _weiAmount.mul(icoRate.div(10**18));
    }

}