// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import "forge-std/Script.sol";
import {IProductsModule, Function} from "../src/utils/sliceV1/interfaces/IProductsModule.sol";

contract SetProductExternalCall is Script {
    IProductsModule productsModule = IProductsModule(0xb9d5B99d5D0fA04dD7eb2b0CD7753317C2ea1a84); // base
    uint256 slicerId = 241;
    uint256 productId = 4;
    Function funct = Function("", 0, 0x5c0193D40885769a8c29d3E42656B51794181A34, 0x95db9368, 0xa23fffb9);

    address deployer = vm.rememberKey(vm.envUint("DEPLOYER_KEY"));

    function run() public returns (bool isOwner) {
        vm.startBroadcast(deployer);

        productsModule.setProductExternalCall(slicerId, productId, funct);

        vm.stopBroadcast();
    }
}
