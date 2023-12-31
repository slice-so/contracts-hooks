// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../ERC721Gated.sol";

/**
 * ERC721Gated purchase hook.
 */
contract ERC721GatedImmutable is ERC721Gated {
    /// ============ Constructor ============

    /**
     * @notice Initializes the contract.
     *
     * @param productsModuleAddress_ {ProductsModule} address
     * @param slicerId_ ID of the slicer linked to this contract
     * @param erc721_ Addresses of the ERC721 contract used for gating
     * @param minQuantity_ Min number of ERC721 tokens required for purchase
     */
    constructor(address productsModuleAddress_, uint256 slicerId_, IERC721[] memory erc721_, uint256 minQuantity_) {
        require(minQuantity_ <= erc721_.length, "UNEXPECTED_MIN_QUANTITY");

        _productsModuleAddress = productsModuleAddress_;
        _slicerId = slicerId_;
        erc721 = erc721_;
        minQuantity = minQuantity_;
    }
}
