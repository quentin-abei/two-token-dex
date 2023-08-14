//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract WETH is ERC20, ERC20Burnable, Ownable {
    using SafeERC20 for ERC20;
    constructor() ERC20("Wrapped ETH", "WETH") {}
    function mint(uint256 _amount) external onlyOwner {
        _mint(msg.sender, _amount);
    }
}