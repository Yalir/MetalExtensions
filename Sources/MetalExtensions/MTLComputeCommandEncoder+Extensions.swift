//
//  MTLComputeCommandEncoder+Extensions.swift
//  MetalExtensions
//
//  Created by Ceylo on 30/04/2019.
//  Copyright © 2019-2021 Yalir. This code is licensed under MIT license (see LICENSE for details).
//

import Metal

public extension MTLComputeCommandEncoder {
    func dispatchThreadgroupsForWorkingOn(_ texture: MTLTexture,
                                          with state: MTLComputePipelineState) {
        dispatchThreadgroupsForWorkingOn(texture.size, with: state)
    }
    
    func dispatchThreadgroupsForWorkingOn(_ size: MTLSize,
                                          with state: MTLComputePipelineState) {
        let w = state.threadExecutionWidth
        let h = state.maxTotalThreadsPerThreadgroup / w
        let threadsPerThreadgroup = MTLSizeMake(w, h, 1)
        dispatchThreads(size, threadsPerThreadgroup: threadsPerThreadgroup)
    }
}
