// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Allowlisted.sol";
import "@openzeppelin/contracts/proxy/Clones.sol";

/**
 * Deploy clones of purchase hook with allowlist requirement.
 */
contract AllowlistedCloner {
    /// ============= Storage =============

    address private immutable implementation;

    /// ========== Constructor ==========

    /**
     * @notice Initializes the contract and deploys the clone implementation.
     */
    constructor() {
        implementation = address(new Allowlisted());
    }

    /// ============ Functions ============

    /**
     * @notice Deploy and initialize proxy clone.
     */
    function clone(
        address productsModuleAddress_,
        uint256 slicerId_,
        bytes32 merkleRoot_
    ) external returns (address contractAddress) {
        // Deploys proxy clone
        contractAddress = Clones.clone(implementation);

        // Initialize proxy
        Allowlisted(contractAddress).initialize(productsModuleAddress_, slicerId_, merkleRoot_);
    }
}
