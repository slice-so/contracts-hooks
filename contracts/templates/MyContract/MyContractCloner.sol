// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./MyContract.sol";
import "@openzeppelin/contracts/proxy/Clones.sol";

/**
 * Deploy clones of my purchase hook.
 */
contract MyContractCloner {
    /// ============= Storage =============

    address private immutable implementation;

    /// ========== Constructor ==========

    /**
     * @notice Initializes the contract and deploys the clone implementation.
     */
    constructor() {
        implementation = address(new MyContract());
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
        MyContract(contractAddress).initialize(productsModuleAddress_, slicerId_);
    }
}
