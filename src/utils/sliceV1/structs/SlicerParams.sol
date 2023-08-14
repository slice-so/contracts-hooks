// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../interfaces/ISlicer.sol";

struct SlicerParams {
    ISlicer slicer;
    address controller;
    uint40 transferMintTimelock;
    uint32 totalSupply;
    uint8 royaltyPercentage;
    bool isCustomRoyaltyActive;
    bool isRoyaltyReceiverSlicer;
}
