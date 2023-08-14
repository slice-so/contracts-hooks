// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import {ERC20} from "@solmate/tokens/ERC20.sol";

contract SLC is ERC20 {
    error Unauthorized();

    address public immutable productsModule;
    address public immutable fundsModule;

    constructor(address productsModule_, address fundsModule_) ERC20("Slice", "SLC", 18) {
        productsModule = productsModule_;
        fundsModule = fundsModule_;
    }

    function mint(address to, uint256 amount) external {
        if (msg.sender != productsModule && msg.sender != fundsModule) {
            revert Unauthorized();
        }

        _mint(to, amount);
    }
}
