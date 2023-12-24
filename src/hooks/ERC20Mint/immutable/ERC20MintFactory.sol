// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ERC20MintImmutable.sol";

/**
 * ERC20Mint factory contract.
 */
contract ERC20MintFactory {
    event ContractCreated(address contractAddress);

    /**
     * @notice Deploy and initialize contract.
     */
    function deploy(
        address productsModuleAddress_,
        uint256 slicerId_,
        string memory name_,
        string memory symbol_,
        uint256 premintAmount,
        uint256 allowedProductId_
    ) external returns (address contractAddress) {
        contractAddress = address(
            new ERC20MintImmutable(productsModuleAddress_, slicerId_, name_, symbol_, premintAmount, allowedProductId_)
        );

        emit ContractCreated(contractAddress);
    }
}
