// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import "forge-std/Script.sol";
import {SLC} from "../src/utils/SLC.sol";

contract DeployContract is Script {
    address deployer = vm.rememberKey(vm.envUint("DEPLOYER_KEY"));

    address productsModule = 0x61bCd1ED11fC03C958A847A6687b1875f5eAcaaf; // base
    address fundsModule = 0x115978100953D0Aa6f2f8865d11Dc5888f728370; // base

    function run() public returns (SLC slc) {
        vm.startBroadcast(deployer);

        slc = new SLC(productsModule, fundsModule);
        vm.stopBroadcast();
    }
}

// TODO
