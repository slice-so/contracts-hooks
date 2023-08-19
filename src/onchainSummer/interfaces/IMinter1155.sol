// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

struct SalesConfig {
    /// @notice Unix timestamp for the sale start
    uint64 saleStart;
    /// @notice Unix timestamp for the sale end
    uint64 saleEnd;
    /// @notice Max tokens that can be minted for an address, 0 if unlimited
    uint64 maxTokensPerAddress;
    /// @notice Price per token in eth wei
    uint96 pricePerToken;
    /// @notice Funds recipient (0 if no different funds recipient than the contract global)
    address fundsRecipient;
}

interface IMinter1155 {
    function sale(address tokenContract, uint256 tokenId) external view returns (SalesConfig memory);
}
