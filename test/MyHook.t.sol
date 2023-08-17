// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import "forge-std/console2.sol";
import "./helper/Setup.sol";
import "src/templates/MyHook/MyHook.sol";
import {SummerKevin_SliceHook} from "src/onchainSummer/onchainSummer.sol";

contract MyHookTest is Setup {
    //*********************************************************************//
    // ----------------------------- storage ----------------------------- //
    //*********************************************************************//

    SummerKevin_SliceHook public myHook;

    //*********************************************************************//
    // ------------------------------ setup ------------------------------ //
    //*********************************************************************//

    function setUp() public virtual override {
        Setup.setUp();

        string memory RPC_URL_BASE = vm.envString("RPC_URL_BASE");
        vm.createSelectFork(RPC_URL_BASE);

        myHook = new SummerKevin_SliceHook(
            address(1)
        );
    }

    //*********************************************************************//
    // ------------------------------ tests ------------------------------ //
    //*********************************************************************//

    function testDeploy() public {
        uint256 price = 0.001 ether;

        myHook.onProductPurchase{value: price}(1, 1, address(2), 1, "", "");
    }
}
