// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.19;

import {SlicerPurchasable} from "../../extensions/Purchasable/SlicerPurchasable.sol";
import {ISliceProductPrice} from "../../utils/sliceV1/interfaces/ISliceProductPrice.sol";
import {IERC721} from "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import {IERC1155} from "@openzeppelin/contracts/token/ERC1155/IERC1155.sol";
import {ITokenERC1155} from "../interfaces/ITokenERC1155.sol";
import {IProductsModule} from "../interfaces/IProductsModule.sol";

/**
 * @notice  Slice pricing strategy to discount one product for the first purchase on a store, based on conditions.
 * @author  jacopo.eth
 */
contract FirstForFree is SlicerPurchasable, ISliceProductPrice {
    /*//////////////////////////////////////////////////////////////
                                 ERRORS
    //////////////////////////////////////////////////////////////*/

    error NotProductOwner();

    /*//////////////////////////////////////////////////////////////
                           IMMUTABLE STORAGE
    //////////////////////////////////////////////////////////////*/

    address public immutable productsModuleAddress;

    /*//////////////////////////////////////////////////////////////
                            MUTABLE STORAGE
    //////////////////////////////////////////////////////////////*/

    struct Params {
        uint256 usdcPrice;
        Token[] discountTokens;
        address mintToken;
        uint88 mintTokenId;
        uint8 freeUnits;
    }

    struct Token {
        address tokenAddress;
        uint88 tokenId;
        TokenType tokenType;
    }

    enum TokenType {
        ERC721,
        ERC1155
    }

    mapping(uint256 slicerId => mapping(uint256 productId => Params price)) public usdcPrices;
    mapping(address buyer => mapping(uint256 slicerId => uint256 purchases)) public totalPurchases;

    /*//////////////////////////////////////////////////////////////
                              CONSTRUCTOR
    //////////////////////////////////////////////////////////////*/

    constructor(address productsModuleAddress_) {
        productsModuleAddress = productsModuleAddress_;
    }

    /*//////////////////////////////////////////////////////////////
                               MODIFIERS
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Check if msg.sender is owner of a product. Used to manage access to `setProductPrice`.
     */
    modifier onlyProductOwner(uint256 slicerId, uint256 productId) {
        if (!IProductsModule(productsModuleAddress).isProductOwner(slicerId, productId, msg.sender)) {
            revert NotProductOwner();
        }
        _;
    }

    /*//////////////////////////////////////////////////////////////
                               FUNCTIONS
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Called by product owner to set base price and discounts for a product.
     *
     * @param slicerId ID of the slicer to set the price for.
     * @param productId ID of the product to set the price for.
     * @param usdcPrice Price of the product in USDC, with 6 decimals.
     * @param discountTokens tokens to hold to obtain a free item.
     * @param mintToken address of the token to mint on purchase. Set to address(0) to disable.
     * @param mintTokenId ID of the token to mint on purchase.
     * @param freeUnits Number of free units to give each eligible buyer.
     */
    function setProduct(
        uint256 slicerId,
        uint256 productId,
        uint256 usdcPrice,
        Token[] memory discountTokens,
        address mintToken,
        uint88 mintTokenId,
        uint8 freeUnits
    ) external onlyProductOwner(slicerId, productId) {
        usdcPrices[slicerId][productId].usdcPrice = usdcPrice;
        usdcPrices[slicerId][productId].mintToken = mintToken;
        usdcPrices[slicerId][productId].mintTokenId = mintTokenId;
        usdcPrices[slicerId][productId].freeUnits = freeUnits;

        for (uint256 i = 0; i < discountTokens.length;) {
            usdcPrices[slicerId][productId].discountTokens.push(discountTokens[i]);

            unchecked {
                ++i;
            }
        }
    }

    /**
     * @notice Called by product owner to remove the discount of a product.
     *
     * @param slicerId ID of the slicer to set the price for.
     * @param productId ID of the product to set the price for.
     * @param index Index of the discount token to remove.
     */
    function removeDiscountToken(uint256 slicerId, uint256 productId, uint256 index)
        external
        onlyProductOwner(slicerId, productId)
    {
        Params storage params = usdcPrices[slicerId][productId];

        if (index >= params.discountTokens.length) revert("Index out of bounds");

        unchecked {
            for (uint256 i = index; i < params.discountTokens.length - 1;) {
                params.discountTokens[i] = params.discountTokens[i + 1];

                ++i;
            }
        }

        params.discountTokens.pop();
    }

    /**
     * @notice Function called by Slice protocol to calculate current product price.
     * Discount is applied only for first purchase on a slicer.
     *
     * @param slicerId ID of the slicer being queried
     * @param productId ID of the product being queried
     * @param quantity Number of units purchased
     * @param buyer Address of the buyer
     *
     * @return ethPrice and currencyPrice of product.
     */
    function productPrice(uint256 slicerId, uint256 productId, address, uint256 quantity, address buyer, bytes memory)
        public
        view
        override
        returns (uint256 ethPrice, uint256 currencyPrice)
    {
        Params memory params = usdcPrices[slicerId][productId];

        bool isEligible = params.discountTokens.length == 0;
        if (!isEligible) {
            Token memory token;
            for (uint256 i = 0; i < params.discountTokens.length;) {
                token = params.discountTokens[i];

                if (token.tokenType == TokenType.ERC721) {
                    isEligible = IERC721(token.tokenAddress).balanceOf(buyer) != 0;
                } else {
                    isEligible = IERC1155(token.tokenAddress).balanceOf(buyer, token.tokenId) != 0;
                }

                if (isEligible) break;

                unchecked {
                    ++i;
                }
            }
        }

        if (isEligible) {
            uint256 totalPurchases_ = totalPurchases[buyer][slicerId];
            if (totalPurchases_ < params.freeUnits) {
                unchecked {
                    uint256 freeUnitsLeft = params.freeUnits - totalPurchases_;
                    if (quantity <= freeUnitsLeft) {
                        return (0, 0);
                    } else {
                        return (0, usdcPrices[slicerId][productId].usdcPrice * (quantity - freeUnitsLeft));
                    }
                }
            }
        }

        return (0, usdcPrices[slicerId][productId].usdcPrice * quantity);
    }

    /**
     * @notice Mint `quantity` NFTs to `account` on purchase. Keeps track of total purchases.
     */
    function onProductPurchase(
        uint256 slicerId,
        uint256 productId,
        address buyer,
        uint256 quantity,
        bytes memory,
        bytes memory
    ) public payable override {
        if (msg.sender != productsModuleAddress) revert NotPurchase();

        totalPurchases[buyer][slicerId] += quantity;

        Params memory params = usdcPrices[slicerId][productId];
        if (params.mintToken != address(0)) {
            ITokenERC1155(params.mintToken).mintTo(buyer, params.mintTokenId, "", quantity);
        }
    }
}
