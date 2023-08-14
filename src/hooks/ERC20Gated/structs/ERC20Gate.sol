// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/interfaces/IERC20.sol";

struct ERC20Gate {
    IERC20 erc20;
    uint256 amount;
}
