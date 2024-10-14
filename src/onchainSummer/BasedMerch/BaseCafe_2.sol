// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "../../extensions/Purchasable/SlicerPurchasable.sol";
import "../interfaces/ITokenERC1155.sol";

/**
 * @title Base Cafe - Slice onchain action
 * @author jacopo.eth
 */
contract BaseCafe_SliceHook_2 is SlicerPurchasable {
    /*//////////////////////////////////////////////////////////////
                           IMMUTABLE STORAGE
    //////////////////////////////////////////////////////////////*/

    ITokenERC1155 public constant MINT_NFT_COLLECTION = ITokenERC1155(0x8485A580A9975deF42F8C7c5C63E9a0FF058561D);
    uint256 public constant MINT_NFT_TOKEN_ID = 9;

    /*//////////////////////////////////////////////////////////////
                              CONSTRUCTOR
    //////////////////////////////////////////////////////////////*/

    constructor(address productsModuleAddress_, uint256 slicerId_) {
        _productsModuleAddress = productsModuleAddress_;
        _slicerId = slicerId_;
    }

    /*//////////////////////////////////////////////////////////////
                               FUNCTIONS
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Mint `quantity` NFTs to `account` on purchase
     */
    function onProductPurchase(uint256 slicerId, uint256, address buyer, uint256 quantity, bytes memory, bytes memory)
        public
        payable
        override
        onlyOnPurchaseFrom(slicerId)
    {
        MINT_NFT_COLLECTION.mintTo(buyer, MINT_NFT_TOKEN_ID, "", quantity);
    }
}
