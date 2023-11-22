// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import "../../extensions/Purchasable/SlicerPurchasable.sol";
import "../interfaces/ITokenERC1155.sol";
import {IERC1155} from "@openzeppelin/contracts/interfaces/IERC1155.sol";

/**
 * @title Hook to mint Based Merch NFTs
 * @author jacopo.eth / slice
 */
contract BasedMerchOne_SliceHook is SlicerPurchasable, Ownable {
    /*//////////////////////////////////////////////////////////////
                           IMMUTABLE STORAGE
    //////////////////////////////////////////////////////////////*/

    ITokenERC1155 public constant nft = ITokenERC1155(0xfCA2e8a8BBDDCA5727F300887F3fE0ad59932B92);
    IERC1155 public constant gatingNft = IERC1155(0x3fA36dc1508cB6f4287288d05DB1d14B486741Dc);

    struct Token {
        uint248 id;
        bool isSet;
    }

    mapping(uint256 productId => Token) public tokens;
    mapping(address buyer => uint256 purchases) public totalPurchases;

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
     * @notice Purchase is allowed if `quantityLimitPerWallet` is different than 0 in active `claimCondition`
     */
    function isPurchaseAllowed(uint256, uint256, address buyer, uint256 quantity, bytes memory, bytes memory)
        public
        view
        virtual
        override
        returns (bool isAllowed)
    {
        if (quantity == 1 && totalPurchases[buyer] == 0) {
            if (gatingNft.balanceOf(buyer, 0) != 0 || gatingNft.balanceOf(buyer, 1) != 0) {
                isAllowed = true;
            }
        }
    }

    /**
     * @notice Mint `quantity` NFTs to `account`
     */
    function onProductPurchase(
        uint256 slicerId,
        uint256 productId,
        address buyer,
        uint256 quantity,
        bytes memory,
        bytes memory
    ) public payable override onlyOnPurchaseFrom(slicerId) {
        if (!isPurchaseAllowed(0, 0, buyer, quantity, "", "")) {
            revert NotAllowed();
        }

        totalPurchases[buyer] += quantity;

        Token memory token = tokens[productId];

        if (token.isSet) {
            nft.mintTo(buyer, token.id, "", quantity);
        }
    }
}
