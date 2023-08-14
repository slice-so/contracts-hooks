// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../../extensions/Purchasable/SlicerPurchasable.sol";
import "./interfaces/IERC721Drop.sol";

contract BaseDayOne is SlicerPurchasable {
    /// ============= Storage =============

    IERC721Drop private constant nft = IERC721Drop(0x7d5861cfe1C74Aaa0999b7E2651Bf2ebD2A62D89);

    address private constant referrer = 0xC64563B8a9776C47E68Ed9891A60cC81FB7c3f64;

    /// ============ Constructor ============

    /**
     * @notice Initializes the contract.
     *
     * @param productsModuleAddress_ {ProductsModule} address
     */
    constructor(address productsModuleAddress_) {
        _productsModuleAddress = productsModuleAddress_;
    }

    /// ============ Functions ============

    /**
     * @notice Purchase is allowed if block.timestamp is in the sale window
     */
    function isPurchaseAllowed(
        uint256,
        uint256,
        address,
        uint256,
        bytes memory,
        bytes memory
    ) public view virtual override returns (bool isAllowed) {
        (, , uint64 publicSaleStart, uint64 publicSaleEnd, , , ) = nft.salesConfig();
        isAllowed = publicSaleStart < block.timestamp && publicSaleEnd > block.timestamp;
    }

    /**
     * @notice Mint `quantity` NFTs to `account`
     */
    function onProductPurchase(
        uint256,
        uint256,
        address account,
        uint256 quantity,
        bytes memory,
        bytes memory
    ) public payable override {
        unchecked {
            nft.mintWithRewards{value: msg.value}(account, quantity, "", referrer);
        }
    }
}
