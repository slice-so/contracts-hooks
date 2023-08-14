// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import "forge-std/Script.sol";
import {BaseDayOne_SliceHook} from "../src/onchainSummer/onchainSummer.sol";

contract DeployContract is Script {
    address deployer = vm.rememberKey(vm.envUint("DEPLOYER_KEY"));
    address productsModule = 0xb9d5B99d5D0fA04dD7eb2b0CD7753317C2ea1a84; // base

    function run() public returns (BaseDayOne_SliceHook deployedContract) {
        vm.startBroadcast(deployer);

        deployedContract = new BaseDayOne_SliceHook(productsModule);

        vm.stopBroadcast();
    }
}
