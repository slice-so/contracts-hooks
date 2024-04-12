// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Tippable {
    /*//////////////////////////////////////////////////////////////
                                 ERRORS
    //////////////////////////////////////////////////////////////*/

    error LengthMismatch();
    /*//////////////////////////////////////////////////////////////
                                 EVENTS
    //////////////////////////////////////////////////////////////*/

    event Tip(address indexed from, address indexed to, uint256 amount);

    /*//////////////////////////////////////////////////////////////
                           IMMUTABLE STORAGE
    //////////////////////////////////////////////////////////////*/

    uint256 public immutable START_TIMESTAMP;
    uint256 public immutable CYCLE_DURATION;
    uint256 public immutable ALLOWANCE_AVERAGE_CYCLES;

    /*//////////////////////////////////////////////////////////////
                                STORAGE
    //////////////////////////////////////////////////////////////*/

    mapping(address account => mapping(uint256 cycle => uint256 tipAmount)) public tips;
    mapping(address account => mapping(uint256 cycle => uint256 tipAmount)) public tipsSent;

    /*//////////////////////////////////////////////////////////////
                              CONSTRUCTOR
    //////////////////////////////////////////////////////////////*/

    /**
     * @param cycleDuration The duration of a cycle in seconds.
     * @param allowanceAverageCycles The number of cycles to average the allowance.
     */
    constructor(uint256 cycleDuration, uint256 allowanceAverageCycles) {
        START_TIMESTAMP = block.timestamp;
        CYCLE_DURATION = cycleDuration;
        ALLOWANCE_AVERAGE_CYCLES = allowanceAverageCycles;
    }

    /*//////////////////////////////////////////////////////////////
                               FUNCTIONS
    //////////////////////////////////////////////////////////////*/

    // Tip `amount` to `to`.
    //
    // If `amount` is higher than the allowance, the allowance is used instead.
    function tip(address to, uint256 amount) public virtual {
        uint256 senderAllowance = allowance(msg.sender);
        uint256 tipAmount = amount > senderAllowance ? senderAllowance : amount;

        if (tipAmount != 0) {
            uint256 currentCycle_ = currentCycle();
            tips[to][currentCycle_] += tipAmount;
            tipsSent[msg.sender][currentCycle_] += tipAmount;

            emit Tip(msg.sender, to, tipAmount);
        }
    }

    // Batch tip `amounts` to `to`.
    function tipBatch(address[] memory to, uint256[] memory amounts) external virtual {
        uint256 length = to.length;
        if (length != amounts.length) revert LengthMismatch();

        for (uint256 i = 0; i < length;) {
            tip(to[i], amounts[i]);

            unchecked {
                ++i;
            }
        }
    }

    function allowance(address account) public view virtual returns (uint256) {
        uint256 currentCycle_ = currentCycle();
        uint256 cycle;
        uint256 accountAllowance;

        // make average of tips among last `TIP_AVERAGE_CYCLE` cycles
        for (uint256 i = 0; i < ALLOWANCE_AVERAGE_CYCLES;) {
            cycle = currentCycle_ + i;

            if (cycle < 0) break;
            accountAllowance += tips[account][cycle];

            unchecked {
                ++i;
            }
        }

        return accountAllowance / ALLOWANCE_AVERAGE_CYCLES - tipsSent[account][currentCycle_];
    }

    function currentCycle() public view virtual returns (uint256) {
        /// @dev `START_TIMESTAMP` cannot be higher than `block.timestamp`
        unchecked {
            return (block.timestamp - START_TIMESTAMP) / CYCLE_DURATION;
        }
    }
}
