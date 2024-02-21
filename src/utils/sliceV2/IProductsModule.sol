// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

struct PurchaseParams {
    address buyer;
    uint128 slicerId;
    uint32 quantity;
    address currency;
    uint32 productId;
    bytes buyerCustomData;
}

struct ReducedPurchaseParams {
    address buyer;
    uint32 quantity;
    uint32 productId;
    bytes buyerCustomData;
}

interface IProductsModule {
    function validatePurchaseUnits(address account, uint256 slicerId, uint256 productId)
        external
        view
        returns (uint256 purchases);

    function payProducts(PurchaseParams[] calldata purchases) external payable;

    function payDeframeProducts(ReducedPurchaseParams[] calldata purchases) external payable;
}
