// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./MyHookClone.sol";
import "@openzeppelin/contracts/proxy/Clones.sol";

/**
 * MyHook clone factory contract.
 */
contract MyHookCloner {
    /// ============= Storage =============

    address private immutable implementation;

    /// ========== Constructor ==========

    /**
     * @notice Initializes the contract and deploys the clone implementation.
     */
    constructor() {
        implementation = address(new MyHookClone());
    }

    /// ============ Functions ============

    /**
     * @notice Deploy and initialize proxy clone.
     */
    function clone(address productsModuleAddress_, uint256 slicerId_)
        external
        returns (address contractAddress)
    {
        // Deploys proxy clone
        contractAddress = Clones.clone(implementation);

        // Initialize proxy
        MyHookClone(contractAddress).initialize(productsModuleAddress_, slicerId_);
    }
}
