// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import "../../extensions/Purchasable/SlicerPurchasable.sol";
import "../../utils/sliceV1/interfaces/ISliceProductPrice.sol";
import "../../utils/sliceV1/interfaces/IProductsModule.sol";
import "../interfaces/ITokenERC1155.sol";
import {IERC1155} from "@openzeppelin/contracts/interfaces/IERC1155.sol";

/**
 * @title Hook to mint Based Cafe NFTs and handle NFT discounts
 * @author jacopo@slice.so
 */
contract BaseCafe_SliceHook is SlicerPurchasable, Ownable, ISliceProductPrice {
    /*//////////////////////////////////////////////////////////////
                                 ERRORS
    //////////////////////////////////////////////////////////////*/

    error NotProductOwner();

    /*//////////////////////////////////////////////////////////////
                           IMMUTABLE STORAGE
    //////////////////////////////////////////////////////////////*/

    uint256 public constant FREE_PRODUCTS = 5;

    IERC1155 public constant DISCOUNT_NFT_COLLECTION = IERC1155(0x795E2477247C721f26FBeaf1234B9e7fa012F52C);
    uint256 public constant DISCOUNT_TOKEN_ID = 2;

    ITokenERC1155 public constant MINT_NFT_COLLECTION = ITokenERC1155(0x8485A580A9975deF42F8C7c5C63E9a0FF058561D);
    uint256 public constant MINT_TOKEN_ID = 3;

    /*//////////////////////////////////////////////////////////////
                                STORAGE
    //////////////////////////////////////////////////////////////*/

    uint256 baseProductPrice = 5e6;

    mapping(address buyer => uint256 purchases) public totalPurchases;

    /*//////////////////////////////////////////////////////////////
                              CONSTRUCTOR
    //////////////////////////////////////////////////////////////*/

    constructor(address productsModuleAddress_, uint256 slicerId_) {
        _productsModuleAddress = productsModuleAddress_;
        _slicerId = slicerId_;
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
    function onProductPurchase(uint256 slicerId, uint256, address buyer, uint256 quantity, bytes memory, bytes memory)
        public
        payable
        override
        onlyOnPurchaseFrom(slicerId)
    {
        totalPurchases[buyer] += quantity;

        MINT_NFT_COLLECTION.mintTo(buyer, MINT_TOKEN_ID, "", quantity);
    }

    /*//////////////////////////////////////////////////////////////
                               FUNCTIONS
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Called by product owner to set product prices.
     *
     * @param newBaseProductPrice Price of the product in USDC
     */
    function setProductPrice(uint256 newBaseProductPrice) external onlyProductOwner(_slicerId, 1) {
        baseProductPrice = newBaseProductPrice;
    }

    /**
     * @notice Function called by Slice protocol to calculate current product price.
     *
     * @param quantity Number of units purchased
     * @param buyer Address of the buyer
     *
     */
    function productPrice(uint256, uint256, address, uint256 quantity, address buyer, bytes memory)
        external
        view
        returns (uint256 ethPrice, uint256 currencyPrice)
    {
        if (DISCOUNT_NFT_COLLECTION.balanceOf(buyer, DISCOUNT_TOKEN_ID) > 0 && totalPurchases[buyer] < FREE_PRODUCTS) {
            uint256 freeProductsLeft = FREE_PRODUCTS - totalPurchases[buyer];
            if (quantity <= freeProductsLeft) {
                currencyPrice = 0;
            } else {
                currencyPrice = (quantity - freeProductsLeft) * baseProductPrice;
            }
        } else {
            currencyPrice = baseProductPrice * quantity;
        }
    }
}
