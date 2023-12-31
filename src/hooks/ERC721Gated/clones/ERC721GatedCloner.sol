// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ERC721GatedClone.sol";
import "@openzeppelin/contracts/proxy/Clones.sol";

/**
 * ERC721Gated clone factory contract.
 */
contract ERC721GatedCloner {
    /// ============= Storage =============

    address private immutable implementation;

    /// ========== Constructor ==========

    /**
     * @notice Initializes the contract and deploys the clone implementation.
     */
    constructor() {
        implementation = address(new ERC721GatedClone());
    }

    /// ============ Functions ============

    /**
     * @notice Deploy and initialize proxy clone.
     */
    function clone(address productsModuleAddress_, uint256 slicerId_, IERC721[] memory erc721_, uint256 minQuantity_)
        external
        returns (address contractAddress)
    {
        // Deploys proxy clone
        contractAddress = Clones.clone(implementation);

        // Initialize proxy
        ERC721GatedClone(contractAddress).initialize(productsModuleAddress_, slicerId_, erc721_, minQuantity_);
    }
}
