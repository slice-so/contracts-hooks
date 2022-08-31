// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../Allowlisted.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";

/**
 * Purchase hook with allowlist requirement.
 */
contract AllowlistedClone is Allowlisted, Initializable {
    /// ========== Initializer ==========

    /**
     * @notice Initializes the contract.
     *
     * @param productsModuleAddress_ {ProductsModule} address
     * @param slicerId_ ID of the slicer linked to this contract
     * @param merkleRoot_ Merkle root used to verify proof validity
     */
    function initialize(
        address productsModuleAddress_,
        uint256 slicerId_,
        bytes32 merkleRoot_
    ) external initializer {
        _productsModuleAddress = productsModuleAddress_;
        _slicerId = slicerId_;
        _merkleRoot = merkleRoot_;
    }
}
