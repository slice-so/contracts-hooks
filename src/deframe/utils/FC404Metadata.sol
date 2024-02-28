// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Base64} from "@solady/utils/Base64.sol";
import {DynamicBufferLib} from "@solady/utils/DynamicBufferLib.sol";
import {LibPRNG} from "@solady/utils/LibPRNG.sol";
import {LibString} from "@solady/utils/LibString.sol";

import "./ColormapDataConstants.sol";
import {IColormapRegistry} from "../../interfaces/IColormapRegistry.sol";

/// @title FC404 metadata
/// @notice A library for generating JSON metadata (w/ SVG `image_data`) for
/// {FC404}.
/// @dev This library assumes {ColormapRegistry} is deployed at the address
/// `COLORMAP_REGISTRY` and has the corresponding colormaps deployed and
/// [registered](https://github.com/fiveoutofnine/colormap-registry/blob/62eb940a1626f0293830a740fad374b8af7ecc9d/REGISTERED_COLORMAPS.md).
/// Refer to the [GitHub repo](https://github.com/fiveoutofnine/colormap-registry#deployments)
/// on instructions on how to deploy {ColormapRegistry} and add all colormaps
/// used by this library to the same contract address and keys.
/// @author fiveoutofnine
library FC404Metadata {
    using DynamicBufferLib for DynamicBufferLib.DynamicBuffer;
    using LibPRNG for LibPRNG.PRNG;
    using LibString for uint256;

    // -------------------------------------------------------------------------
    // Constants
    // -------------------------------------------------------------------------

    /// @notice Address of the colormap registry.
    /// @dev Replace this as needed.
    IColormapRegistry constant COLORMAP_REGISTRY = IColormapRegistry(0x00000000A84FcdF3E9C165e6955945E87dA2cB0D);

    /// @notice Description for each token (returned by `tokenURI`) in bytes.
    bytes constant DESCRIPTION = "The Farcaster-native DN404 token.";

    /// @notice Starting string for the SVG in bytes.
    bytes constant SVG_START = '<svg xmlns="http://www.w3.org/2000/svg" width="'
        '1024" height="1024" viewBox="0 0 1152 1152" fill="none"><path d="M0 0h'
        '1152v1152H0z" fill="#';

    /// @notice Ending string for the SVG in bytes.
    bytes constant SVG_END = '"><path d="M13 23h3v2h-3zm0 2h2v1h-2zm-1 1h3v2h-3'
        'zm-1 2h3v2h-3zm-1 2h3v3h-3zm-1 3h3v4H9zm3 2h9v2h-9z"/><path d="M16 30h'
        "3v11h-3zm11-7h10v2H27zm-2 2h14v1H25zm1 1h4v1h-4zm8 0h4v1h-4zm-8 1h3v1h"
        "-3zm9 0h3v1h-3zm-9 1h2v8h-2zm10 0h2v8h-2zm-10 8h3v1h-3zm9 0h3v1h-3zm-9"
        " 1h4v1h-4zm8 0h4v1h-4zm-9 1h14v1H25zm2 1h10v2H27zm20-16h3v2h-3zm0 2h2v"
        '1h-2zm-1 1h3v2h-3zm-1 2h3v2h-3zm-1 2h3v3h-3zm-1 3h3v4h-3zm3 2h9v2h-9z"'
        '/><path d="M50 30h3v11h-3z"/></g></svg></svg>';

    // -------------------------------------------------------------------------
    // `render`
    // -------------------------------------------------------------------------

    /// @notice Renders a FC404 SVG.
    /// @param _id The ID of the token.
    /// @return JSON output representing the FC404 token.
    function render(uint256 _id) internal view returns (string memory) {
        // Create the seed.
        LibPRNG.PRNG memory prng = LibPRNG.PRNG(_id);
        prng.next();

        // Select random traits using `prng.state`. We don't need to call
        // `prng.next()` again because the seed is used for distinct parts of
        // the output generation.
        uint256 iterations = 0x100 | (prng.state & 0xff); // Random number in `[256, 511]`.
        (bytes8 colormapHash, string memory colormapName) = _getColormap((prng.state >> 8) % 20);

        // Generate the heatmap for the SVG. First, we do `iterations`
        // iterations of the Drunken Bishop algorithm.
        uint256 index;
        uint16[] memory counts = new uint16[](4096);
        counts[0] = 1;
        uint256 max = 1;
        for (uint256 i; i < iterations;) {
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

                // Update max.
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

        // Generate SVG.
        DynamicBufferLib.DynamicBuffer memory buffer;
        unchecked {
            for (uint256 i; i < 4096; ++i) {
                uint16 color = counts[i];
                assembly {
                    color := div(mul(color, 255), max)
                }
                // Draw 1×1 pixel square.
                buffer.p(
                    abi.encodePacked(
                        '<path d="M',
                        (i & 0x3f).toString(),
                        " ",
                        (i >> 6).toString(),
                        'h1v1h-1z" fill="#',
                        COLORMAP_REGISTRY.getValueAsHexString(colormapHash, uint8(color)),
                        '"/>'
                    )
                );
            }
        }

        // Construct SVG.
        (uint8 r0, uint8 g0, uint8 b0) = COLORMAP_REGISTRY.getValueAsUint8(colormapHash, 0);
        bytes memory svgData;
        {
            svgData = abi.encodePacked(
                SVG_START,
                // Select background of the NFT (i.e. the border around the
                // "frame") to be a color of randomly of intensity `_id & 0xff`.
                COLORMAP_REGISTRY.getValueAsHexString(colormapHash, uint8(_id)),
                '"/><svg xmlns="http://www.w3.org/2000/svg" width="1024" height'
                '="1024" viewBox="0 0 64 64" x="64" y="64">',
                buffer.data,
                '<g fill="#',
                // Comptue the complement color.
                uint256(0xff - r0).toHexStringNoPrefix(1),
                uint256(0xff - g0).toHexStringNoPrefix(1),
                uint256(0xff - b0).toHexStringNoPrefix(1),
                SVG_END
            );
        }

        // Construct JSON.
        bytes memory jsonData;
        {
            jsonData = abi.encodePacked(
                '{"name":"FC404 #',
                _id.toString(),
                '","description":"',
                DESCRIPTION,
                '","image_data":"data:image/svg+xml;base64,',
                Base64.encode(svgData),
                '","attributes":[{"trait_type":"Theme","value":"',
                colormapName,
                '"},{"trait_type":"Iterations","value":',
                iterations.toString(),
                ',"display_type":"number"}]}'
            );
        }

        return string.concat("data:json/application;base64,", Base64.encode(jsonData));
    }

    /// @notice A helper function to return the colormap hash and name
    /// corresponding to some randomly selected `_index`.
    /// @param _index The index of the colormap.
    /// @return bytes8 The hash (identifier) of the colormap.
    /// @return string memory The name of the colormap.
    function _getColormap(uint256 _index) internal pure returns (bytes8, string memory) {
        // Binary search.
        if (_index < 10) {
            // `[0, 9]`
            if (_index < 5) {
                // `[0, 4]`
                if (_index < 2) {
                    // `[0, 1]`
                    if (_index < 1) {
                        // `== 0`
                        return (GNUPLOT_COLORMAP_HASH, GNUPLOT_NAME);
                    } else {
                        // `== 1`
                        return (CMRMAP_COLORMAP_HASH, CMRMAP_NAME);
                    }
                } else {
                    // `[2, 4]`
                    if (_index < 4) {
                        // `[2, 3]`
                        if (_index == 2) {
                            // `== 2`
                            return (WISTIA_COLORMAP_HASH, WISTIA_NAME);
                        } else {
                            // `== 3`
                            return (AUTUMN_COLORMAP_HASH, AUTUMN_NAME);
                        }
                    } else {
                        // `== 4`
                        return (BINARY_COLORMAP_HASH, BINARY_NAME);
                    }
                }
            } else {
                // `[5, 9]`
                if (_index < 7) {
                    // `[5, 6]`
                    if (_index < 6) {
                        // `== 5`
                        return (BONE_COLORMAP_HASH, BONE_NAME);
                    } else {
                        // `== 6`
                        return (COOL_COLORMAP_HASH, COOL_NAME);
                    }
                } else {
                    // `[7, 9]`
                    if (_index < 9) {
                        // `[7, 8]`
                        if (_index < 8) {
                            // `== 7`
                            return (COPPER_COLORMAP_HASH, COPPER_NAME);
                        } else {
                            // `== 8`
                            return (GIST_RAINBOW_COLORMAP_HASH, GIST_RAINBOW_NAME);
                        }
                    } else {
                        // `== 9`
                        return (GIST_STERN_COLORMAP_HASH, GIST_STERN_NAME);
                    }
                }
            }
        } else {
            // `[10, type(uint256).max]`
            if (_index < 15) {
                // `[10, 14]`
                if (_index < 12) {
                    // `[10, 11]`
                    if (_index < 11) {
                        // `== 10`
                        return (GRAY_COLORMAP_HASH, GRAY_NAME);
                    } else {
                        // `== 11`
                        return (HOT_COLORMAP_HASH, HOT_NAME);
                    }
                } else {
                    // `[12, 14]`
                    if (_index < 14) {
                        // `[12, 13]`
                        if (_index < 13) {
                            // `== 12`
                            return (HSV_COLORMAP_HASH, HSV_NAME);
                        } else {
                            // `== 13`
                            return (JET_COLORMAP_HASH, JET_NAME);
                        }
                    } else {
                        // `== 14`
                        return (SPRING_COLORMAP_HASH, SPRING_NAME);
                    }
                }
            } else {
                // `[15, type(uint256).max]`
                if (_index < 18) {
                    // `[15, 17]`
                    if (_index < 17) {
                        // `[15, 16]`
                        if (_index < 16) {
                            // `== 15`
                            return (SUMMER_COLORMAP_HASH, SUMMER_NAME);
                        } else {
                            // `== 16`
                            return (TERRAIN_COLORMAP_HASH, TERRAIN_NAME);
                        }
                    } else {
                        // `== 17`
                        return (WINTER_COLORMAP_HASH, WINTER_NAME);
                    }
                } else {
                    // `[18, type(uint256).max]
                    if (_index < 19) {
                        // `== 18`
                        return (BASE_COLORMAP_HASH, BASE_NAME);
                    } else {
                        // [`19, type(uint256).max]`
                        return (FARCASTER_COLORMAP_HASH, FARCASTER_NAME);
                    }
                }
            }
        }
    }
}
