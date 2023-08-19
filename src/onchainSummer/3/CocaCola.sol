// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../../extensions/Purchasable/SlicerPurchasable.sol";
import "../interfaces/IOpenEditionERC721.sol";

/**
 * @title CocaCola - Mint the Coca Cola - Bedroom in Arles NFTs
 * @author jacopo.eth / slice
 */
contract CocaCola_SliceHook is SlicerPurchasable {
    /*//////////////////////////////////////////////////////////////
                                 ERRORS
    //////////////////////////////////////////////////////////////*/

    error MintEnded();

    /*//////////////////////////////////////////////////////////////
                           IMMUTABLE STORAGE
    //////////////////////////////////////////////////////////////*/

    IOpenEditionERC721 public immutable nft;

    /*//////////////////////////////////////////////////////////////
                              CONSTRUCTOR
    //////////////////////////////////////////////////////////////*/

    constructor(address productsModuleAddress_, address nft_) {
        _productsModuleAddress = productsModuleAddress_;
        nft = IOpenEditionERC721(nft_);
    }

    /*//////////////////////////////////////////////////////////////
                               FUNCTIONS
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Purchase is allowed if `quantityLimitPerWallet` is different than 0 in active `claimCondition`
     */
    function isPurchaseAllowed(uint256, uint256, address, uint256, bytes memory, bytes memory)
        public
        view
        virtual
        override
        returns (bool isAllowed)
    {
        ClaimCondition memory claimCondition = nft.getClaimConditionById(nft.getActiveClaimConditionId());

        isAllowed = claimCondition.quantityLimitPerWallet != 0;
    }

    /**
     * @notice Mint `quantity` NFTs to `account`
     */
    function onProductPurchase(uint256, uint256, address account, uint256 quantity, bytes memory, bytes memory)
        public
        payable
        override
    {
        ClaimCondition memory claimCondition = nft.getClaimConditionById(nft.getActiveClaimConditionId());

        if (claimCondition.quantityLimitPerWallet == 0) revert MintEnded();

        nft.claim{value: msg.value}(
            account,
            quantity,
            claimCondition.currency,
            claimCondition.pricePerToken,
            AllowlistProof(new bytes32[](0), 0, 0, address(0)),
            ""
        );
    }
}
