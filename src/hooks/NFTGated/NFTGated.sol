// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "../../extensions/Purchasable/SlicerPurchasable.sol";
import {IERC721} from "@openzeppelin/contracts/interfaces/IERC721.sol";
import {IERC1155} from "@openzeppelin/contracts/interfaces/IERC1155.sol";

struct NFTData {
    address token;
    TokenType tokenType;
    uint80 id;
    uint8 minQuantity;
}

enum TokenType {
    ERC721,
    ERC1155
}

/**
 * Gates purchases based on ownership of multiple NFTs, either ERC721 or ERC1155.
 */
abstract contract NFTGated is SlicerPurchasable {
    /// ============= Storage =============

    NFTData[] public nftData;
    uint256 public minTotalQuantity;

    /// ============ Functions ============

    /**
     * @notice Overridable function containing the requirements for an account to be eligible for the purchase.
     *
     * Checks if `account` owns the required amount of ERC1155 tokens.
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
        unchecked {
            uint256 owned;
            uint256 length = nftData.length;
            uint256 minQuantity_ = minTotalQuantity;

            NFTData memory nftData_;
            for (uint256 i; i < length;) {
                nftData_ = nftData[i];
                if (nftData_.tokenType == TokenType.ERC1155) {
                    if (IERC1155(nftData_.token).balanceOf(account, nftData_.id) >= nftData_.minQuantity) {
                        ++owned;
                    }
                } else if (IERC721(nftData_.token).balanceOf(account) >= nftData_.minQuantity) {
                    ++owned;
                }

                if (owned >= minQuantity_) {
                    return true;
                }

                ++i;
            }
        }
    }

    /**
     * @notice Overridable function to handle external calls on product purchases from slicers. See {ISlicerPurchasable}
     */
    function onProductPurchase(uint256, uint256, address account, uint256, bytes memory, bytes memory)
        public
        payable
        override
    {
        // Check whether the account is allowed to buy a product.
        if (!isPurchaseAllowed(0, 0, account, 0, "", "")) {
            revert NotAllowed();
        }
    }
}
