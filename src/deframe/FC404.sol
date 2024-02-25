// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {DN404} from "dn404/DN404.sol";
import {DN404Mirror} from "dn404/DN404Mirror.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {IERC721} from "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import {SlicerPurchasableImmutable} from "../extensions/Purchasable/SlicerPurchasableImmutable.sol";
import {FC404Metadata} from "./utils/FC404Metadata.sol";

contract FC404 is DN404, SlicerPurchasableImmutable {
    /*//////////////////////////////////////////////////////////////
                                 ERRORS
    //////////////////////////////////////////////////////////////*/

    /// @notice Emitted when this hook is called by a different productId.
    error WrongProductId();

    /// @notice Emitted when a buyer has already claimed.
    error AlreadyClaimed();

    /// @notice Emitted when a token hasn't been minted.
    error TokenUnminted();

    /*//////////////////////////////////////////////////////////////
                           IMMUTABLE STORAGE
    //////////////////////////////////////////////////////////////*/

    uint256 public constant ENABLED_PRODUCT_ID = 1;
    address internal constant RELAYER = 0x320DE7bBE088167617Aa7C8b6a3aA7C2a287EC71;

    // Min amount of Degen necessary to be eligible
    // TODO: Define amount
    uint256 internal constant MIN_DEGEN_AMOUNT = 5e24;
    address internal constant DEGEN = 0x4ed4E862860beD51a9570b96d89aF5E1B0Efefed;

    IERC721[] internal WHITELISTED_NFTS = [
        IERC721(0x73682A7f47Cb707C52cb38192dBB9266D3220315) // outcasts
            // TODO: add collections
    ];

    // Supply value under which the free mint stage applies
    uint256 internal immutable FIRST_STAGE_TOKEN_AMOUNT;

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

        FIRST_STAGE_TOKEN_AMOUNT = initialTokenSupply + (1000 * _unit());
    }

    // Edited to mint both tokens and nfts to `initialSupplyOwner`
    function _initializeDN404(uint256 initialTokenSupply, address initialSupplyOwner, address mirror)
        internal
        override
    {
        DN404Storage storage $ = _getDN404Storage();

        if ($.nextTokenId != 0) revert DNAlreadyInitialized();

        if (mirror == address(0)) revert MirrorAddressIsZero();

        /// @solidity memory-safe-assembly
        assembly {
            // Make the call to link the mirror contract.
            mstore(0x00, 0x0f4599e5) // `linkMirrorContract(address)`.
            mstore(0x20, caller())
            if iszero(and(eq(mload(0x00), 1), call(gas(), mirror, 0, 0x1c, 0x24, 0x00, 0x20))) {
                mstore(0x00, 0xd125259c) // `LinkMirrorContractFailed()`.
                revert(0x1c, 0x04)
            }
        }

        $.nextTokenId = 1;
        $.mirrorERC721 = mirror;

        if (_unit() == 0) revert UnitIsZero();

        if (initialTokenSupply != 0) {
            _mint(initialSupplyOwner, initialTokenSupply);
        }
    }

    /*//////////////////////////////////////////////////////////////
                             PURCHASE HOOK
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Overridable function containing the requirements for an account to be eligible for the purchase*
     * @dev Used on the Slice interface to check whether a user is able to buy a product. See {ISlicerPurchasable}.
     * @dev Max quantity purchasable per address and total mint amount is handled on ProductsModule
     */
    function isPurchaseAllowed(uint256, uint256, address buyer, uint256, bytes memory, bytes memory)
        public
        view
        virtual
        override
        returns (bool isAllowed)
    {
        if (_isFirstStage()) {
            bool isEligible = IERC20(DEGEN).balanceOf(buyer) >= MIN_DEGEN_AMOUNT;

            for (uint256 i = 0; i < WHITELISTED_NFTS.length; ++i) {
                if (WHITELISTED_NFTS[i].balanceOf(buyer) != 0) {
                    isEligible = true;
                    break;
                }
            }

            isAllowed = tx.origin == RELAYER && isEligible;
        }

        return true;
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
        if (ENABLED_PRODUCT_ID != productId) revert WrongProductId();

        // for the first 1000 nfts, only allow mints on farcaster and once per fid.
        if (_isFirstStage()) {
            // cast the first 3 bytes of buyerCustomData to `uint24 fid`
            uint24 fid = uint24(bytes3(buyerCustomData));

            if (hasClaimed[fid]) revert AlreadyClaimed();

            if (!isPurchaseAllowed(slicerId, productId, buyer, quantity, "", "")) revert NotAllowed();

            hasClaimed[fid] = true;
        }

        _mint(buyer, quantity * _unit());
    }

    /*//////////////////////////////////////////////////////////////
                                EXTERNAL
    //////////////////////////////////////////////////////////////*/

    /// @inheritdoc DN404
    function name() public view override returns (string memory) {
        return _name;
    }

    /// @inheritdoc DN404
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

    /// @inheritdoc DN404
    function _unit() internal pure override returns (uint256) {
        return 1e24;
    }

    // Defines the conditions for the first stage of the mint
    function _isFirstStage() internal view returns (bool) {
        return totalSupply() < FIRST_STAGE_TOKEN_AMOUNT;
    }
}
