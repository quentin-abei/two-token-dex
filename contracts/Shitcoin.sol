//SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;
// 0xF229329e2A6321E52e2961418CAB69038126CD12

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract SHITCOIN is ERC20, ERC20Burnable, Ownable {
    using SafeERC20 for ERC20;
    constructor() ERC20("Shitcoin", "SHIT") {}
    function mint(uint256 _amount) external onlyOwner {
        _mint(msg.sender, _amount);
    }
}