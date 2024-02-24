// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "dn404/DN404.sol";
import "dn404/DN404Mirror.sol";

import "../extensions/Purchasable/SlicerPurchasableImmutable.sol";
import {FC404Metadata} from "./utils/FC404Metadata.sol";

contract FC404 is DN404, SlicerPurchasableImmutable {
    /*//////////////////////////////////////////////////////////////
                                 ERRORS
    //////////////////////////////////////////////////////////////*/

    error AlreadyClaimed();

    /// @notice Emitted when a token hasn't been minted.
    error TokenUnminted();

    /*//////////////////////////////////////////////////////////////
                           IMMUTABLE STORAGE
    //////////////////////////////////////////////////////////////*/

    uint256 public constant ENABLED_PRODUCT_ID = 6;
    address internal constant RELAYER = 0x320DE7bBE088167617Aa7C8b6a3aA7C2a287EC71;

    /*//////////////////////////////////////////////////////////////
                                STORAGE
    //////////////////////////////////////////////////////////////*/

    string private _name;
    string private _symbol;

    mapping(uint24 fid => bool) public hasClaimed;

    /*//////////////////////////////////////////////////////////////
                              CONSTRUCTOR
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Initializes the contract.
     *
     * @param productsModuleAddress_ {ProductsModule} address
     * @param slicerId_ ID of the slicer linked to this contract
     * @param name_ Name of the token
     * @param symbol_ Symbol of the token
     * @param initialTokenSupply Initial supply of the token
     * @param initialSupplyOwner Address that will receive the initial supply
     */
    constructor(
        address productsModuleAddress_,
        uint256 slicerId_,
        string memory name_,
        string memory symbol_,
        uint96 initialTokenSupply,
        address initialSupplyOwner
    ) SlicerPurchasableImmutable(productsModuleAddress_, slicerId_) {
        _name = name_;
        _symbol = symbol_;

        address mirror = address(new DN404Mirror(msg.sender));
        _initializeDN404(initialTokenSupply, initialSupplyOwner, mirror);
    }

    /*//////////////////////////////////////////////////////////////
                             PURCHASE HOOK
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Overridable function containing the requirements for an account to be eligible for the purchase*
     * @dev Used on the Slice interface to check whether a user is able to buy a product. See {ISlicerPurchasable}.
     * @dev Max quantity purchasable per address and total mint amount is handled on ProductsModule
     */
    function isPurchaseAllowed(uint256, uint256 productId, address, uint256, bytes memory, bytes memory)
        public
        view
        virtual
        override
        returns (bool isAllowed)
    {
        isAllowed = ENABLED_PRODUCT_ID == productId && tx.origin == RELAYER;
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
        bytes calldata buyerCustomData
    ) public payable override onlyOnPurchaseFrom(slicerId) {
        // cast the first 3 bytes of buyerCustomData to `uint24 fid`
        uint24 fid = uint24(bytes3(buyerCustomData));

        if (hasClaimed[fid]) revert AlreadyClaimed();

        if (!isPurchaseAllowed(slicerId, productId, buyer, quantity, "", "")) revert NotAllowed();

        hasClaimed[fid] = true;

        _mint(buyer, quantity * mintMultiplier());
    }

    /*//////////////////////////////////////////////////////////////
                                EXTERNAL
    //////////////////////////////////////////////////////////////*/

    function name() public view override returns (string memory) {
        return _name;
    }

    function symbol() public view override returns (string memory) {
        return _symbol;
    }

    /// @inheritdoc DN404
    function tokenURI(uint256 _id) public view override returns (string memory) {
        // Revert if the token hasn't been minted.
        if (_ownerOf(_id) == address(0)) revert TokenUnminted();

        // Generate and return metadata.
        return FC404Metadata.render(_id);
    }

    /*//////////////////////////////////////////////////////////////
                                INTERNAL
    //////////////////////////////////////////////////////////////*/

    // TODO: Make it variable based on supply
    function mintMultiplier() internal pure returns (uint256) {
        return 1e18;
    }
}
