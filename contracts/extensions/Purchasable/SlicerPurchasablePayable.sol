// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.0;

import "./SlicerPurchasable.sol";
import "../../utils/sliceV1/interfaces/ISlicer.sol";
import "../../utils/sliceV1/interfaces/ISliceCore.sol";
import "../../utils/sliceV1/interfaces/IFundsModule.sol";

/**
 * @title SlicerPurchasable
 * @author jjranalli
 *
 * @notice Contract module allowing basic usage of external calls made by slicers on product purchase,
 * which also includes a function to release any accumulated ETH to a `_collector` address.
 */
abstract contract SlicerPurchasablePayable is SlicerPurchasable {
    /// ============ Storage ============

    /// SliceCore contract address
    ISliceCore private immutable _sliceCore;
    /// SliceCore contract address
    IFundsModule private immutable _fundsModule;
    /// SliceCore contract address
    address payable private immutable _collector;

    /// ============ Constructor ============

    /**
     * @notice Initializes the contract.
     *
     * @param productsModuleAddress_ {ProductsModule} address
     * @param slicerId_ ID of the slicer linked to this contract
     * @param collector_ Collector address
     */
    constructor(
        address productsModuleAddress_,
        uint256 slicerId_,
        address sliceCoreAddress_,
        address fundsModule_,
        address payable collector_
    ) SlicerPurchasable(productsModuleAddress_, slicerId_) {
        _sliceCore = ISliceCore(sliceCoreAddress_);
        _fundsModule = IFundsModule(fundsModule_);
        _collector = collector_;
    }

    /// ============ Functions ============

    /// @notice Releases the ETH balance of this contract to the specified `_collector`.
    function releaseToCollector() external {
        uint256 protocolFee = ISlicer(_sliceCore.slicers(_slicerId)).getFee();
        uint256 protocolPayment = (address(this).balance * protocolFee) / 1000;
        _fundsModule.depositEth{value: address(this).balance}(_collector, protocolPayment);
    }
}
