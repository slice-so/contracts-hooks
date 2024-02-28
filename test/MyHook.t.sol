// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import "forge-std/console2.sol";
import "./helper/Setup.sol";
import "src/templates/MyHook/MyHook.sol";
import {BasedMerch_Denver_SliceHook} from "src/onchainSummer/onchainSummer.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {AccessControl} from "@openzeppelin/contracts/access/AccessControl.sol";
import {IERC1155} from "@openzeppelin/contracts/token/ERC1155/IERC1155.sol";

contract MyHookTest is Setup {
    //*********************************************************************//
    // ----------------------------- storage ----------------------------- //
    //*********************************************************************//

    BasedMerch_Denver_SliceHook public myHook;

    bytes32 private constant MINTER_ROLE = keccak256("MINTER_ROLE");
    AccessControl public constant nft = AccessControl(0x50c68E249260053732e143d715A7F5907a213b46);

    //*********************************************************************//
    // ------------------------------ setup ------------------------------ //
    //*********************************************************************//

    function setUp() public virtual override {
        Setup.setUp();

        string memory RPC_URL_BASE = vm.envString("RPC_URL_BASE");
        vm.createSelectFork(RPC_URL_BASE, 11043964);

        myHook = new BasedMerch_Denver_SliceHook(address(1), 1);
    }

    //*********************************************************************//
    // ------------------------------ tests ------------------------------ //
    //*********************************************************************//

    function testMint() public {
        uint256 productId = 46;
        uint256 quantity = 1;

        // myHook.onProductPurchase(1, productId, address(2), quantity, "", "");

        // myHook.setToken(productId, 1, true);

        // vm.expectRevert();
        // myHook.onProductPurchase(1, productId, address(2), quantity, "", "");

        vm.prank(Ownable(address(nft)).owner());
        nft.grantRole(MINTER_ROLE, address(myHook));

        vm.prank(address(1));
        myHook.onProductPurchase(1, productId, address(2), quantity, "", "");

        assertEq(IERC1155(address(nft)).balanceOf(address(2), 19), quantity);
    }
}
