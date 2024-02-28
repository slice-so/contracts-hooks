// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import "../../extensions/Purchasable/SlicerPurchasable.sol";
import "../../utils/sliceV1/interfaces/ISliceProductPrice.sol";
import "../../utils/sliceV1/interfaces/IProductsModule.sol";
import "../interfaces/ITokenERC1155.sol";
import {IERC1155} from "@openzeppelin/contracts/interfaces/IERC1155.sol";

struct ProductConfig {
    IERC1155 collection;
    uint32 basehuntTokenId;
    uint32 mintTokenId;
    uint64 usdcPrice;
    uint8 discount;
}

/**
 * @title Hook to mint Based Merch NFTs with discounts and gating
 * @author jacopo.eth
 */
contract BasedMerch_Denver_SliceHook is SlicerPurchasable, Ownable, ISliceProductPrice {
    /*//////////////////////////////////////////////////////////////
                                 ERRORS
    //////////////////////////////////////////////////////////////*/

    error NotProductOwner();

    /*//////////////////////////////////////////////////////////////
                           IMMUTABLE STORAGE
    //////////////////////////////////////////////////////////////*/

    IERC1155 public constant BASEHUNT_GATE_NFT_COLLECTION = IERC1155(0xA6cFEAAE26D709a74544Be33E31746411f8810a0);
    uint32 public constant BASEHUNT_GATE_TOKEN_ID_LEVEL_2 = 1;
    uint32 public constant BASEHUNT_GATE_TOKEN_ID_LEVEL_3 = 2;
    uint32 public constant BASEHUNT_GATE_TOKEN_ID_LEVEL_4 = 3;

    ITokenERC1155 public constant MINT_NFT_COLLECTION = ITokenERC1155(0x50c68E249260053732e143d715A7F5907a213b46);

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

        // ONLINE
        productConfig[53] = ProductConfig({
            collection: BASEHUNT_GATE_NFT_COLLECTION,
            basehuntTokenId: BASEHUNT_GATE_TOKEN_ID_LEVEL_2,
            usdcPrice: 30e6,
            discount: 20,
            mintTokenId: 22
        });
        productConfig[54] = ProductConfig({
            collection: BASEHUNT_GATE_NFT_COLLECTION,
            basehuntTokenId: BASEHUNT_GATE_TOKEN_ID_LEVEL_3,
            usdcPrice: 60e6,
            discount: 25,
            mintTokenId: 23
        });
        productConfig[55] = ProductConfig({
            collection: BASEHUNT_GATE_NFT_COLLECTION,
            basehuntTokenId: BASEHUNT_GATE_TOKEN_ID_LEVEL_4,
            usdcPrice: 120e6,
            discount: 30,
            mintTokenId: 24
        });
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
    function isPurchaseAllowed(uint256, uint256 productId, address buyer, uint256, bytes memory, bytes memory)
        public
        view
        virtual
        override
        returns (bool isAllowed)
    {
        ProductConfig memory config = productConfig[productId];

        isAllowed = config.collection.balanceOf(buyer, config.basehuntTokenId) != 0;
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
        if (!isPurchaseAllowed(slicerId, productId, buyer, quantity, "", "")) {
            revert NotAllowed();
        }

        MINT_NFT_COLLECTION.mintTo(buyer, productConfig[productId].mintTokenId, "", quantity);
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
     */
    function productPrice(uint256, uint256 productId, address, uint256 quantity, address buyer, bytes memory)
        external
        view
        returns (uint256 ethPrice, uint256 currencyPrice)
    {
        ProductConfig memory config = productConfig[productId];

        if (config.collection.balanceOf(buyer, config.basehuntTokenId) != 0) {
            currencyPrice = config.usdcPrice * quantity * (100 - config.discount) / 100;
        } else {
            currencyPrice = config.usdcPrice * quantity;
        }

        ethPrice = 0;
    }
}
