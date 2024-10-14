// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import "forge-std/Script.sol";
import {NFTGatedCloner} from "../src/hooks/NFTGated/clones/NFTGatedCloner.sol";
import {NFTGatedFactory} from "../src/hooks/NFTGated/immutable/NFTGatedFactory.sol";

contract DeployFactory is Script {
    address deployer = vm.rememberKey(vm.envUint("DEPLOYER_KEY"));

    function run() public returns (NFTGatedCloner cloner, NFTGatedFactory factory) {
        vm.startBroadcast(deployer);

        cloner = new NFTGatedCloner();
        factory = new NFTGatedFactory();

        vm.stopBroadcast();
    }
}
