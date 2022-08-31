// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../Allowlisted.sol";

/**
 * Purchase hook with allowlist requirement.
 */
contract AllowlistedImmutable is Allowlisted {
    /// ============ Constructor ============

    /**
     * @notice Initializes the contract.
     *
     * @param productsModuleAddress_ {ProductsModule} address
     * @param slicerId_ ID of the slicer linked to this contract
     * @param merkleRoot_ Merkle root used to verify proof validity
     */
    constructor(
        address productsModuleAddress_,
        uint256 slicerId_,
        bytes32 merkleRoot_
    ) {
        _productsModuleAddress = productsModuleAddress_;
        _slicerId = slicerId_;
        _merkleRoot = merkleRoot_;
    }
}
