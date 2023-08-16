// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../../extensions/Purchasable/SlicerPurchasable.sol";
import "../interfaces/IERC1155Drop.sol";
import {IMinter1155, SalesConfig} from "../interfaces/IMinter1155.sol";

/**
 * @title SummerZorb - Mint the Summer Zorb NFT
 * @author jacopo.eth / slice
 */
contract SummerZorb_SliceHook is SlicerPurchasable {
    /*//////////////////////////////////////////////////////////////
                           IMMUTABLE STORAGE
    //////////////////////////////////////////////////////////////*/

    IMinter1155 public constant minter = IMinter1155(0xFF8B0f870ff56870Dc5aBd6cB3E6E89c8ba2e062);

    IERC1155Drop public constant nft = IERC1155Drop(0xBd52c54aB5116b1D9326352F742E6544FfdEB2cB);

    address public constant referrer = 0xC64563B8a9776C47E68Ed9891A60cC81FB7c3f64;

    uint256 public constant tokenId = 1;

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
     * @notice Purchase is allowed if block.timestamp is in the sale window
     */
    function isPurchaseAllowed(uint256, uint256, address, uint256, bytes memory, bytes memory)
        public
        view
        virtual
        override
        returns (bool isAllowed)
    {
        SalesConfig memory salesConfig = minter.sale(address(nft), tokenId);

        isAllowed = salesConfig.saleStart < block.timestamp && salesConfig.saleEnd > block.timestamp;
    }

    /**
     * @notice Mint `quantity` NFTs to `account`
     */
    function onProductPurchase(uint256, uint256, address account, uint256 quantity, bytes memory, bytes memory)
        public
        payable
        override
    {
        bytes memory minterArguments = abi.encode(account, "Minted from base.slice.so");

        nft.mintWithRewards{value: msg.value}(minter, tokenId, quantity, minterArguments, referrer);
    }
}
