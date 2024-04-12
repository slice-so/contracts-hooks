// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

/// @title Tippable
/// @notice Enable onchain tips and claims in your contract.
///
/// @author jacopo.eth (@jacopo)

abstract contract Tippable {
    /*//////////////////////////////////////////////////////////////
                                 ERRORS
    //////////////////////////////////////////////////////////////*/

    error LengthMismatch();
    error NoTipToSelf();

    /*//////////////////////////////////////////////////////////////
                                 EVENTS
    //////////////////////////////////////////////////////////////*/

    event Tipped(address indexed from, address indexed to, uint256 amount);
    event TippedBatch(address indexed from, address[] indexed to, uint256[] amounts);
    event Claimed(address indexed account, uint256 amount);

    /*//////////////////////////////////////////////////////////////
                                STORAGE
    //////////////////////////////////////////////////////////////*/

    // The timestamp when the contract was deployed.
    uint256 public immutable START_TIMESTAMP;
    // The duration of a cycle in seconds.
    uint256 public immutable CYCLE_DURATION;

    mapping(address account => mapping(uint256 cycle => uint256 tipAmount)) public tipsReceived;
    mapping(address account => mapping(uint256 cycle => uint256 tipAmount)) public tipsMade;
    mapping(address account => uint256 cycle) public lastClaimedCycle;

    /*//////////////////////////////////////////////////////////////
                              CONSTRUCTOR
    //////////////////////////////////////////////////////////////*/

    /**
     * @param cycleDuration The duration of a cycle in seconds.
     */
    constructor(uint256 cycleDuration) {
        START_TIMESTAMP = block.timestamp;
        CYCLE_DURATION = cycleDuration;
    }

    /*//////////////////////////////////////////////////////////////
                             CONFIGURATION
    //////////////////////////////////////////////////////////////*/

    /// Hook called when a claim is made.
    function _onClaim(address account, uint256 amount) internal virtual;

    /// Returns the allowance of `account`.
    function _allowance(address account) public view virtual returns (uint256);

    /// Hook called when a tip is made.
    function _onTip(uint256 currentCycle_, address from, address to, uint256 amount) internal virtual {}

    /// Returns the total tips received by `account` in `cycle`.
    function _deriveAmountReceived(address account, uint256 cycle) internal view virtual returns (uint256) {
        return tipsReceived[account][cycle];
    }

    /*//////////////////////////////////////////////////////////////
                                  TIP
    //////////////////////////////////////////////////////////////*/

    /// Tip `amount` to `to`. If `amount` is higher than the allowance, the allowance is used instead.
    function tip(address to, uint256 amount) external virtual {
        uint256 tipAmount = _tip(currentCycle(), msg.sender, to, amount);

        if (tipAmount == 0) return;

        emit Tipped(msg.sender, to, tipAmount);
    }

    /// Batched version of `tip`.
    function tipBatch(address[] memory to, uint256[] memory amounts) external virtual {
        uint256 length = to.length;
        if (length != amounts.length) revert LengthMismatch();

        uint256 currentCycle_ = currentCycle();
        for (uint256 i = 0; i < length;) {
            _tip(currentCycle_, msg.sender, to[i], amounts[i]);

            unchecked {
                ++i;
            }
        }

        emit TippedBatch(msg.sender, to, amounts);
    }

    //
    function _tip(uint256 currentCycle_, address from, address to, uint256 amount)
        internal
        virtual
        returns (uint256 tipAmount)
    {
        if (from == to) revert NoTipToSelf();

        uint256 senderAllowance = _allowance(from);
        tipAmount = amount > senderAllowance ? senderAllowance : amount;

        if (tipAmount != 0) {
            tipsReceived[to][currentCycle_] += tipAmount;
            tipsMade[from][currentCycle_] += tipAmount;

            _onTip(currentCycle_, from, to, tipAmount);
        }
    }

    /*//////////////////////////////////////////////////////////////
                                 CLAIM
    //////////////////////////////////////////////////////////////*/

    /// Claim all the tips received since the last claim.
    function claim() external virtual {
        claim(type(uint256).max);
    }

    /// Claim up to `maxCycles` of tips received since the last claim.
    ///
    /// @dev Can be used to split claims in multiple transactions and avoid exceeding gas limits.
    function claim(uint256 maxCycles) public virtual {
        uint256 lastCycle = currentCycle() - 1;

        uint256 lastClaimedCycle_ = lastClaimedCycle[msg.sender];

        if (lastClaimedCycle_ == lastCycle) return;

        // `lastCycle` cannot be lower than `lastClaimedCycle_`
        uint256 cyclesToClaim;
        unchecked {
            cyclesToClaim = lastCycle - lastClaimedCycle_;
        }

        if (cyclesToClaim > maxCycles) cyclesToClaim = maxCycles;

        uint256 amountReceived;
        for (uint256 i = 1; i <= cyclesToClaim;) {
            amountReceived += _deriveAmountReceived(msg.sender, lastClaimedCycle_ + i);

            unchecked {
                ++i;
            }
        }

        lastClaimedCycle[msg.sender] = lastCycle;
        _onClaim(msg.sender, amountReceived);

        emit Claimed(msg.sender, amountReceived);
    }

    /*//////////////////////////////////////////////////////////////
                               FUNCTIONS
    //////////////////////////////////////////////////////////////*/

    /// Returns the current cycle.
    function currentCycle() public view virtual returns (uint256) {
        /// @dev `START_TIMESTAMP` cannot be higher than `block.timestamp`
        unchecked {
            return ((block.timestamp - START_TIMESTAMP) / CYCLE_DURATION) + 1;
        }
    }
}
