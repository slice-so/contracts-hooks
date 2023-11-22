// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import "forge-std/Script.sol";
import {BasedMerchOne_SliceHook} from "../src/onchainSummer/onchainSummer.sol";

contract DeployContract is Script {
    address productsModule = 0xb9d5B99d5D0fA04dD7eb2b0CD7753317C2ea1a84; // base
    address deployer = vm.rememberKey(vm.envUint("DEPLOYER_KEY"));

    function run() public returns (BasedMerchOne_SliceHook deployedContract) {
        vm.startBroadcast(deployer);

        deployedContract = new BasedMerchOne_SliceHook(productsModule, 7);

        vm.stopBroadcast();
    }
}

// prod deployment 0x193E6199c2DF28820664ddadAF7256Ffcff680a2 -- slicer 7
// test deployment 0x7F9699ACc1340791b262D89D2A2f52645F6a7Ade -- slicer 41
