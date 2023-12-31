// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import "../../extensions/Purchasable/SlicerPurchasable.sol";
import "../interfaces/ITokenERC1155.sol";

/**
 * @title Hook to mint Based Merch NFTs
 * @author jacopo.eth / slice
 */
contract BasedMerch_SliceHook is SlicerPurchasable, Ownable {
    /*//////////////////////////////////////////////////////////////
                           IMMUTABLE STORAGE
    //////////////////////////////////////////////////////////////*/

    ITokenERC1155 public constant nft = ITokenERC1155(0xfCA2e8a8BBDDCA5727F300887F3fE0ad59932B92);

    struct Token {
        uint248 id;
        bool isSet;
    }

    mapping(uint256 productId => Token) public tokens;

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

    function setToken(uint256 productId, uint248 tokenId, bool isSet) external onlyOwner {
        tokens[productId] = Token(tokenId, isSet);
    }

    /**
     * @notice Mint `quantity` NFTs to `account`
     */
    function onProductPurchase(
        uint256 slicerId,
        uint256 productId,
        address account,
        uint256 quantity,
        bytes memory,
        bytes memory
    ) public payable override onlyOnPurchaseFrom(slicerId) {
        Token memory token = tokens[productId];

        if (token.isSet) {
            nft.mintTo(account, token.id, "", quantity);
        }
    }
}
