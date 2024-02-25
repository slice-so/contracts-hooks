// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import "forge-std/console2.sol";
import "forge-std/Test.sol";
import "src/templates/MyHook/MyHook.sol";
import {FC404} from "src/deframe/FC404.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {AccessControl} from "@openzeppelin/contracts/access/AccessControl.sol";
import {IERC1155} from "@openzeppelin/contracts/token/ERC1155/IERC1155.sol";
import {IERC721} from "@openzeppelin/contracts/token/ERC721/IERC721.sol";

contract FC404Test is Test {
    //*********************************************************************//
    // ----------------------------- storage ----------------------------- //
    //*********************************************************************//

    uint256 internal constant PREMINT_AMOUNT = 25e25; // 250 NFTs
    uint96 public constant initialAmount = 1e25;
    uint256 _unit = 1e24;
    FC404 public fc404;
    address user = makeAddr("user");

    //*********************************************************************//
    // ------------------------------ setup ------------------------------ //
    //*********************************************************************//

    function setUp() public virtual {
        string memory RPC_URL_BASE = vm.envString("RPC_URL_BASE");
        vm.createSelectFork(RPC_URL_BASE, 11043964);

        fc404 = new FC404(address(1), 1, "FC404", "FC404", initialAmount, user);
    }

    //*********************************************************************//
    // ------------------------------ tests ------------------------------ //
    //*********************************************************************//

    function testInitialize() public {
        assertEq(fc404.balanceOf(user), initialAmount);
        assertEq(IERC721(fc404.mirrorERC721()).balanceOf(user), initialAmount / _unit);

        vm.startPrank(user);
        fc404.transfer(address(2), _unit / 2);
        fc404.transfer(address(3), _unit / 2);
        vm.stopPrank();

        assertEq(fc404.balanceOf(user), initialAmount - _unit);
        assertEq(IERC721(fc404.mirrorERC721()).balanceOf(user), (initialAmount / _unit) - 1);
        assertEq(fc404.balanceOf(address(2)), _unit / 2);
        assertEq(IERC721(fc404.mirrorERC721()).balanceOf(address(2)), 0);
        assertEq(fc404.balanceOf(address(3)), _unit / 2);
        assertEq(IERC721(fc404.mirrorERC721()).balanceOf(address(3)), 0);

        fc404.tokenURI(1);
    }
}
