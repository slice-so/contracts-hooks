// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../../extensions/Purchasable/SlicerPurchasable.sol";
import {IERC721} from "@openzeppelin/contracts/interfaces/IERC721.sol";

/**
 * Purchase hook with single ERC20 Gate.
 */
abstract contract ERC721Gated is SlicerPurchasable {
    /// ============= Storage =============

    IERC721[] internal _erc721;
    uint256 internal _minQuantity;

    /// ============ Functions ============

    /**
     * @notice Overridable function containing the requirements for an account to be eligible for the purchase.
     *
     * Checks if `account` owns the required amount of ERC20 tokens.
     *
     * @dev Used on the Slice interface to check whether a user is able to buy a product. See {ISlicerPurchasable}.
     * @dev Max quantity purchasable per address and total mint amount is handled on Slicer product logic
     */
    function isPurchaseAllowed(uint256, uint256, address account, uint256, bytes memory, bytes memory)
        public
        view
        virtual
        override
        returns (bool isAllowed)
    {
        uint256 owned;

        for (uint256 i; i < _erc721.length;) {
            /// check if user has the amount of NFT required
            if (_erc721[i].balanceOf(account) > 0) {
                owned++;
            }

            unchecked {
                ++i;
            }
        }

        return owned >= _minQuantity;
    }

    /**
     * @notice Overridable function to handle external calls on product purchases from slicers. See {ISlicerPurchasable}
     */
    function onProductPurchase(
        uint256 slicerId,
        uint256 productId,
        address account,
        uint256 quantity,
        bytes memory slicerCustomData,
        bytes memory buyerCustomData
    ) public payable override onlyOnPurchaseFrom(slicerId) {
        // Check whether the account is allowed to buy a product.
        if (!isPurchaseAllowed(slicerId, productId, account, quantity, slicerCustomData, buyerCustomData)) {
            revert NotAllowed();
        }
    }
}
