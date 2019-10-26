//
//  MTLComputeCommandEncoder+Extensions.swift
//  MetalExtensions
//
//  Created by Ceylo on 30/04/2019.
//  Copyright © 2019 Yalir. This code is licensed under MIT license (see LICENSE for details).
//

import Metal

public extension MTLComputeCommandEncoder {
    func dispatchThreadgroupsForWorkingOn(_ texture: MTLTexture) {
        let size = MTLSize(width: texture.width, height: texture.height, depth: 1)
        dispatchThreadgroupsForWorkingOn(size)
    }
    
    func dispatchThreadgroupsForWorkingOn(_ size: MTLSize) {
        let threadGroupSize = MTLSize(width: 16, height: 16, depth: 1)
        let threadGroupCount = MTLSize(
            width: (size.width + threadGroupSize.width - 1) / threadGroupSize.width,
            height: (size.height + threadGroupSize.height - 1) / threadGroupSize.height,
            depth: 1)
        dispatchThreadgroups(threadGroupCount, threadsPerThreadgroup: threadGroupSize)
    }
}
