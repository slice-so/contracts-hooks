// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "../../extensions/Purchasable/SlicerPurchasable.sol";
import {IERC20} from "@openzeppelin/contracts/interfaces/IERC20.sol";

/**
 * @title Hook for Howard Coffee to transfer tokens on purchase
 * @author jacopo.eth
 */
contract BaseCafe_Howard_SliceHook is SlicerPurchasable {
    /*//////////////////////////////////////////////////////////////
                           IMMUTABLE STORAGE
    //////////////////////////////////////////////////////////////*/

    IERC20 public constant BTCB_ADDRESS = IERC20(0x0c41F1FC9022FEB69aF6dc666aBfE73C9FFDA7ce);
    uint256 public constant BTCB_AMOUNT = 33e18;
    IERC20 public constant DOOMER_ADDRESS = IERC20(0xD3741ac9B3f280B0819191E4b30be4ECd990771e);
    uint256 public constant DOOMER_AMOUNT = 6900e8;
    address private constant SENDER = 0x03489E02BF56B43a8e91287E8cFef76a7a6a9aa3;

    /*//////////////////////////////////////////////////////////////
                                STORAGE
    //////////////////////////////////////////////////////////////*/

    mapping(address buyer => bool claimed) public hasClaimed;

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
     * @notice Transfer tokens to buyer on purchase.
     */
    function onProductPurchase(uint256 slicerId, uint256, address buyer, uint256, bytes memory, bytes memory)
        public
        payable
        override
        onlyOnPurchaseFrom(slicerId)
    {
        if (!hasClaimed[buyer]) {
            hasClaimed[buyer] = true;
            BTCB_ADDRESS.transferFrom(SENDER, buyer, BTCB_AMOUNT);
            DOOMER_ADDRESS.transferFrom(SENDER, buyer, DOOMER_AMOUNT);
        }
    }
}
