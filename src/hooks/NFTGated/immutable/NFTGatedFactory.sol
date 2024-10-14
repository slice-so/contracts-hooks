// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./NFTGatedImmutable.sol";

/**
 * NFTGated factory contract.
 */
contract NFTGatedFactory {
    event ContractCreated(address contractAddress);

    /**
     * @notice Deploy and initialize contract.
     */
    function deploy(address productsModuleAddress_, uint256 slicerId_, NFTData[] memory nftData_, uint256 minQuantity_)
        external
        returns (address contractAddress)
    {
        contractAddress = address(new NFTGatedImmutable(productsModuleAddress_, slicerId_, nftData_, minQuantity_));

        emit ContractCreated(contractAddress);
    }
}
