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
     * @param erc721_ Address of the ERC721 contract used for gating
     */
    constructor(
        address productsModuleAddress_,
        uint256 slicerId_,
        IERC721 erc721_
    ) {
        _productsModuleAddress = productsModuleAddress_;
        _slicerId = slicerId_;
        _erc721 = erc721_;
    }
}
