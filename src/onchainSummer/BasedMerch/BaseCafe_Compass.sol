// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import "../../extensions/Purchasable/SlicerPurchasable.sol";
import "../../utils/sliceV1/interfaces/ISliceProductPrice.sol";
import "../interfaces/ITokenERC1155.sol";
import "../../utils/sliceV1/interfaces/IProductsModule.sol";
import {IERC1155} from "@openzeppelin/contracts/interfaces/IERC1155.sol";

struct ClaimableDiscount {
    bool discountClaimable;
    bool discountClaimed;
}

/**
 * @title Hook to mint Compass Coffee NFTs
 * @author jacopo.eth
 */
contract BaseCafe_Compass_SliceHook is SlicerPurchasable, Ownable, ISliceProductPrice {
    /*//////////////////////////////////////////////////////////////
                           IMMUTABLE STORAGE
    //////////////////////////////////////////////////////////////*/

    ITokenERC1155 public constant MINT_NFT_COLLECTION = ITokenERC1155(0x185169058E83CC5Ae9fc1bc758eEA7098a2557CF);
    uint256 public constant MINT_NFT_TOKEN_ID = 0;

    /*//////////////////////////////////////////////////////////////
                                STORAGE
    //////////////////////////////////////////////////////////////*/

    mapping(uint256 slicerId => bool allowed) public allowedSlicerIds;
    mapping(uint256 slicerId => mapping(uint256 productId => bool discountClaimable)) public discountClaimable;
    mapping(uint256 slicerId => mapping(uint256 productId => mapping(address buyer => bool discountClaimed))) public
        discountClaimed;
    mapping(uint256 slicerId => mapping(uint256 productId => uint64 usdcPrice)) public productPrices;

    /*//////////////////////////////////////////////////////////////
                              CONSTRUCTOR
    //////////////////////////////////////////////////////////////*/

    constructor(address productsModuleAddress_, uint256 slicerId_) {
        _productsModuleAddress = productsModuleAddress_;
        _slicerId = slicerId_;

        allowedSlicerIds[425] = true;
        allowedSlicerIds[426] = true;
        discountClaimable[425][21] = true;
    }

    /*//////////////////////////////////////////////////////////////
                               FUNCTIONS
    //////////////////////////////////////////////////////////////*/

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
    ) public payable override {
        if (!allowedSlicerIds[slicerId]) revert NotAllowed();

        if (discountClaimable[slicerId][productId]) {
            if (
                !discountClaimed[slicerId][productId][buyer]
                    && IERC1155(address(MINT_NFT_COLLECTION)).balanceOf(buyer, MINT_NFT_TOKEN_ID) != 0
            ) {
                discountClaimed[slicerId][productId][buyer] = true;
            }
        }

        MINT_NFT_COLLECTION.mintTo(buyer, MINT_NFT_TOKEN_ID, "", quantity);
    }

    /*//////////////////////////////////////////////////////////////
                               FUNCTIONS
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Called by product owner to set product configs.
     */
    function setPrice(uint256 slicerId, uint256 productId, uint64 price) external onlyOwner {
        productPrices[slicerId][productId] = price;
    }

    /**
     * @notice Called by contract owner to set allowed slicer Ids.
     */
    function setAllowedSlicerId(uint256 slicerId, bool allowed) external onlyOwner {
        allowedSlicerIds[slicerId] = allowed;
    }

    /**
     * @notice Called by contract owner to set product discounts.
     */
    function setProductDiscount(uint256 slicerId, uint256 productId, bool isDiscountClaimable) external onlyOwner {
        discountClaimable[slicerId][productId] = isDiscountClaimable;
    }

    /**
     * @notice Function called by Slice protocol to calculate current product price.
     */
    function productPrice(uint256 slicerId, uint256 productId, address, uint256 quantity, address buyer, bytes memory)
        external
        view
        returns (uint256 ethPrice, uint256 currencyPrice)
    {
        if (
            discountClaimable[slicerId][productId] && !discountClaimed[slicerId][productId][buyer]
                && IERC1155(address(MINT_NFT_COLLECTION)).balanceOf(buyer, MINT_NFT_TOKEN_ID) != 0
        ) {
            quantity--; // 1 product is free
        }

        currencyPrice = productPrices[slicerId][productId] * quantity;
        ethPrice = 0;
    }
}
