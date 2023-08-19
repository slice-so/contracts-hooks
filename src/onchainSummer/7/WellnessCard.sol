// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../../extensions/Purchasable/SlicerPurchasable.sol";
import "../interfaces/IOpenEditionERC721.sol";

/**
 * @title WellnessCard - Mint The Wellness Card NFT
 * @author jacopo.eth / slice
 */
contract WellnessCard_SliceHook is SlicerPurchasable {
    /*//////////////////////////////////////////////////////////////
                           IMMUTABLE STORAGE
    //////////////////////////////////////////////////////////////*/

    IOpenEditionERC721 public constant nft = IOpenEditionERC721(0x6a55463a66e585767c6Cce622d2018572a0aa7D1);

    /*//////////////////////////////////////////////////////////////
                              CONSTRUCTOR
    //////////////////////////////////////////////////////////////*/

    constructor(address productsModuleAddress_) {
        _productsModuleAddress = productsModuleAddress_;
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
