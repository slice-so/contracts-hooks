// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../NFTGated.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";

/**
 * NFTGated clone purchase hook.
 */
contract NFTGatedClone is NFTGated, Initializable {
    /// ========== Initializer ==========

    /**
     * @notice Initializes the contract.
     *
     * @param productsModuleAddress_ {ProductsModule} address
     * @param slicerId_ ID of the slicer linked to this contract
     * @param nftData_ Address of the ERC721 contract used for gating
     */
    function initialize(
        address productsModuleAddress_,
        uint256 slicerId_,
        NFTData[] memory nftData_,
        uint256 minTotalQuantity_
    ) external initializer {
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

    constructor() {
        _disableInitializers();
    }
}
