// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "../node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol";

// import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Zjcoin is ERC20 {
    constructor() ERC20("Zjucoin", "ZJC") {
        _mint(msg.sender, 5);
    }

    function burn(address sender, uint256 cost) external returns (bool succeed) {
        uint256 remain = this.balanceOf(sender);
        if (remain < cost) {
            return false;
        } else {
            _burn(sender, cost);
			return true;
        }
    }
}
