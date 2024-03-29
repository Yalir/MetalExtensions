//
//  MTLPixelFormat+Extensions.swift
//  MetalExtensions
//
//  Created by Ceylo on 15/08/2019.
//  Copyright © 2019-2021 Yalir. This code is licensed under MIT license (see LICENSE for details).
//

import Metal

extension MTLPixelFormat: CustomStringConvertible {
    public var description: String {
        switch self {
        case .invalid: return "invalid"
        case .a8Unorm: return "a8Unorm"
        case .r8Unorm: return "r8Unorm"
        case .r8Snorm: return "r8Snorm"
        case .r8Uint: return "r8Uint"
        case .r8Sint: return "r8Sint"
        case .r16Unorm: return "r16Unorm"
        case .r16Snorm: return "r16Snorm"
        case .r16Uint: return "r16Uint"
        case .r16Sint: return "r16Sint"
        case .r16Float: return "r16Float"
        case .rg8Unorm: return "rg8Unorm"
        case .rg8Snorm: return "rg8Snorm"
        case .rg8Uint: return "rg8Uint"
        case .rg8Sint: return "rg8Sint"
        case .r32Uint: return "r32Uint"
        case .r32Sint: return "r32Sint"
        case .r32Float: return "r32Float"
        case .rg16Unorm: return "rg16Unorm"
        case .rg16Snorm: return "rg16Snorm"
        case .rg16Uint: return "rg16Uint"
        case .rg16Sint: return "rg16Sint"
        case .rg16Float: return "rg16Float"
        case .rgba8Unorm: return "rgba8Unorm"
        case .rgba8Unorm_srgb: return "rgba8Unorm_srgb"
        case .rgba8Snorm: return "rgba8Snorm"
        case .rgba8Uint: return "rgba8Uint"
        case .rgba8Sint: return "rgba8Sint"
        case .bgra8Unorm: return "bgra8Unorm"
        case .bgra8Unorm_srgb: return "bgra8Unorm_srgb"
        case .rgb10a2Unorm: return "rgb10a2Unorm"
        case .rgb10a2Uint: return "rgb10a2Uint"
        case .rg11b10Float: return "rg11b10Float"
        case .rgb9e5Float: return "rgb9e5Float"
        case .bgr10a2Unorm: return "bgr10a2Unorm"
        case .rg32Uint: return "rg32Uint"
        case .rg32Sint: return "rg32Sint"
        case .rg32Float: return "rg32Float"
        case .rgba16Unorm: return "rgba16Unorm"
        case .rgba16Snorm: return "rgba16Snorm"
        case .rgba16Uint: return "rgba16Uint"
        case .rgba16Sint: return "rgba16Sint"
        case .rgba16Float: return "rgba16Float"
        case .rgba32Uint: return "rgba32Uint"
        case .rgba32Sint: return "rgba32Sint"
        case .rgba32Float: return "rgba32Float"
        case .bc1_rgba: return "bc1_rgba"
        case .bc1_rgba_srgb: return "bc1_rgba_srgb"
        case .bc2_rgba: return "bc2_rgba"
        case .bc2_rgba_srgb: return "bc2_rgba_srgb"
        case .bc3_rgba: return "bc3_rgba"
        case .bc3_rgba_srgb: return "bc3_rgba_srgb"
        case .bc4_rUnorm: return "bc4_rUnorm"
        case .bc4_rSnorm: return "bc4_rSnorm"
        case .bc5_rgUnorm: return "bc5_rgUnorm"
        case .bc5_rgSnorm: return "bc5_rgSnorm"
        case .bc6H_rgbFloat: return "bc6H_rgbFloat"
        case .bc6H_rgbuFloat: return "bc6H_rgbuFloat"
        case .bc7_rgbaUnorm: return "bc7_rgbaUnorm"
        case .bc7_rgbaUnorm_srgb: return "bc7_rgbaUnorm_srgb"
        case .gbgr422: return "gbgr422"
        case .bgrg422: return "bgrg422"
        case .depth16Unorm: return "depth16Unorm"
        case .depth32Float: return "depth32Float"
        case .stencil8: return "stencil8"
        case .depth24Unorm_stencil8: return "depth24Unorm_stencil8"
        case .depth32Float_stencil8: return "depth32Float_stencil8"
        case .x32_stencil8: return "x32_stencil8"
        case .x24_stencil8: return "x24_stencil8"
        case .r8Unorm_srgb: return "r8Unorm_srgb"
        case .rg8Unorm_srgb: return "rg8Unorm_srgb"
        case .b5g6r5Unorm: return "b5g6r5Unorm"
        case .a1bgr5Unorm: return "a1bgr5Unorm"
        case .abgr4Unorm: return "abgr4Unorm"
        case .bgr5A1Unorm: return "bgr5A1Unorm"
        case .bgr10_xr: return "bgr10_xr"
        case .bgr10_xr_srgb: return "bgr10_xr_srgb"
        case .bgra10_xr: return "bgra10_xr"
        case .bgra10_xr_srgb: return "bgra10_xr_srgb"
        case .pvrtc_rgb_2bpp: return "pvrtc_rgb_2bpp"
        case .pvrtc_rgb_2bpp_srgb: return "pvrtc_rgb_2bpp_srgb"
        case .pvrtc_rgb_4bpp: return "pvrtc_rgb_4bpp"
        case .pvrtc_rgb_4bpp_srgb: return "pvrtc_rgb_4bpp_srgb"
        case .pvrtc_rgba_2bpp: return "pvrtc_rgba_2bpp"
        case .pvrtc_rgba_2bpp_srgb: return "pvrtc_rgba_2bpp_srgb"
        case .pvrtc_rgba_4bpp: return "pvrtc_rgba_4bpp"
        case .pvrtc_rgba_4bpp_srgb: return "pvrtc_rgba_4bpp_srgb"
        case .eac_r11Unorm: return "eac_r11Unorm"
        case .eac_r11Snorm: return "eac_r11Snorm"
        case .eac_rg11Unorm: return "eac_rg11Unorm"
        case .eac_rg11Snorm: return "eac_rg11Snorm"
        case .eac_rgba8: return "eac_rgba8"
        case .eac_rgba8_srgb: return "eac_rgba8_srgb"
        case .etc2_rgb8: return "etc2_rgb8"
        case .etc2_rgb8_srgb: return "etc2_rgb8_srgb"
        case .etc2_rgb8a1: return "etc2_rgb8a1"
        case .etc2_rgb8a1_srgb: return "etc2_rgb8a1_srgb"
        case .astc_4x4_srgb: return "astc_4x4_srgb"
        case .astc_5x4_srgb: return "astc_5x4_srgb"
        case .astc_5x5_srgb: return "astc_5x5_srgb"
        case .astc_6x5_srgb: return "astc_6x5_srgb"
        case .astc_6x6_srgb: return "astc_6x6_srgb"
        case .astc_8x5_srgb: return "astc_8x5_srgb"
        case .astc_8x6_srgb: return "astc_8x6_srgb"
        case .astc_8x8_srgb: return "astc_8x8_srgb"
        case .astc_10x5_srgb: return "astc_10x5_srgb"
        case .astc_10x6_srgb: return "astc_10x6_srgb"
        case .astc_10x8_srgb: return "astc_10x8_srgb"
        case .astc_10x10_srgb: return "astc_10x10_srgb"
        case .astc_12x10_srgb: return "astc_12x10_srgb"
        case .astc_12x12_srgb: return "astc_12x12_srgb"
        case .astc_4x4_ldr: return "astc_4x4_ldr"
        case .astc_5x4_ldr: return "astc_5x4_ldr"
        case .astc_5x5_ldr: return "astc_5x5_ldr"
        case .astc_6x5_ldr: return "astc_6x5_ldr"
        case .astc_6x6_ldr: return "astc_6x6_ldr"
        case .astc_8x5_ldr: return "astc_8x5_ldr"
        case .astc_8x6_ldr: return "astc_8x6_ldr"
        case .astc_8x8_ldr: return "astc_8x8_ldr"
        case .astc_10x5_ldr: return "astc_10x5_ldr"
        case .astc_10x6_ldr: return "astc_10x6_ldr"
        case .astc_10x8_ldr: return "astc_10x8_ldr"
        case .astc_10x10_ldr: return "astc_10x10_ldr"
        case .astc_12x10_ldr: return "astc_12x10_ldr"
        case .astc_12x12_ldr: return "astc_12x12_ldr"
        case .astc_4x4_hdr: return "astc_4x4_hdr"
        case .astc_5x4_hdr: return "astc_5x4_hdr"
        case .astc_5x5_hdr: return "astc_5x5_hdr"
        case .astc_6x5_hdr: return "astc_6x5_hdr"
        case .astc_6x6_hdr: return "astc_6x6_hdr"
        case .astc_8x5_hdr: return "astc_8x5_hdr"
        case .astc_8x6_hdr: return "astc_8x6_hdr"
        case .astc_8x8_hdr: return "astc_8x8_hdr"
        case .astc_10x5_hdr: return "astc_10x5_hdr"
        case .astc_10x6_hdr: return "astc_10x6_hdr"
        case .astc_10x8_hdr: return "astc_10x8_hdr"
        case .astc_10x10_hdr: return "astc_10x10_hdr"
        case .astc_12x10_hdr: return "astc_12x10_hdr"
        case .astc_12x12_hdr: return "astc_12x12_hdr"
        @unknown default: fatalError()
        }
    }
}
