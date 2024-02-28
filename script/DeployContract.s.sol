// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import "forge-std/Script.sol";
import {BasedMerch_Denver_SliceHook} from "../src/onchainSummer/onchainSummer.sol";

contract DeployContract is Script {
    address productsModule = 0xb9d5B99d5D0fA04dD7eb2b0CD7753317C2ea1a84; // base
    uint256 slicerId = 7; // Based Merch
    // uint256 slicerId = 42; // Base CAFE

    address deployer = vm.rememberKey(vm.envUint("DEPLOYER_KEY"));

    function run() public returns (BasedMerch_Denver_SliceHook deployedContract) {
        vm.startBroadcast(deployer);

        deployedContract = new BasedMerch_Denver_SliceHook(productsModule, slicerId);

        vm.stopBroadcast();
    }
}

// prod deployment 0x193E6199c2DF28820664ddadAF7256Ffcff680a2 -- slicer 7
// test deployment 0x7F9699ACc1340791b262D89D2A2f52645F6a7Ade -- slicer 41

// prod basecafe 0x797626AB2f236679A3727d885005aE48Ab1dEe6D

// artbasel_IRL_hook 0xA7a0f28063c3F00E85DfC37b5639d798b6328b5d
// artbasel_IRL_price 0x12dE69800702789DE166b6bc86e081b1A1cc52F1

// artbasel_delivery_hook 0xc2AEc2ab9C78146A78b6fCeA51F32C059E5cde7D
// artbasel_delivery_price 0xD0422b17f887BC40996F386167E6aDfd1C1Ea4D8
