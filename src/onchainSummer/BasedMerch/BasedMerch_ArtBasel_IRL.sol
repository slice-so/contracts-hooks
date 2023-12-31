// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import "../../extensions/Purchasable/SlicerPurchasable.sol";
import "../../utils/sliceV1/interfaces/ISliceProductPrice.sol";
import "../../utils/sliceV1/interfaces/IProductsModule.sol";
import "../interfaces/ITokenERC1155.sol";
import {IERC1155} from "@openzeppelin/contracts/interfaces/IERC1155.sol";

struct ProductConfig {
    uint32 basehuntTokenId;
    uint32 mintTokenId;
    uint64 usdcPrice;
    bool isBaseHunt;
}

/**
 * @title Hook to mint Based Cafe NFTs and handle NFT discounts
 * @author jacopo@slice.so
 */
contract BasedMerch_ArtBasel_IRL_SliceHook is SlicerPurchasable, Ownable, ISliceProductPrice {
    /*//////////////////////////////////////////////////////////////
                                 ERRORS
    //////////////////////////////////////////////////////////////*/

    error NotProductOwner();

    /*//////////////////////////////////////////////////////////////
                           IMMUTABLE STORAGE
    //////////////////////////////////////////////////////////////*/

    IERC1155 public constant BASEHOUSE_NFT_COLLECTION = IERC1155(0x795E2477247C721f26FBeaf1234B9e7fa012F52C);
    uint256 public constant BASEHOUSE_TOKEN_ID = 2;

    IERC1155 public constant BASEHUNT_GATE_NFT_COLLECTION = IERC1155(0x7632df72835947e8bF8522B91D394f356a1471e6);
    uint32 public constant BASEHUNT_GATE_TOKEN_ID_LEVEL_1 = 0;
    uint32 public constant BASEHUNT_GATE_TOKEN_ID_LEVEL_2 = 1;
    uint32 public constant BASEHUNT_GATE_TOKEN_ID_LEVEL_3 = 2;
    uint32 public constant BASEHUNT_GATE_TOKEN_ID_LEVEL_4 = 3;

    ITokenERC1155 public constant MINT_NFT_COLLECTION = ITokenERC1155(0x50c68E249260053732e143d715A7F5907a213b46);

    /*//////////////////////////////////////////////////////////////
                                STORAGE
    //////////////////////////////////////////////////////////////*/

    mapping(address buyer => mapping(uint256 level => uint256 purchases)) public totalGatedPurchases;
    mapping(uint256 productId => ProductConfig params) public productConfig;

    /*//////////////////////////////////////////////////////////////
                              CONSTRUCTOR
    //////////////////////////////////////////////////////////////*/

    constructor(address productsModuleAddress_, uint256 slicerId_) {
        _productsModuleAddress = productsModuleAddress_;
        _slicerId = slicerId_;

        productConfig[23] = ProductConfig({
            isBaseHunt: true,
            basehuntTokenId: BASEHUNT_GATE_TOKEN_ID_LEVEL_1,
            usdcPrice: 25e6,
            mintTokenId: 14
        });
        productConfig[24] = ProductConfig({
            isBaseHunt: true,
            basehuntTokenId: BASEHUNT_GATE_TOKEN_ID_LEVEL_1,
            usdcPrice: 30e6,
            mintTokenId: 15
        });
        productConfig[25] = ProductConfig({
            isBaseHunt: true,
            basehuntTokenId: BASEHUNT_GATE_TOKEN_ID_LEVEL_2,
            usdcPrice: 40e6,
            mintTokenId: 16
        });
        productConfig[26] = ProductConfig({
            isBaseHunt: true,
            basehuntTokenId: BASEHUNT_GATE_TOKEN_ID_LEVEL_2,
            usdcPrice: 40e6,
            mintTokenId: 17
        });
        productConfig[27] = ProductConfig({
            isBaseHunt: true,
            basehuntTokenId: BASEHUNT_GATE_TOKEN_ID_LEVEL_3,
            usdcPrice: 75e6,
            mintTokenId: 18
        });
        productConfig[28] = ProductConfig({
            isBaseHunt: true,
            basehuntTokenId: BASEHUNT_GATE_TOKEN_ID_LEVEL_3,
            usdcPrice: 100e6,
            mintTokenId: 19
        });
        productConfig[29] = ProductConfig({
            isBaseHunt: true,
            basehuntTokenId: BASEHUNT_GATE_TOKEN_ID_LEVEL_4,
            usdcPrice: 200e6,
            mintTokenId: 20
        });
        productConfig[30] = ProductConfig({isBaseHunt: false, basehuntTokenId: 0, usdcPrice: 40e6, mintTokenId: 4});
        productConfig[31] = ProductConfig({isBaseHunt: false, basehuntTokenId: 0, usdcPrice: 3e6, mintTokenId: 10});
        productConfig[32] = ProductConfig({isBaseHunt: false, basehuntTokenId: 0, usdcPrice: 25e6, mintTokenId: 9});
        productConfig[33] = ProductConfig({isBaseHunt: false, basehuntTokenId: 0, usdcPrice: 30e6, mintTokenId: 8});
        productConfig[34] = ProductConfig({isBaseHunt: false, basehuntTokenId: 0, usdcPrice: 25e6, mintTokenId: 7});
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
        // Only basehunt products are gated
        if (!productConfig[productId].isBaseHunt) return true;

        if (
            totalGatedPurchases[buyer][productConfig[productId].basehuntTokenId] == 0
                && BASEHOUSE_NFT_COLLECTION.balanceOf(buyer, BASEHOUSE_TOKEN_ID) != 0
        ) {
            isAllowed = BASEHUNT_GATE_NFT_COLLECTION.balanceOf(buyer, productConfig[productId].basehuntTokenId) != 0;
        }
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

        // Only basehunt products are gated
        if (productConfig[productId].isBaseHunt) {
            unchecked {
                totalGatedPurchases[buyer][productConfig[productId].basehuntTokenId] += quantity;
            }
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
     *
     * @param buyer Address of the buyer
     *
     */
    function productPrice(uint256, uint256 productId, address, uint256 quantity, address buyer, bytes memory)
        external
        view
        returns (uint256 ethPrice, uint256 currencyPrice)
    {
        if (productConfig[productId].isBaseHunt) {
            if (BASEHUNT_GATE_NFT_COLLECTION.balanceOf(buyer, productConfig[productId].basehuntTokenId) != 0) {
                currencyPrice = 0;
            } else {
                currencyPrice = productConfig[productId].usdcPrice * quantity;
            }
        } else {
            uint256 cumulativeDiscount = 100;

            unchecked {
                if (BASEHOUSE_NFT_COLLECTION.balanceOf(buyer, BASEHOUSE_TOKEN_ID) != 0) {
                    cumulativeDiscount -= 20;
                }

                if (BASEHUNT_GATE_NFT_COLLECTION.balanceOf(buyer, BASEHUNT_GATE_TOKEN_ID_LEVEL_4) != 0) {
                    cumulativeDiscount -= 50;
                } else if (BASEHUNT_GATE_NFT_COLLECTION.balanceOf(buyer, BASEHUNT_GATE_TOKEN_ID_LEVEL_3) != 0) {
                    cumulativeDiscount -= 30;
                } else if (BASEHUNT_GATE_NFT_COLLECTION.balanceOf(buyer, BASEHUNT_GATE_TOKEN_ID_LEVEL_2) != 0) {
                    cumulativeDiscount -= 20;
                } else if (BASEHUNT_GATE_NFT_COLLECTION.balanceOf(buyer, BASEHUNT_GATE_TOKEN_ID_LEVEL_1) != 0) {
                    cumulativeDiscount -= 10;
                }
            }

            currencyPrice = productConfig[productId].usdcPrice * quantity * (cumulativeDiscount) / 100;
        }
    }
}
