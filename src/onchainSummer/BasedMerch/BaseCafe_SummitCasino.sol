// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import "../../extensions/Purchasable/SlicerPurchasable.sol";
import "../interfaces/ITokenERC1155.sol";

/**
 * @title State of Crypto - Slice onchain action
 * @author jacopo.eth
 */
contract BaseCafe_SummitCasino_SliceHook is SlicerPurchasable, Ownable {
    /*//////////////////////////////////////////////////////////////
                           IMMUTABLE STORAGE
    //////////////////////////////////////////////////////////////*/

    ITokenERC1155 public constant MINT_NFT_COLLECTION = ITokenERC1155(0x1f2D6B4132BaDf9d2bFa2d7f4050314F82641754);

    mapping(uint256 productId => Token) public mintParams;

    /*//////////////////////////////////////////////////////////////
                              CONSTRUCTOR
    //////////////////////////////////////////////////////////////*/

    constructor(address productsModuleAddress_, uint256 slicerId_) {
        _productsModuleAddress = productsModuleAddress_;
        _slicerId = slicerId_;

        mintParams[1] = Token(0, true);
        mintParams[2] = Token(1, true);
        mintParams[3] = Token(2, true);
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
    ) public payable override onlyOnPurchaseFrom(slicerId) {
        Token memory mintParams_ = mintParams[productId];

        if (mintParams_.enabled) {
            MINT_NFT_COLLECTION.mintTo(buyer, mintParams_.tokenId, "", quantity);
        }
    }

    function setMintParams(uint256 productId, uint88 tokenId, bool enabled) public onlyOwner {
        mintParams[productId] = Token(tokenId, enabled);
    }
}

struct Token {
    uint88 tokenId;
    bool enabled;
}
