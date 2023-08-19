// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../../extensions/Purchasable/SlicerPurchasable.sol";
import "../interfaces/IOpenEditionERC721.sol";

/**
 * @title SummerKevin - Mint the Summer Kevin NFT
 * @author jacopo.eth / slice
 */
contract SummerKevin_SliceHook is SlicerPurchasable {
    /*//////////////////////////////////////////////////////////////
                           IMMUTABLE STORAGE
    //////////////////////////////////////////////////////////////*/

    IOpenEditionERC721 public constant nft = IOpenEditionERC721(0x9d9c0C4e764117FccD2bc3548f0E95c806e6F996);

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
