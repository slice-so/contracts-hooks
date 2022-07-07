// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ERC20Gated.sol";
import "@openzeppelin/contracts/proxy/Clones.sol";

/**
 * Purchase hook with single ERC20 Gate.
*/
contract ERC20GatedCloner {

    /// ============= Storage =============

    address private immutable implementation;

    /// ========== Constructor ==========

    /**
     * @notice Initializes the contract and deploys the clone implementation.
     */
    constructor() {
        implementation = address(new ERC20Gated());
    }

    /// ============ Functions ============

    /**
     * @notice Deploy and initialize proxy clone.
     */
    function clone(
        address productsModuleAddress_, 
        uint256 slicerId_,
        IERC20 erc20_,
        uint256 gateAmount_
    ) external returns (address contractAddress) {
        // Deploys proxy clone
        contractAddress = Clones.clone(implementation);

        // Initialize proxy
        ERC20Gated(contractAddress).initialize(
            productsModuleAddress_, 
            slicerId_, 
            erc20_, 
            gateAmount_
        );
    }
}
