// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../ERC20Gated.sol";

/**
 * ERC20Gated purchase hook.
 */
contract ERC20GatedImmutable is ERC20Gated {
    /// ============ Constructor ============

    /**
     * @notice Initializes the contract.
     *
     * @param productsModuleAddress_ {ProductsModule} address
     * @param slicerId_ ID of the slicer linked to this contract
     * @param erc20_ Address of the ERC20 contract used for gating
     * @param gateAmount_ Amount of ERC20 tokens used for gating
     */
    constructor(
        address productsModuleAddress_,
        uint256 slicerId_,
        IERC20 erc20_,
        uint256 gateAmount_
    ) {
        _productsModuleAddress = productsModuleAddress_;
        _slicerId = slicerId_;
        gate = ERC20Gate(erc20_, gateAmount_);
    }
}
