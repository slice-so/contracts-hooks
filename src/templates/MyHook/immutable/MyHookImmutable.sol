// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../MyHook.sol";

/**
 * MyHook purchase hook.
 */
contract MyHookImmutable is MyHook {
    /// ============ Constructor ============

    /**
     * @notice Initializes the contract.
     *
     * @param productsModuleAddress_ {ProductsModule} address
     * @param slicerId_ ID of the slicer linked to this contract
     */
    constructor(address productsModuleAddress_, uint256 slicerId_) {
        _productsModuleAddress = productsModuleAddress_;
        _slicerId = slicerId_;

        // Add other variables to initialize here
    }
}
