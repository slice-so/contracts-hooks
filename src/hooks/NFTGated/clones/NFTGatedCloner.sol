// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./NFTGatedClone.sol";
import "@openzeppelin/contracts/proxy/Clones.sol";

/**
 * NFTGated clone factory contract.
 */
contract NFTGatedCloner {
    /// ============= Storage =============

    address private immutable implementation;

    /// ========== Constructor ==========

    /**
     * @notice Initializes the contract and deploys the clone implementation.
     */
    constructor() {
        implementation = address(new NFTGatedClone());
    }

    /// ============ Functions ============

    /**
     * @notice Deploy and initialize proxy clone.
     */
    function clone(
        address productsModuleAddress_,
        uint256 slicerId_,
        NFTData[] memory nftData_,
        uint256 minTotalQuantity_
    ) external returns (address contractAddress) {
        // Deploys proxy clone
        contractAddress = Clones.clone(implementation);

        // Initialize proxy
        NFTGatedClone(contractAddress).initialize(productsModuleAddress_, slicerId_, nftData_, minTotalQuantity_);
    }
}
