// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import "../../extensions/Purchasable/SlicerPurchasable.sol";
import "../../utils/sliceV1/interfaces/ISliceProductPrice.sol";
import "../../utils/sliceV1/interfaces/IProductsModule.sol";
import "../interfaces/ITokenERC1155.sol";
import {IERC1155} from "@openzeppelin/contracts/interfaces/IERC1155.sol";

struct ProductConfig {
    uint32 basedMerchTokenId;
    uint64 usdcPrice;
}

/**
 * @title Hook to mint Based Cafe NFTs and handle NFT discounts
 * @author jacopo@slice.so
 */
contract BasedMerch_ArtBasel_Delivery_SliceHook is SlicerPurchasable, Ownable, ISliceProductPrice {
    /*//////////////////////////////////////////////////////////////
                                 ERRORS
    //////////////////////////////////////////////////////////////*/

    error NotProductOwner();

    /*//////////////////////////////////////////////////////////////
                           IMMUTABLE STORAGE
    //////////////////////////////////////////////////////////////*/

    IERC1155 public constant DISCOUNT_NFT_COLLECTION = IERC1155(0x7632df72835947e8bF8522B91D394f356a1471e6);
    uint32 public constant DISCOUNT_TOKEN_ID_LEVEL_1 = 0;
    uint32 public constant DISCOUNT_TOKEN_ID_LEVEL_2 = 1;

    ITokenERC1155 public constant BASEDMERCH_NFT_COLLECTION = ITokenERC1155(0x50c68E249260053732e143d715A7F5907a213b46);

    /*//////////////////////////////////////////////////////////////
                                STORAGE
    //////////////////////////////////////////////////////////////*/

    mapping(uint256 productId => ProductConfig params) public productConfig;

    /*//////////////////////////////////////////////////////////////
                              CONSTRUCTOR
    //////////////////////////////////////////////////////////////*/

    constructor(address productsModuleAddress_, uint256 slicerId_) {
        _productsModuleAddress = productsModuleAddress_;
        _slicerId = slicerId_;

        productConfig[35] = ProductConfig({usdcPrice: 20e6, basedMerchTokenId: 14});
        productConfig[36] = ProductConfig({usdcPrice: 15e6, basedMerchTokenId: 15});
        productConfig[37] = ProductConfig({usdcPrice: 10000e6, basedMerchTokenId: 1000});
        productConfig[38] = ProductConfig({usdcPrice: 40e6, basedMerchTokenId: 4});
        productConfig[39] = ProductConfig({usdcPrice: 40e6, basedMerchTokenId: 16});
    }

    /*//////////////////////////////////////////////////////////////
                               MODIFIERS
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Check if msg.sender is owner of a product. Used to manage access to `setProductPrice`.
     */
    modifier onlyProductOwner(uint256 slicerId, uint256 productId) {
        if (!IProductsModule(_productsModuleAddress).isProductOwner(slicerId, productId, msg.sender)) {
            revert NotProductOwner();
        }
        _;
    }

    /*//////////////////////////////////////////////////////////////
                               FUNCTIONS
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Purchase is always allowed
     */
    function isPurchaseAllowed(uint256, uint256, address, uint256, bytes memory, bytes memory)
        public
        view
        virtual
        override
        returns (bool isAllowed)
    {
        isAllowed = true;
    }

    /**
     * @notice Mint `quantity` NFTs to `account` on purchase
     */
    function onProductPurchase(
        uint256 slicerId,
        uint256 productId,
        address buyer,
        uint256 quantity,
        bytes memory,
        bytes memory
    ) public payable override onlyOnPurchaseFrom(slicerId) {
        BASEDMERCH_NFT_COLLECTION.mintTo(buyer, productConfig[productId].basedMerchTokenId, "", quantity);
    }

    /*//////////////////////////////////////////////////////////////
                               FUNCTIONS
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Called by product owner to set product configs.
     */
    function setConfig(uint256 productId, ProductConfig memory config)
        external
        onlyProductOwner(_slicerId, productId)
    {
        productConfig[productId] = config;
    }

    /**
     * @notice Function called by Slice protocol to calculate current product price.
     *
     * @param buyer Address of the buyer
     *
     */
    function productPrice(uint256, uint256 productId, address, uint256 quantity, address buyer, bytes memory)
        external
        view
        returns (uint256 ethPrice, uint256 currencyPrice)
    {
        uint256 cumulativeDiscount = 100;

        unchecked {
            if (DISCOUNT_NFT_COLLECTION.balanceOf(buyer, DISCOUNT_TOKEN_ID_LEVEL_2) != 0) {
                cumulativeDiscount -= 30;
            } else if (DISCOUNT_NFT_COLLECTION.balanceOf(buyer, DISCOUNT_TOKEN_ID_LEVEL_1) != 0) {
                cumulativeDiscount -= 10;
            }
        }

        currencyPrice = productConfig[productId].usdcPrice * quantity * (cumulativeDiscount) / 100;
    }
}
