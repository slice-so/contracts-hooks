// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import "forge-std/Test.sol";
import {DSTestPlus} from "solmate/test/utils/DSTestPlus.sol";

// Provides common functionality, such as deploying contracts on test setup.
contract Setup is Test {
    //*********************************************************************//
    // --------------------- internal stored properties ------------------- //
    //*********************************************************************//
    address internal _user = address(69);

    //*********************************************************************//
    // --------------------------- test setup ---------------------------- //
    //*********************************************************************//

    // Deploys and initializes contracts for testing.
    function setUp() public virtual {
        // ---- general setup ----
        vm.deal(_user, 100 ether);

        vm.label(_user, "user");
    }
}
