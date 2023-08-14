// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ERC20GatedImmutable.sol";

/**
 * ERC20Gated factory contract.
 */
contract ERC20GatedFactory {
    event ContractCreated(address contractAddress);

    /**
     * @notice Deploy and initialize contract.
     */
    function deploy(
        address productsModuleAddress_,
        uint256 slicerId_,
        IERC20 erc20_,
        uint256 gateAmount_
    ) external returns (address contractAddress) {
        contractAddress = address(
            new ERC20GatedImmutable(productsModuleAddress_, slicerId_, erc20_, gateAmount_)
        );

        emit ContractCreated(contractAddress);
    }
}
