// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {DN404} from "dn404/DN404.sol";
import {DN404Mirror} from "dn404/DN404Mirror.sol";
import {Tippable} from "./Tippable.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {IERC721} from "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import {SlicerPurchasableImmutable} from "../extensions/Purchasable/SlicerPurchasableImmutable.sol";
import {FC404Metadata} from "./utils/FC404Metadata.sol";

contract FC404 is DN404, Tippable, SlicerPurchasableImmutable {
    /*//////////////////////////////////////////////////////////////
                                 ERRORS
    //////////////////////////////////////////////////////////////*/

    /// Emitted when this hook is called by a different productId.
    error WrongProductId();

    /// Emitted when a buyer has already claimed.
    error AlreadyClaimed();

    /// Emitted when a token hasn't been minted.
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

    // The number of cycles to average the allowance.
    uint256 public constant ALLOWANCE_AVERAGE_CYCLES = 7;
    // Supply value under which the free mint stage applies
    uint256 internal constant FIRST_STAGE_NFT_UNITS = 500;

    uint256 internal immutable FIRST_STAGE_TOKEN_AMOUNT;

    /*//////////////////////////////////////////////////////////////
                                STORAGE
    //////////////////////////////////////////////////////////////*/

    string private _name;
    string private _symbol;

    mapping(uint24 fid => bool) public hasClaimed;
    mapping(uint256 cycle => uint256 tipAmount) public tipsPerCycle;

    /*//////////////////////////////////////////////////////////////
                              CONSTRUCTOR
    //////////////////////////////////////////////////////////////*/

    /**
     * Initializes the contract.
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
    ) SlicerPurchasableImmutable(productsModuleAddress_, slicerId_) Tippable(1 days) {
        _name = name_;
        _symbol = symbol_;

        address mirror = address(new DN404Mirror(msg.sender));
        _initializeDN404(initialTokenSupply, initialSupplyOwner, mirror);

        FIRST_STAGE_TOKEN_AMOUNT = initialTokenSupply + (FIRST_STAGE_NFT_UNITS * _unit());
    }

    // Edited to mint both tokens and nfts to `initialSupplyOwner`
    function _initializeDN404(uint256 initialTokenSupply, address initialSupplyOwner, address mirror)
        internal
        override
    {
        DN404Storage storage $ = _getDN404Storage();

        unchecked {
            if (_unit() - 1 >= 2 ** 96 - 1) revert InvalidUnit();
        }
        if ($.mirrorERC721 != address(0)) revert DNAlreadyInitialized();
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

        if (initialTokenSupply != 0) {
            _mint(initialSupplyOwner, initialTokenSupply);
        }
    }

    /*//////////////////////////////////////////////////////////////
                             PURCHASE HOOK
    //////////////////////////////////////////////////////////////*/

    /**
     * Overridable function containing the requirements for an account to be eligible for the purchase*
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
        } else {
            return true;
        }
    }

    /**
     * Overridable function to handle external calls on product purchases from slicers. See {ISlicerPurchasable}
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

        // for the first `FIRST_STAGE_NFT_UNITS` nfts, only allow mints on farcaster and once per fid.
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
    function _tokenURI(uint256 _id) internal view override returns (string memory) {
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

    /*//////////////////////////////////////////////////////////////
                            TIPPABLE CONFIG
    //////////////////////////////////////////////////////////////*/

    // Modified to store the total tips made per cycle
    function _onTip(uint256 currentCycle_, address, address, uint256 amount) internal override {
        tipsPerCycle[currentCycle_] += amount;
    }

    // Mint `amount` tokens to `account`
    function _onClaim(address account, uint256 amount) internal override {
        _mint(account, amount);
    }

    // Modified to mint tokens equal to `_unit()` for each cycle
    function _deriveAmountReceived(address account, uint256 cycle) internal view override returns (uint256) {
        return tipsReceived[account][cycle] * _unit() / tipsPerCycle[cycle];
    }

    // Calculate allowance by averaging tips among last `TIP_AVERAGE_CYCLE` cycles
    function _allowance(address account) public view override returns (uint256) {
        uint256 currentCycle_ = currentCycle();

        uint256 cycle;
        uint256 accountAllowance;
        uint256 totalCycles = 1;
        for (; totalCycles <= ALLOWANCE_AVERAGE_CYCLES;) {
            if (totalCycles > currentCycle_) break;

            unchecked {
                cycle = currentCycle_ - totalCycles;
            }
            accountAllowance += tipsReceived[account][cycle];

            unchecked {
                ++totalCycles;
            }
        }

        uint256 balanceAllowance = balanceOf(account) / 10;
        accountAllowance = accountAllowance / totalCycles;

        // Take the highest between balance and account allowances
        return (balanceAllowance > accountAllowance ? balanceAllowance : accountAllowance)
            - tipsMade[account][currentCycle_];
    }
}

// TODO: Tippable
//
// - Make sure allowances cannot be gamed
// - Incentivise tipping by ...
