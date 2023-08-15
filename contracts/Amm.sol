// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import {WETH} from "./Weth.sol";
import {SHITCOIN} from "./Shitcoin.sol";
import {SafeMath} from "@openzeppelin/contracts/utils/math/SafeMath.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract AMM {
   WETH private weth;
   SHITCOIN private shitcoin;
   using SafeMath for uint256;
   
   //amount of token1
   uint256 totalWeth;
   // amount of token2
   uint256 totalShitcoin;
   // total amount of shares issued for the pool
   uint256 totalShares;
   // Algo constant used to determine price
   uint256 K;
   uint256 private constant WEI_VALUE = 1e18;
   
   // shares of each provider
   mapping (address => uint256) public shares;

   constructor(
        WETH _weth,
        SHITCOIN _shitcoin
        ) {
        weth = _weth;
        shitcoin = _shitcoin;
    }
    
    modifier isPoolActive() {
        require(totalShares > 0, "No liquidity in pool");
        _;
    }

    modifier isValidAmount(IERC20 _token , uint256 _amount) {
        require(_amount > 0, "Amount cannot be zero");
        require(_amount <= _token.balanceOf(msg.sender), "Insufficient amount");
        _;
    }

    modifier isValidShares(uint256 _amount) {
        require(_amount > 0, "Share cannot be zero");
        require(_amount <= shares[msg.sender], "Insufficient shares");
        _;
    }

    function addLiquidity(uint256 _amountWeth, uint256 _amountShitcoin)
    external
    isValidAmount(weth, _amountWeth)
    isValidAmount(shitcoin, _amountShitcoin)
    returns(uint256 share) {
        if (totalShares == 0) {
            share = 100*(WEI_VALUE);
        } else {
            uint256 share1 = totalShares.mul(_amountWeth.div(totalWeth));
            uint256 share2 = totalShares.mul(_amountShitcoin.div(totalShitcoin));
            require(share1 == share2, "You must provide equals amount");
            share = share1;
        }
        require(share > 0, "Asset is less than treshold");
        weth.transferFrom(msg.sender, address(this), _amountWeth);
        shitcoin.transferFrom(msg.sender, address(this), _amountShitcoin);

        totalWeth += _amountWeth;
        totalShitcoin += _amountShitcoin;
        K =  totalWeth.mul(totalShitcoin);

        totalShares += share;
        shares[msg.sender] += share;
    }

    function getSwapWethEstimate(uint256 _amountWeth) 
    public
    view
    isPoolActive
    returns(uint256 _amountShitcoin)
    {
        uint256 wethAfter = totalWeth.add(_amountWeth);
        uint256 shitcoinAfter = K.div(wethAfter);
        _amountShitcoin = totalShitcoin.sub(shitcoinAfter);

        if(_amountShitcoin == totalShitcoin) _amountShitcoin--;
    } 

    function swapWeth(uint256 _amountWeth)
    external
    isPoolActive
    isValidAmount(weth, _amountWeth)
    returns(uint256 _amountShitcoin)
    {
        _amountShitcoin = getSwapWethEstimate(_amountWeth);
        require(
            
        );
    } 
}