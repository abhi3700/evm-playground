// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "./IERC20.sol";
import "./ReentrancyGuard.sol";

contract CPAMM is ReentrancyGuard {
    // reserve tokens' addresses
    IERC20 public immutable token0;
    IERC20 public immutable token1;

    // keep internal balances of reserve tokens
    uint256 public reserve0;
    uint256 public reserve1;

    // lp token's details - total supply, balance of each LPs
    uint256 public totalSupply;
    mapping(address => uint256) public balanceOf;

    constructor(address _token0, address _token1) {
        token0 = IERC20(_token0);
        token1 = IERC20(_token1);
    }

    // mint lp tokens
    function _mint(address _to, uint256 _amount) private {
        balanceOf[_to] += _amount;
        totalSupply += _amount;
    }

    // burn lp tokens
    function _burn(address _from, uint256 _amount) private {
        balanceOf[_from] -= _amount;
        totalSupply -= _amount;
    }

    // function _update(uint256 _reserve0, uint256 _reserve1) private {
    //     reserve0 = _reserve0;
    //     reserve1 = _reserve1;
    // }

    function _update(uint256 _amount0, uint256 _amount1, bool isToken0, bytes32 activity) private {
        if (activity == "swap") {
            if (isToken0) {
                reserve0 += _amount0;
                reserve1 -= _amount1;
            } else {
                reserve1 += _amount0;
                reserve0 -= _amount1;
            }
        } else if (activity == "addLiquidity") {
            if (isToken0) {
                reserve0 += _amount0;
                reserve1 += _amount1;
            } else {
                reserve1 += _amount0;
                reserve0 += _amount1;
            }
        } else if (activity == "removeLiquidity") {
            if (isToken0) {
                reserve0 -= _amount0;
                reserve1 -= _amount1;
            } else {
                reserve1 -= _amount0;
                reserve0 -= _amount1;
            }
        }
    }

    function swap(address _tokenIn, uint256 _amountIn) external nonReentrant returns (uint256 _amountOut) {
        require(_tokenIn == address(token0) || _tokenIn == address(token1), "Invalid token In");

        require(_amountIn > 0, "zero amount In");

        // 1. Pull in tokenIn out of (token0, token1) i.e. `_tokenIn` is either `token0` or `token1`
        bool isToken0 = _tokenIn == address(token0);

        (IERC20 tokenIn, IERC20 tokenOut, uint256 reserveIn, uint256 reserveOut) =
            isToken0 ? (token0, token1, reserve0, reserve1) : (token1, token0, reserve1, reserve0);

        // receive _amountIn from the Trader
        tokenIn.transferFrom(msg.sender, address(this), _amountIn);

        // 2. Calculate tokenOut amount including fees (0.3% or 0.003)
        // Here, the fees remains with the Pair SC
        // Use the formula illustrated here:
        // https://github.com/abhi3700/My_Learning_DeFi/blob/main/protocols/uniswap/maths.md#constant-product-formula
        // dy = yrdx/(x + rdx)
        // or, just replace `dx` with `rdx`
        uint256 amountInWithFee = (_amountIn * 997) / 1000;
        // _amountOut = (reserveOut * 0.997 * _amountIn)/(reserveIn + (0.997 * _amountIn) );
        // OR
        _amountOut = (reserveOut * amountInWithFee) / (reserveIn + amountInWithFee);

        require(_amountOut > 0, "zero amount out computed");

        // 3. Transfer tokenOut to `msg.sender`
        tokenOut.transfer(msg.sender, _amountOut);

        // 4. Update the reserves
        // NOTE: create an _update() function which will be used in 3 functions:
        // `addLiquidity`, `removeLiquidity`, `swap`
        // TODO: lookout for any token which is being transferred in the middle of the block.
        // NOTE: increase the token (+) & decrease the token (-)
        if (isToken0) {
            reserve0 += _amountIn;
            reserve1 -= _amountOut;
        } else {
            reserve1 += _amountIn;
            reserve0 -= _amountOut;
        }
        // _update(
        //     tokenIn.balanceOf(address(this)), tokenOut.balanceOf(address(this))
        // );
    }

    function addLiquidity(uint256 _amount0, uint256 _amount1) external nonReentrant {
        require(_amount0 > 0 && _amount1 > 0, "the amounts should be zero");

        // NOTE: Here, both the amounts should be valued in USD using Oracle's price considering
        // the 1st amount is of token0 & 2nd amount is of token1.
        // Normally, the valuation (in USD) during adding liquidity is done off-chain in the Front-end UI.

        // receive the reserve tokens from Liquidity Provider
        token0.transferFrom(msg.sender, address(this), _amount0);
        token1.transferFrom(msg.sender, address(this), _amount1);

        uint256 _reserve0 = reserve0;
        uint256 _reserve1 = reserve1;

        // Check for `dy/dx = y/x`
        if (_reserve0 > 0 || _reserve1 > 0) {
            require(_reserve0 * _amount1 == _reserve1 * _amount0, "dy/dx != y/x");
        }

        // mint liquidity tokens
        //

        // update reserves
    }

    function removeLiquidity() external {}
}
