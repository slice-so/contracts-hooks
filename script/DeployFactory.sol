// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import "forge-std/Script.sol";
import {AllowlistedCloner} from "../src/hooks/Allowlisted/clones/AllowlistedCloner.sol";
import {AllowlistedFactory} from "../src/hooks/Allowlisted/immutable/AllowlistedFactory.sol";

contract DeployFactory is Script {
    address deployer = vm.rememberKey(vm.envUint("DEPLOYER_KEY"));

    function run() public returns (AllowlistedCloner cloner, AllowlistedFactory factory) {
        vm.startBroadcast(deployer);

        cloner = new AllowlistedCloner();
        factory = new AllowlistedFactory();

        vm.stopBroadcast();
    }
}
