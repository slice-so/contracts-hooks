// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ERC721GatedImmutable.sol";

/**
 * ERC721Gated factory contract.
 */
contract ERC721GatedFactory {
    event ContractCreated(address contractAddress);

    /**
     * @notice Deploy and initialize contract.
     */
    function deploy(
        address productsModuleAddress_,
        uint256 slicerId_,
        IERC721 erc721_
    ) external returns (address contractAddress) {
        contractAddress = address(
            new ERC721GatedImmutable(productsModuleAddress_, slicerId_, erc721_)
        );

        emit ContractCreated(contractAddress);
    }
}
