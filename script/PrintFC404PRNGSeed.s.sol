// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {DynamicBufferLib} from "@solady/utils/DynamicBufferLib.sol";
import {LibPRNG} from "@solady/utils/LibPRNG.sol";
import {LibString} from "@solady/utils/LibString.sol";

import {FC404Metadata} from "src/deframe/utils/FC404Metadata.sol";

contract PrintFC404PRNGSeedScript is Script {
    using DynamicBufferLib for DynamicBufferLib.DynamicBuffer;
    using LibPRNG for LibPRNG.PRNG;
    using LibString for uint256;

    // -------------------------------------------------------------------------
    // Constants
    // -------------------------------------------------------------------------

    /// @notice ID of the token to write PRNG seed values for.
    /// @dev Replace this as needed.
    uint256 constant TOKEN_ID = 0;

    // -------------------------------------------------------------------------
    // Script `run()`
    // -------------------------------------------------------------------------

    function run() public {
        DynamicBufferLib.DynamicBuffer memory buffer;
        LibPRNG.PRNG memory prng = LibPRNG.PRNG(TOKEN_ID);
        prng.next();

        uint256 iterations = 0x100 | (prng.state & 0xff);
        for (uint256 i; i < iterations - 1;) {
            buffer.p(abi.encodePacked(prng.state.toHexString(), "-"));
            prng.next();
            unchecked {
                ++i;
            }
        }
        buffer.p(abi.encodePacked(prng.state.toHexString()));

        vm.writeFile(string.concat("./output/prngs/", TOKEN_ID.toString(), ".txt"), string(buffer.data));
    }
}
