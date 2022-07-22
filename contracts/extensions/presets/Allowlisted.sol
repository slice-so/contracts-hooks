// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.0;

import "../SlicerPurchasable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";

/**
 * @title SlicerPurchasable
 * @author jjranalli
 *
 * Simple allowlist extension for slice products, based on merkle proof verification.
 */
abstract contract Allowlisted is SlicerPurchasable, Ownable {
    /// ============ Storage ============

    // Mapping from product Ids to Drop
    mapping(uint256 => bytes32) _merkleRoots;

    /// ============ Functions ============

    /**
     * @notice Overridable function containing the requirements for an account to be eligible for the purchase.
     *
     * @dev Used on the Slice interface to check whether a user is able to buy a product. See {ISlicerPurchasable}.
     */
    function isPurchaseAllowed(
        uint256,
        uint256 productId,
        address account,
        uint256,
        bytes memory,
        bytes memory buyerCustomData
    ) public view virtual override returns (bool isAllowed) {
        // Get Merkle proof from buyerCustomData
        bytes32[] memory proof = abi.decode(buyerCustomData, (bytes32[]));

        // Generate leaf from account address
        bytes32 leaf = keccak256(abi.encodePacked(account));

        // Check if Merkle proof is valid
        isAllowed = MerkleProof.verify(proof, _merkleRoots[productId], leaf);
    }

    /**
     * Sets merkleRoot for productId
     *
     * @dev Only accessible to contract owner
     */
    function _setMerkleRoot(uint256 productId, bytes32 merkleRoot) external onlyOwner {
        _merkleRoots[productId] = merkleRoot;
    }
}
