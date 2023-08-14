// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../ERC20Gated.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";

/**
 * ERC20Gated clone purchase hook.
 */
contract ERC20GatedClone is ERC20Gated, Initializable {
    /// ========== Initializer ==========

    /**
     * @notice Initializes the contract.
     *
     * @param productsModuleAddress_ {ProductsModule} address
     * @param slicerId_ ID of the slicer linked to this contract
     * @param erc20_ Address of the ERC20 contract used for gating
     * @param gateAmount_ Amount of ERC20 tokens used for gating
     */
    function initialize(
        address productsModuleAddress_,
        uint256 slicerId_,
        IERC20 erc20_,
        uint256 gateAmount_
    ) external initializer {
        _productsModuleAddress = productsModuleAddress_;
        _slicerId = slicerId_;
        gate = ERC20Gate(erc20_, gateAmount_);
    }

    constructor() {
        _disableInitializers();
    }
}
