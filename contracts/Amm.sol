// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import {WETH} from "./Weth.sol";
import {SHITCOIN} from "./Shitcoin.sol";
import {SafeMath} from "@openzeppelin/contracts/utils/math/SafeMath.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract AMM {
   WETH private weth;
   SHITCOIN private shitcoin;
*  using SafeMath for uint256;
   
   //amount of token1
   uint256 totalWeth;
   // amount of token2
   uint256 totalShitcoin;
   // total amount of shares issued for the pool
   uint256 totalShares;
   // Algo constant used to determine price
   uint256 K;
   
   // shares of each provider
   mapping (address => uint256) public shares;

   constructor(
        address _weth,
        address _shitcoin
        ) {
        weth = _weth;
        shitcoin = _shitcoin;
    }
    
    modifier isPoolActive() {
        require(totalShares > 0, "No liquidity in pool");
        _;
    }

    modifier validAmountCheck(address _token , uint256 _amount) {
        IERC20 token = IERC20(_token);
        require(_amount > 0, "Amount cannot be zero");
        require(_amount <= token.balanceOf(msg.sender), "Insufficient amount");
        _;
    }

    

}