//
//  MTLCommandBuffer+Extensions.swift
//  MetalExtensions
//
//  Created by Ceylo on 27/02/2020.
//  Copyright © 2019 Yalir. This code is licensed under MIT license (see LICENSE for details).
//

import Metal

public extension MTLCommandBuffer {
    func blit(label: String? = nil,
              _ closure: (_ encoder: MTLBlitCommandEncoder) -> Void) {
        let encoder = makeBlitCommandEncoder()!
        if let label = label {
            encoder.label = label
        }
        closure(encoder)
        encoder.endEncoding()
    }
    
    func compute(label: String? = nil,
                 _ closure: (_ encoder: MTLComputeCommandEncoder) -> Void) {
        let encoder = makeComputeCommandEncoder()!
        if let label = label {
            encoder.label = label
        }
        closure(encoder)
        encoder.endEncoding()
    }
}
