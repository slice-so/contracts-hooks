// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../../extensions/Purchasable/SlicerPurchasableClone.sol";
import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";

/**
 * Purchase hook with allowlist requirement.
 */
contract Allowlisted is SlicerPurchasableClone {
    /// ============= Storage =============

    bytes32 private merkleRoot;

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
        __SlicerPurchasableClone_init(productsModuleAddress_, slicerId_);
        merkleRoot = merkleRoot_;
    }

    /// ============ Functions ============

    /**
     * @notice Checks if `account` is allowlisted via Merkle proof verification.
     *
     * @dev Overridable function containing the requirements for an account to be eligible for the purchase.
     * @dev Used on the Slice interface to check whether a user is able to buy a product. See {ISlicerPurchasable}.
     * @dev Max quantity purchasable per address and total mint amount is handled on Slicer product logic
     */
    function isPurchaseAllowed(
        uint256,
        uint256,
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
        isAllowed = MerkleProof.verify(proof, merkleRoot, leaf);
    }

    /**
     * @notice Overridable function to handle external calls on product purchases from slicers. See {ISlicerPurchasable}
     */
    function onProductPurchase(
        uint256 slicerId,
        uint256 productId,
        address account,
        uint256 quantity,
        bytes memory slicerCustomData,
        bytes memory buyerCustomData
    ) public payable override onlyOnPurchaseFrom(slicerId) {
        // Check whether the account is allowed to buy a product.
        if (
            !isPurchaseAllowed(
                slicerId,
                productId,
                account,
                quantity,
                slicerCustomData,
                buyerCustomData
            )
        ) revert NotAllowed();
    }
}
