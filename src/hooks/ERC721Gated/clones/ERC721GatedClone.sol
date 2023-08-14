// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../ERC721Gated.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";

/**
 * ERC721Gated clone purchase hook.
 */
contract ERC721GatedClone is ERC721Gated, Initializable {
    /// ========== Initializer ==========

    /**
     * @notice Initializes the contract.
     *
     * @param productsModuleAddress_ {ProductsModule} address
     * @param slicerId_ ID of the slicer linked to this contract
     * @param erc721_ Address of the ERC721 contract used for gating
     */
    function initialize(
        address productsModuleAddress_,
        uint256 slicerId_,
        IERC721[] memory erc721_,
        uint256 minQuantity_
    ) external initializer {
        require(minQuantity_ <= erc721_.length, "UNEXPECTED_MIN_QUANTITY");
        _productsModuleAddress = productsModuleAddress_;
        _slicerId = slicerId_;
        _erc721 = erc721_;
        _minQuantity = minQuantity_;
    }

    constructor() {
        _disableInitializers();
    }
}
