// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

interface ITokenERC1155 {
    /**
     *  @notice Lets an account with MINTER_ROLE mint an NFT.
     *
     *  @param to The address to mint the NFT to.
     *  @param tokenId The tokenId of the NFTs to mint
     *  @param uri The URI to assign to the NFT.
     *  @param amount The number of copies of the NFT to mint.
     *
     */
    function mintTo(address to, uint256 tokenId, string calldata uri, uint256 amount) external;

    function setTokenURI(uint256 tokenId, string calldata uri) external;
}
