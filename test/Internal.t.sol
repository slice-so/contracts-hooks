// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import "forge-std/console2.sol";
import "./helper/Setup.sol";
import "src/templates/MyHook/MyHook.sol";
import {BasedMerch_Denver_SliceHook} from "src/onchainSummer/onchainSummer.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import "../src/onchainSummer/interfaces/IProductsModule.sol";
import {AccessControl} from "@openzeppelin/contracts/access/AccessControl.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract MyHookTest is Setup {
    //*********************************************************************//
    // ----------------------------- storage ----------------------------- //
    //*********************************************************************//

    IProductsModule public constant productsModule = IProductsModule(0xb9d5B99d5D0fA04dD7eb2b0CD7753317C2ea1a84);
    address constant buyer = 0xAe009d532328FF09e09E5d506aB5BBeC3c25c0FF;

    //*********************************************************************//
    // ------------------------------ setup ------------------------------ //
    //*********************************************************************//

    function setUp() public virtual override {
        Setup.setUp();

        string memory RPC_URL_BASE = vm.envString("RPC_URL_BASE");
        vm.createSelectFork(RPC_URL_BASE, 19036692);
    }

    //*********************************************************************//
    // ------------------------------ tests ------------------------------ //
    //*********************************************************************//

    function testPurchase() public {
        PurchaseParams[] memory purchases = new PurchaseParams[](1);
        purchases[0] = PurchaseParams(buyer, 1430, 1, 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913, 1, "");

        vm.startPrank(buyer);

        Price memory price =
            productsModule.productPrice(1430, 1, 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913, 1, buyer, "");
        console2.log(price.eth);
        console2.log(price.ethExternalCall);
        console2.log(price.currency);
        console2.log(price.currencyExternalCall);
        price = productsModule.productPrice(1430, 2, 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913, 1, buyer, "");
        console2.log(price.eth);
        console2.log(price.ethExternalCall);
        console2.log(price.currency);
        console2.log(price.currencyExternalCall);

        productsModule.payProducts(purchases);

        vm.stopPrank();
    }
}
