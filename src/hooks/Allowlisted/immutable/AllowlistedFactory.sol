// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./AllowlistedImmutable.sol";

/**
 * Factory contract for Allowlisted.
 */
contract AllowlistedFactory {
    event ContractCreated(address contractAddress);

    /**
     * @notice Deploy and initialize contract.
     */
    function deploy(
        address productsModuleAddress_,
        uint256 slicerId_,
        bytes32 merkleRoot_
    ) external returns (address contractAddress) {
        contractAddress = address(
            new AllowlistedImmutable(productsModuleAddress_, slicerId_, merkleRoot_)
        );

        emit ContractCreated(contractAddress);
    }
}
