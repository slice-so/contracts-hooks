// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.0;

import "../../../structs/ERC20Gate.sol";

import "../SlicerPurchasable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title SlicerPurchasable
 * @author jjranalli
 *
 * Simple token gating extension for slice products.
 */
abstract contract Gated is SlicerPurchasable, Ownable {
    /// ============ Storage ============

    // Mapping from product Ids to Drop
    mapping(uint256 => ERC20Gate) _gates;

    /// ============ Functions ============

    /**
     * @notice Overridable function containing the requirements for an account to be eligible for the purchase.
     *
     * @dev Used on the Slice interface to check whether a user is able to buy a product. See {ISlicerPurchasable}.
     */
    function isPurchaseAllowed(
        uint256,
        uint256 productId,
        address account,
        uint256,
        bytes memory,
        bytes memory
    ) public view virtual override returns (bool isAllowed) {
        uint256 accountBalance = _gates[productId].erc20.balanceOf(account);

        isAllowed = accountBalance >= _gates[productId].amount;
    }

    /**
     * Sets merkleRoot for productId
     *
     * @dev Only accessible to contract owner
     */
    function _setGate(
        uint256 productId,
        IERC20 erc20,
        uint256 amount
    ) external onlyOwner {
        _gates[productId] = ERC20Gate(erc20, amount);
    }
}
