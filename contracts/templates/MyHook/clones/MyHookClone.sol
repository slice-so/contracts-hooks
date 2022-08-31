// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../MyHook.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";

/**
 * MyHook clone purchase hook.
 */
contract MyHookClone is MyHook, Initializable {
    /// ========== Initializer ==========

    /**
     * @notice Initializes the contract.
     *
     * @param productsModuleAddress_ {ProductsModule} address
     * @param slicerId_ ID of the slicer linked to this contract
     */
    function initialize(address productsModuleAddress_, uint256 slicerId_) external initializer {
        _productsModuleAddress = productsModuleAddress_;
        _slicerId = slicerId_;

        // Add other variables to initialize here
    }
}
