// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import "forge-std/Script.sol";
import {SLC} from "../src/utils/SLC.sol";

contract DeploySlc is Script {
    address deployer = vm.rememberKey(vm.envUint("DEPLOYER_KEY"));

    address productsModule = 0xb9d5B99d5D0fA04dD7eb2b0CD7753317C2ea1a84; // base
    address fundsModule = 0x61bCd1ED11fC03C958A847A6687b1875f5eAcaaf; // base

    function run() public returns (SLC slc) {
        vm.startBroadcast(deployer);

        slc = new SLC(productsModule, fundsModule);

        vm.stopBroadcast();
    }
}
