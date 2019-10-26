//
//  MTLPixelFormat+Extensions.swift
//  MetalExtensions
//
//  Created by Ceylo on 15/08/2019.
//  Copyright © 2019 Yalir. This code is licensed under MIT license (see LICENSE for details).
//

import Metal

public extension MTLPixelFormat {
    var bitsPerSample: Int {
        switch self {
        case .a8Unorm, .r8Unorm, .r8Snorm, .r8Uint, .r8Sint,
             .rg8Unorm, .rg8Snorm, .rg8Uint, .rg8Sint,
             .rgba8Unorm, .rgba8Snorm, .rgba8Uint, .rgba8Sint, .bgra8Unorm,
             .rgba8Unorm_srgb, .bgra8Unorm_srgb, .stencil8:
            return 8
            
        case .r16Unorm, .r16Snorm, .r16Uint, .r16Sint, .r16Float,
             .rg16Unorm, .rg16Snorm, .rg16Uint, .rg16Sint, .rg16Float,
             .rgba16Unorm, .rgba16Snorm, .rgba16Uint, .rgba16Sint, .rgba16Float,
             .depth16Unorm:
            return 16

        case .r32Uint, .r32Sint, .r32Float, .rg32Uint, .rg32Sint, .rg32Float,
             .rgba32Uint, .rgba32Sint, .rgba32Float, .depth32Float:
            return 32

        case .invalid, .rgb10a2Unorm, .rgb10a2Uint, .bgr10a2Unorm, .rg11b10Float, .rgb9e5Float,
             .bc1_rgba, .bc1_rgba_srgb, .bc2_rgba, .bc2_rgba_srgb, .bc3_rgba, .bc3_rgba_srgb,
             .bc4_rUnorm, .bc4_rSnorm, .bc5_rgUnorm, .bc5_rgSnorm, .bc6H_rgbFloat, .bc6H_rgbuFloat,
             .bc7_rgbaUnorm, .bc7_rgbaUnorm_srgb, .gbgr422, .bgrg422,
             .depth24Unorm_stencil8, .depth32Float_stencil8, .x32_stencil8, .x24_stencil8:
            return 0

        @unknown default:
            fatalError()
        }
    }
}

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
        @unknown default: fatalError()
        }
    }
}
