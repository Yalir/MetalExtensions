//
//  MTLTexture+Extensions.swift
//  MetalExtensions
//
//  Created by Ceylo on 22/06/2019.
//  Copyright © 2019 Yalir. This code is licensed under MIT license (see LICENSE for details).
//

import Metal

public extension MTLTexture {
    var size: MTLSize {
        return MTLSize(width: width, height: height, depth: depth)
    }
}

// MARK: - Equatable
public extension MTLTexture {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.hash == rhs.hash
    }
}

public extension MTLTextureUsage {
    static let shaderReadWrite: MTLTextureUsage = [.shaderRead, .shaderWrite]
}

extension MTLTextureUsage: Hashable {}
