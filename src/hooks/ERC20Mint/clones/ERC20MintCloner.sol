// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ERC20MintClone.sol";
import "@openzeppelin/contracts/proxy/Clones.sol";

/**
 * ERC20Mint clone factory contract.
 */
contract ERC20MintCloner {
    /// ============= Storage =============

    address private immutable implementation;

    /// ========== Constructor ==========

    /**
     * @notice Initializes the contract and deploys the clone implementation.
     */
    constructor() {
        implementation = address(new ERC20MintClone());
    }

    /// ============ Functions ============

    /**
     * @notice Deploy and initialize proxy clone.
     */
    function clone(
        address productsModuleAddress_,
        uint256 slicerId_,
        string memory name_,
        string memory symbol_,
        uint256 premintAmount,
        uint256 allowedProductId_
    ) external returns (address contractAddress) {
        // Deploys proxy clone
        contractAddress = Clones.clone(implementation);

        // Initialize proxy
        ERC20MintClone(contractAddress).initialize(
            productsModuleAddress_, slicerId_, name_, symbol_, premintAmount, allowedProductId_
        );
    }
}
