//
//  MTLVector.swift
//  MetalExtensions
//
//  Created by Ceylo on 22/06/2019.
//  Copyright © 2019 Yalir. This code is licensed under MIT license (see LICENSE for details).
//

import Foundation

public struct MTLVector: Equatable {
    public var dx: Int = 0
    public var dy: Int = 0
    public var dz: Int = 0
    
    static public var zero = MTLVector()
    
    public init(dx: Int = 0, dy: Int = 0, dz: Int = 0) {
        self.dx = dx
        self.dy = dy
        self.dz = dz
    }
    
    public init(vector: CGVector, residual: inout CGVector) {
        dx = Int(vector.dx)
        dy = Int(vector.dy)
        
        residual = CGVector(dx: vector.dx - CGFloat(dx), dy: vector.dy - CGFloat(dy))
    }
    
    public var isNull: Bool {
        dx == 0 && dy == 0 && dz == 0
    }
    
    public var length: CGFloat {
        CGFloat(dx*dx + dy*dy + dz*dz).squareRoot()
    }
    
    static public prefix func -(vec: MTLVector) -> MTLVector {
        MTLVector(dx: -vec.dx, dy: -vec.dy, dz: -vec.dz)
    }
    
    static public func +(lhs: MTLVector, rhs: MTLVector) -> MTLVector {
        MTLVector(dx: lhs.dx + rhs.dx, dy: lhs.dy + rhs.dy, dz: lhs.dz + rhs.dz)
    }
    
    static public func +=(lhs: inout MTLVector, rhs: MTLVector) {
        lhs = lhs + rhs
    }
}
