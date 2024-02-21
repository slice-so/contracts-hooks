// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import {console} from "forge-std/Test.sol";
import {Script} from "forge-std/Script.sol";
import {LibPRNG} from "@solady/utils/LibPRNG.sol";
import {LibString} from "@solady/utils/LibString.sol";

import {IColormapRegistry} from "../src/interfaces/IColormapRegistry.sol";

contract Print404Script is Script {
    using LibPRNG for LibPRNG.PRNG;
    using LibString for uint256;

    // -------------------------------------------------------------------------
    // Deploy addresses
    // -------------------------------------------------------------------------

    /// @notice Address of the colormap registry.
    /// @dev Replace this as needed.
    IColormapRegistry constant COLORMAP_REGISTRY = IColormapRegistry(0x00000000A84FcdF3E9C165e6955945E87dA2cB0D);

    /// @notice Hash of the colormap to print.
    /// @dev Replace this as needed.
    bytes8 constant COLORMAP_HASH = bytes8(0xfd29b65966772202);

    /// @notice Seed for the output.
    /// @dev Replace this as needed.
    uint256 constant SEED = 0;

    // -------------------------------------------------------------------------
    // Script `run()`
    // -------------------------------------------------------------------------

    function run() public {
        // First, create the seed.
        LibPRNG.PRNG memory prng = LibPRNG.PRNG(uint256(keccak256(abi.encodePacked(SEED))));

        // We do 512 iterations of the Drunken Bishop algorithm.
        uint256 index;
        uint16[] memory counts = new uint16[](4096);
        counts[0] = 1;
        uint256 max = 1;
        for (uint256 i; i < 512;) {
            for (uint256 seed = prng.state; seed != 0; seed >>= 2) {
                (uint256 x, uint256 y) = (index & 0x3f, index >> 6);

                assembly {
                    function get_in_bounds(_index) -> res {
                        let _x := and(_index, 0x3f)
                        // We don't need to mask with `0x3f` because we control
                        // the input.
                        let _y := shr(6, _index)
                        res :=
                            and(
                                and(shr(_y, 0x3ffffc00000), 1),
                                or(
                                    or(
                                        and(
                                            and(shr(_x, 0x3ffc00000fff00), 1),
                                            and(
                                                shr(
                                                    add(mul(12, sub(_y, 22)), sub(_x, add(8, mul(34, gt(_x, 21))))),
                                                    0xf80f80f80f80fffffffffffffbffbffbeffeffe0fc0fc0f81f81f01f01f0
                                                ),
                                                1
                                            )
                                        ),
                                        and(and(shr(_y, 0x3c00000000), shr(_x, 0xc0000000300000)), 1)
                                    ),
                                    and(
                                        and(shr(_x, 0xffff000000), 1),
                                        and(
                                            shr(
                                                add(shl(3, sub(_y, 22)), xor(and(_x, 7), mul(7, gt(_x, 31)))),
                                                0xfcfcfffffffefefefefefefefefefefffffffcfc
                                            ),
                                            1
                                        )
                                    )
                                )
                            )
                    }

                    // Read down/up
                    switch and(shr(1, seed), 1)
                    // Down case
                    case 0 { index := add(index, shl(6, iszero(or(eq(y, 63), get_in_bounds(add(index, 64)))))) }
                    // Up case
                    default { index := sub(index, shl(6, iszero(or(eq(y, 0), get_in_bounds(sub(index, 64)))))) }

                    // Read left/right
                    switch and(seed, 1)
                    // Left case
                    case 0 { index := sub(index, iszero(or(eq(x, 0), get_in_bounds(sub(index, 1))))) }
                    // Right case
                    default { index := add(index, iszero(or(eq(x, 63), get_in_bounds(add(index, 1))))) }
                }

                unchecked {
                    if (++counts[index] > max) max = counts[index];
                }
            }

            // Generate the next pseudorandom number.
            prng.state = prng.next();
            unchecked {
                ++i;
            }
        }

        // SVG generation.
        string memory svg = "";
        unchecked {
            for (uint256 i; i < 4096; ++i) {
                uint16 color = counts[i];
                assembly {
                    color := div(mul(color, 255), max)
                }
                svg = string.concat(
                    svg,
                    '<path d="M',
                    (i & 0x3f).toString(),
                    " ",
                    (i >> 6).toString(),
                    'h1v1h-1z" fill="#',
                    COLORMAP_REGISTRY.getValueAsHexString(COLORMAP_HASH, uint8(color)),
                    '"/>'
                );
            }
        }
        vm.writeFile(
            "./output/404.svg",
            string.concat(
                '<svg xmlns="http://www.w3.org/2000/svg" width="400" height="400" viewBox="0 0 64 64" fill="none">',
                svg,
                "</svg>"
            )
        );
    }
}
