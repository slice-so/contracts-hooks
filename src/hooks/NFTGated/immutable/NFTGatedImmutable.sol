// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../NFTGated.sol";

/**
 * NFTGated purchase hook.
 */
contract NFTGatedImmutable is NFTGated {
    /// ============ Constructor ============

    /**
     * @notice Initializes the contract.
     *
     * @param productsModuleAddress_ {ProductsModule} address
     * @param slicerId_ ID of the slicer linked to this contract
     * @param nftData_ Addresses of the nfts used for gating
     * @param minTotalQuantity_ Min number of nft conditions required for purchase
     */
    constructor(
        address productsModuleAddress_,
        uint256 slicerId_,
        NFTData[] memory nftData_,
        uint256 minTotalQuantity_
    ) {
        require(minTotalQuantity_ <= nftData_.length, "UNEXPECTED_MIN_QUANTITY");

        _productsModuleAddress = productsModuleAddress_;
        _slicerId = slicerId_;
        minTotalQuantity = minTotalQuantity_;

        for (uint256 i = 0; i < nftData_.length;) {
            nftData.push(nftData_[i]);
            unchecked {
                ++i;
            }
        }
    }
}
