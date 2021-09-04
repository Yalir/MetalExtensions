//
//  Simd+Extensions.swift
//  MetalExtensions
//
//  Created by Ceylo on 19/03/2019.
//  Copyright © 2019-2021 Yalir. This code is licensed under MIT license (see LICENSE for details).
//

import Metal
import simd
import CoreGraphics

public extension SIMD2 where Scalar == Float {
    init(_ point: CGPoint) {
        self.init(Float(point.x), Float(point.y))
    }
    
    init(_ size: CGSize) {
        self.init(Float(size.width), Float(size.height))
    }
}

public extension SIMD2 where Scalar == UInt32 {
    init(_ origin: MTLOrigin) {
        self.init(UInt32(origin.x), UInt32(origin.y))
    }
    
    init(_ size: MTLSize) {
        self.init(UInt32(size.width), UInt32(size.height))
    }
}

public extension float3x3 {
    init(_ transform: CGAffineTransform) {
        self.init(rows:[
            SIMD3<Float>(Float(transform.a),  Float(transform.b),  Float(0)),
            SIMD3<Float>(Float(transform.c),  Float(transform.d),  Float(0)),
            SIMD3<Float>(Float(transform.tx), Float(transform.ty), Float(1))])
    }
}
