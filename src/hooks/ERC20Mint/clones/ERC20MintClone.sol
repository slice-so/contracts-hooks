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

    error InvalidTokensPerUnit();
    error WrongProductId();

    // =============================================================
    //                           Storage
    // =============================================================

    uint256 public allowedProductId;
    uint256 public maxSupply;
    uint256 public tokensPerUnit;

    // =============================================================
    //                         Constructor
    // =============================================================

    constructor() {
        _disableInitializers();
    }

    /**
     * @notice Initializes the contract.
     *
     * @param productsModuleAddress_ {ProductsModule} address
     * @param slicerId_ ID of the slicer linked to this contract
     * @param name_ Name of the ERC721 contract
     * @param symbol_ Symbol of the ERC721 contract
     * @param tokensPerUnit_ Amount of tokens to mint per unit purchased
     * @param maxSupply_ Maximum amount of tokens that can be minted
     * @param premintReceiver Address to mint premint tokens to
     * @param premintAmount Amount of tokens to mint to the contract creator
     * @param allowedProductId_ ID of the product allowed to be purchased
     */
    function initialize(
        address productsModuleAddress_,
        uint256 slicerId_,
        string memory name_,
        string memory symbol_,
        uint256 tokensPerUnit_,
        uint256 maxSupply_,
        address premintReceiver,
        uint256 premintAmount,
        uint256 allowedProductId_
    ) external initializer {
        __SlicerPurchasableClone_init(productsModuleAddress_, slicerId_);
        __ERC20_init(name_, symbol_);

        if (tokensPerUnit_ == 0) revert InvalidTokensPerUnit();

        allowedProductId = allowedProductId_;
        maxSupply = maxSupply_;
        tokensPerUnit = tokensPerUnit_;

        if (premintAmount != 0) {
            _mint(premintReceiver, premintAmount);
        }
    }

    // =============================================================
    //                         Purchase hook
    // =============================================================

    /**
     * @notice Overridable function containing the requirements for the purchase.
     *
     * Check if `maxSupply` is exceeded.
     */
    function isPurchaseAllowed(uint256, uint256, address, uint256 quantity, bytes memory, bytes memory)
        public
        view
        virtual
        override
        returns (bool isAllowed)
    {
        // if maxSupply is 0, there is no limit
        if (maxSupply == 0) {
            return true;
        }

        isAllowed = totalSupply() + (quantity * tokensPerUnit) <= maxSupply;
    }

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
        if (!isPurchaseAllowed(slicerId, productId, buyer, quantity, "", "")) revert NotAllowed();

        if (allowedProductId != 0) {
            if (productId != allowedProductId) revert WrongProductId();
        }

        // Mint tokens
        _mint(buyer, quantity * tokensPerUnit);
    }
}
