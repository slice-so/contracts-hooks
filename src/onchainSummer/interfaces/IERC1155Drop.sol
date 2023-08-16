// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

import {IMinter1155} from "./IMinter1155.sol";

interface IERC1155Drop {
    function mintWithRewards(
        IMinter1155 minter,
        uint256 tokenId,
        uint256 quantity,
        bytes calldata minterArguments,
        address mintReferral
    ) external payable;
}
