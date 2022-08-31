// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./MyHookImmutable.sol";

/**
 * MyHook factory contract.
 */
contract MyHookFactory {
    event ContractCreated(address contractAddress);

    /**
     * @notice Deploy and initialize contract.
     */
    function deploy(address productsModuleAddress_, uint256 slicerId_)
        external
        returns (address contractAddress)
    {
        contractAddress = address(new MyHookImmutable(productsModuleAddress_, slicerId_));

        emit ContractCreated(contractAddress);
    }
}
