// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

interface IERC721Drop {
    function salesConfig()
        external
        view
        returns (
            uint104 publicSalePrice,
            uint32 maxSalePurchasePerAddress,
            uint64 publicSaleStart,
            uint64 publicSaleEnd,
            uint64 presaleStart,
            uint64 presaleEnd,
            bytes32 presaleMerkleRoot
        );

    function mintWithRewards(
        address recipient,
        uint256 quantity,
        string calldata comment,
        address mintReferral
    ) external payable returns (uint256);
}
