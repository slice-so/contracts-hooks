// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import "forge-std/Script.sol";
import {BaseCafe_SliceHook_2} from "../src/onchainSummer/onchainSummer.sol";

contract DeployContract is Script {
    address productsModule = 0xb9d5B99d5D0fA04dD7eb2b0CD7753317C2ea1a84; // base
    // uint256 slicerId = 606; // The Howard Coffee
    // uint256 slicerId = 777; // Based Merch
    // uint256 slicerId = 425; // Based Merch
    uint256 slicerId = 805; // Base CAFE
    // uint256 slicerId = 42; // Base CAFE
    // uint256 slicerId = 314; // Onchain Cookies
    // uint256 slicerId = 1316; // Casino

    address deployer = vm.rememberKey(vm.envUint("DEPLOYER_KEY"));

    function run() public returns (BaseCafe_SliceHook_2 deployedContract) {
        vm.startBroadcast(deployer);

        deployedContract = new BaseCafe_SliceHook_2(productsModule, slicerId);

        vm.stopBroadcast();
    }
}
