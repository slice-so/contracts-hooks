// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

interface ISlicerManager {
    function implementation() external view returns (address);

    function _createSlicer(
        address creator,
        bool isImmutable,
        bool isControlled,
        uint256 id,
        uint256 minimumShares,
        uint256 releaseTimelock,
        address[] calldata currencies
    ) external returns (address);

    function _upgradeSlicers(address newLogicImpl) external;
}
