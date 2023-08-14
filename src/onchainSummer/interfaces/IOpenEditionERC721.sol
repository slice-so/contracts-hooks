// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

/**
 *  @notice The criteria that make up a claim condition.
 *
 *  @param startTimestamp                 The unix timestamp after which the claim condition applies.
 *                                        The same claim condition applies until the `startTimestamp`
 *                                        of the next claim condition.
 *
 *  @param maxClaimableSupply             The maximum total number of tokens that can be claimed under
 *                                        the claim condition.
 *
 *  @param supplyClaimed                  At any given point, the number of tokens that have been claimed
 *                                        under the claim condition.
 *
 *  @param quantityLimitPerWallet         The maximum number of tokens that can be claimed by a wallet.
 *
 *  @param merkleRoot                     The allowlist of addresses that can claim tokens under the claim
 *                                        condition.
 *
 *  @param pricePerToken                  The price required to pay per token claimed.
 *
 *  @param currency                       The currency in which the `pricePerToken` must be paid.
 *
 *  @param metadata                       Claim condition metadata.
 */
struct ClaimCondition {
    uint256 startTimestamp;
    uint256 maxClaimableSupply;
    uint256 supplyClaimed;
    uint256 quantityLimitPerWallet;
    bytes32 merkleRoot;
    uint256 pricePerToken;
    address currency;
    string metadata;
}

/**
 *  @param proof Proof of concerned wallet's inclusion in an allowlist.
 *  @param quantityLimitPerWallet The total quantity of tokens the allowlisted wallet is eligible to claim over time.
 *  @param pricePerToken The price per token the allowlisted wallet must pay to claim tokens.
 *  @param currency The currency in which the allowlisted wallet must pay the price for claiming tokens.
 */
struct AllowlistProof {
    bytes32[] proof;
    uint256 quantityLimitPerWallet;
    uint256 pricePerToken;
    address currency;
}

interface IOpenEditionERC721 {
    function getActiveClaimConditionId() external view returns (uint256 conditionId);

    function getClaimConditionById(uint256 conditionId) external view returns (ClaimCondition memory condition);

    function claim(
        address _receiver,
        uint256 _quantity,
        address _currency,
        uint256 _pricePerToken,
        AllowlistProof memory _allowlistProof,
        bytes memory _data
    ) external payable;
}
