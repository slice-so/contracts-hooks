// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import "forge-std/Script.sol";
import {IProductsModule, Function, CurrencyPrice} from "../src/utils/sliceV1/interfaces/IProductsModule.sol";

contract SetProductExternalPricing is Script {
    IProductsModule productsModule = IProductsModule(0xb9d5B99d5D0fA04dD7eb2b0CD7753317C2ea1a84); // base
    uint256 slicerId = 606;
    address pricingStrategy = 0xb1d22157A3261Ee826B34497fF13018e4f8CED10;

    address deployer = vm.rememberKey(vm.envUint("DEPLOYER_KEY"));

    function run() public {
        vm.startBroadcast(deployer);

        CurrencyPrice[] memory currencyPrices = new CurrencyPrice[](1);
        currencyPrices[0] = CurrencyPrice({
            value: 0,
            dynamicPricing: false,
            externalAddress: pricingStrategy,
            currency: 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913
        });

        // for (uint256 i = 24; i < 46; i++) {
        //     productsModule.setProductInfo(slicerId, i, 0, false, true, 0, currencyPrices);
        // }

        vm.stopBroadcast();
    }
}
