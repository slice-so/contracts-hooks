// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../../../extensions/Purchasable/SlicerPurchasableClone.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

/**
 * ERC20Mint purchase hook.
 *
 * Mints 1000 tokens for each unit purchased.
 */
contract ERC20MintClone is Initializable, ERC20Upgradeable, SlicerPurchasableClone {
    // =============================================================
    //                           Errors
    // =============================================================

    error WrongProductId();

    // =============================================================
    //                           Storage
    // =============================================================

    uint256 public allowedProductId;

    // =============================================================
    //                         Constructor
    // =============================================================

    /**
     * @notice Initializes the contract.
     *
     * @param productsModuleAddress_ {ProductsModule} address
     * @param slicerId_ ID of the slicer linked to this contract
     * @param name_ Name of the ERC721 contract
     * @param symbol_ Symbol of the ERC721 contract
     * @param premintReceiver Address to mint premint tokens to
     * @param premintAmount Amount of tokens to mint to the contract creator
     * @param allowedProductId_ ID of the product allowed to be purchased
     */
    function initialize(
        address productsModuleAddress_,
        uint256 slicerId_,
        string memory name_,
        string memory symbol_,
        address premintReceiver,
        uint256 premintAmount,
        uint256 allowedProductId_
    ) external initializer {
        __SlicerPurchasableClone_init(productsModuleAddress_, slicerId_);
        __ERC20_init(name_, symbol_);

        allowedProductId = allowedProductId_;

        if (premintAmount != 0) {
            _mint(premintReceiver, premintAmount);
        }
    }

    constructor() {
        _disableInitializers();
    }

    // =============================================================
    //                         Purchase hook
    // =============================================================

    /**
     * @notice Overridable function to handle external calls on product purchases from slicers. See {ISlicerPurchasable}
     */
    function onProductPurchase(
        uint256 slicerId,
        uint256 productId,
        address buyer,
        uint256 quantity,
        bytes memory,
        bytes memory
    ) public payable override onlyOnPurchaseFrom(slicerId) {
        if (allowedProductId != 0) {
            if (productId != allowedProductId) revert WrongProductId();
        }

        // Mint tokens
        _mint(buyer, quantity * 1e21);
    }
}
