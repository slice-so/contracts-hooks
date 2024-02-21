// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import {console} from "forge-std/Test.sol";
import {Script} from "forge-std/Script.sol";
import {Base64} from "@solady/utils/Base64.sol";
import {DynamicBufferLib} from "@solady/utils/DynamicBufferLib.sol";
import {LibPRNG} from "@solady/utils/LibPRNG.sol";
import {LibString} from "@solady/utils/LibString.sol";

import {IColormapRegistry} from "../src/interfaces/IColormapRegistry.sol";

contract Print404Script is Script {
    using DynamicBufferLib for DynamicBufferLib.DynamicBuffer;
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
    bytes8 constant COLORMAP_HASH = bytes8(0x864a6ee98b9b21ac);

    /// @notice Seed for the output.
    /// @dev Replace this as needed.
    uint256 constant SEED = 0;

    // -------------------------------------------------------------------------
    // Script `run()`
    // -------------------------------------------------------------------------

    function run() public {
        // First, create the seed.
        LibPRNG.PRNG memory prng = LibPRNG.PRNG(SEED);
        prng.next();

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
        DynamicBufferLib.DynamicBuffer memory buffer;
        unchecked {
            for (uint256 i; i < 4096; ++i) {
                uint16 color = counts[i];
                assembly {
                    color := div(mul(color, 255), max)
                }
                buffer.p(
                    abi.encodePacked(
                        '<path d="M',
                        (i & 0x3f).toString(),
                        " ",
                        (i >> 6).toString(),
                        'h1v1h-1z" fill="#',
                        COLORMAP_REGISTRY.getValueAsHexString(COLORMAP_HASH, uint8(color)),
                        '"/>'
                    )
                );
            }
        }

        (uint8 r0, uint8 g0, uint8 b0) = COLORMAP_REGISTRY.getValueAsUint8(COLORMAP_HASH, 0);
        vm.writeFile(
            string.concat(
                "./output/404-",
                SEED.toString(),
                "-",
                (uint256(bytes32(COLORMAP_HASH)) >> 224).toHexStringNoPrefix(4),
                ".txt"
            ),
            string.concat(
                "data:json/application;base64,",
                Base64.encode(
                    abi.encodePacked(
                        '{"name":"FC404 #',
                        SEED.toString(),
                        '",',
                        '"image_data":"data:image/svg+xml;base64,',
                        Base64.encode(
                            abi.encodePacked(
                                '<svg xmlns="http://www.w3.org/2000/svg" width="1024" height="1024" viewBox="0 0 1152 1152" fill="none"><path d="M0 0h1152v1152H0z" fill="#',
                                COLORMAP_REGISTRY.getValueAsHexString(COLORMAP_HASH, uint8(SEED)),
                                '"/><svg xmlns="http://www.w3.org/2000/svg" width="1024" height="1024" viewBox="0 0 64 64" transform="translate(64 64)">',
                                buffer.data,
                                '<g fill="#',
                                uint256(0xff - r0).toHexStringNoPrefix(1),
                                uint256(0xff - g0).toHexStringNoPrefix(1),
                                uint256(0xff - b0).toHexStringNoPrefix(1),
                                '"><path d="M13 23h3v2h-3zm0 2h2v1h-2zm-1 1h3v2h-3zm-1 2h3v2h-3zm-1 2h3v3h-3zm-1 3h3v4H9zm3 2h9v2h-9z"/><path d="M16 30h3v11h-3zm11-7h10v2H27zm-2 2h14v1H25zm1 1h4v1h-4zm8 0h4v1h-4zm-8 1h3v1h-3zm9 0h3v1h-3zm-9 1h2v8h-2zm10 0h2v8h-2zm-10 8h3v1h-3zm9 0h3v1h-3zm-9 1h4v1h-4zm8 0h4v1h-4zm-9 1h14v1H25zm2 1h10v2H27zm20-16h3v2h-3zm0 2h2v1h-2zm-1 1h3v2h-3zm-1 2h3v2h-3zm-1 2h3v3h-3zm-1 3h3v4h-3zm3 2h9v2h-9z"/><path d="M50 30h3v11h-3z"/></g></svg></svg>'
                            )
                        ),
                        '","attributes":[{"trait_type":"Colormap","value":"',
                        (uint256(bytes32(COLORMAP_HASH)) >> 224).toHexStringNoPrefix(4),
                        '"}]}'
                    )
                )
            )
        );
    }
}
