//
//  MTLComputeCommandEncoder+Extensions.swift
//  MetalExtensions
//
//  Created by Ceylo on 30/04/2019.
//  Copyright © 2019 Yalir. This code is licensed under MIT license (see LICENSE for details).
//

import Metal

public extension MTLComputeCommandEncoder {
    func dispatchThreadgroupsForWorkingOn(_ texture: MTLTexture, threadExecutionWidth: Int = 16) {
        let size = MTLSize(width: texture.width, height: texture.height, depth: 1)
        dispatchThreadgroupsForWorkingOn(size, threadExecutionWidth: threadExecutionWidth)
    }
    
    func dispatchThreadgroupsForWorkingOn(_ size: MTLSize, threadExecutionWidth: Int = 16) {
        let threadGroupSize = MTLSize(width: 1, height: threadExecutionWidth, depth: 1)
        let threadGroupCount = MTLSize(
            width: (size.width + threadGroupSize.width - 1) / threadGroupSize.width,
            height: (size.height + threadGroupSize.height - 1) / threadGroupSize.height,
            depth: 1)
        dispatchThreadgroups(threadGroupCount, threadsPerThreadgroup: threadGroupSize)
    }
}
