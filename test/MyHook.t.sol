// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import "forge-std/console2.sol";
import "./helper/Setup.sol";
import "src/templates/MyHook/MyHook.sol";
import {SummerZorb_SliceHook} from "src/onchainSummer/onchainSummer.sol";

contract MyHookTest is Setup {
    //*********************************************************************//
    // ----------------------------- storage ----------------------------- //
    //*********************************************************************//

    SummerZorb_SliceHook public myHook;

    //*********************************************************************//
    // ------------------------------ setup ------------------------------ //
    //*********************************************************************//

    function setUp() public virtual override {
        Setup.setUp();

        string memory RPC_URL_BASE = vm.envString("RPC_URL_BASE");
        vm.createSelectFork(RPC_URL_BASE);

        myHook = new SummerZorb_SliceHook(
            address(1)
        );
    }

    //*********************************************************************//
    // ------------------------------ tests ------------------------------ //
    //*********************************************************************//

    function testDeploy() public {
        myHook.onProductPurchase{value: 0.000777 ether}(1, 1, address(2), 1, "", "");
    }
}
