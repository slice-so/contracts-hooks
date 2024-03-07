// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "../../extensions/Purchasable/SlicerPurchasable.sol";
import "../interfaces/ITokenERC1155.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title Hook to mint Onchain Cookies NFTs
 * @author jacopo.eth
 */
contract OnchainCookies_Denver_SliceHook is SlicerPurchasable, Ownable {
    address internal constant RELAYER = 0x320DE7bBE088167617Aa7C8b6a3aA7C2a287EC71;
    ITokenERC1155 public constant MINT_NFT_COLLECTION = ITokenERC1155(0x7A110890DF5D95CefdB0151143E595b755B7c9b7);
    uint256 public constant MINT_NFT_COLLECTION_TOKENID = 0;

    bool mintOnlyCbw = true;
    mapping(uint256 slicerId => bool allowed) public allowedSlicers;

    /*//////////////////////////////////////////////////////////////
                              CONSTRUCTOR
    //////////////////////////////////////////////////////////////*/

    constructor(address productsModuleAddress_, uint256 slicerId_) {
        _productsModuleAddress = productsModuleAddress_;
        _slicerId = slicerId_;
    }

    /*//////////////////////////////////////////////////////////////
                               FUNCTIONS
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Mint `quantity` NFTs to `account` on purchase, if the purchase is made by the relayer.
     */
    function onProductPurchase(uint256 slicerId, uint256, address buyer, uint256 quantity, bytes memory, bytes memory)
        public
        payable
        override
    {
        if (msg.sender != _productsModuleAddress) revert NotPurchase();

        if (allowedSlicers[slicerId]) {
            if (mintOnlyCbw) {
                if (tx.origin == RELAYER) {
                    MINT_NFT_COLLECTION.mintTo(buyer, MINT_NFT_COLLECTION_TOKENID, "", quantity);
                }
            } else {
                MINT_NFT_COLLECTION.mintTo(buyer, MINT_NFT_COLLECTION_TOKENID, "", quantity);
            }
        }
    }

    function setAllowedSlicer(uint256 slicerId, bool allowed) external onlyOwner {
        allowedSlicers[slicerId] = allowed;
    }

    function setFlags(bool mintOnlyCbw_) external onlyOwner {
        mintOnlyCbw = mintOnlyCbw_;
    }
}
