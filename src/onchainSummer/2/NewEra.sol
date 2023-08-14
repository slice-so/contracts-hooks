// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../../extensions/Purchasable/SlicerPurchasable.sol";
import "../interfaces/IOpenEditionERC721.sol";

/**
 * @title NewEra - Mint the New Era NFT
 * @author jacopo.eth / slice
 */
contract NewEra_SliceHook is SlicerPurchasable {
    /*//////////////////////////////////////////////////////////////
                           IMMUTABLE STORAGE
    //////////////////////////////////////////////////////////////*/

    IOpenEditionERC721 public constant nft = IOpenEditionERC721(0xc9Cca8E570F81a7476760279B5B19cc1130B7580);

    address public constant referrer = 0xC64563B8a9776C47E68Ed9891A60cC81FB7c3f64;

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
