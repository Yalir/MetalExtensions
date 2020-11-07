//
//  MTLOrigin+Extensions.swift
//  MetalExtensions
//
//  Created by Ceylo on 22/06/2019.
//  Copyright © 2019 Yalir. This code is licensed under MIT license (see LICENSE for details).
//

import Metal
import CoreGraphics

public extension MTLOrigin {
    init(_ x: Int, _ y: Int) {
        self.init(x: x, y: y, z: 0)
    }
    
    init(_ size: MTLSize) {
        self.init(x: size.width, y: size.height, z: size.depth)
    }
    
    init(_ vector: MTLVector) {
        self.init(x: vector.dx, y: vector.dy, z: vector.dz)
    }
    
    static func - (lhs: MTLOrigin, rhs: MTLOrigin) -> MTLVector {
        return MTLVector(dx: lhs.x - rhs.x,
                         dy: lhs.y - rhs.y,
                         dz: lhs.z - rhs.z)
    }
    
    static func += (lhs: inout MTLOrigin, rhs: MTLVector) {
        lhs.x += Int(rhs.dx)
        lhs.y += Int(rhs.dy)
        lhs.z += Int(rhs.dz)
    }
    
    static func + (lhs: MTLOrigin, rhs: MTLVector) -> MTLOrigin {
        MTLOrigin(x: lhs.x + rhs.dx, y: lhs.y + rhs.dy, z: lhs.z + rhs.dz)
    }
    
    func translated(by offset: MTLVector) -> MTLOrigin {
        self + offset
    }
    
    func translated(by offset: (Int, Int)) -> MTLOrigin {
        self.translated(by: MTLVector(dx: offset.0, dy: offset.1, dz: 0))
    }
    
    static let zero = MTLOrigin()
}

// MARK: - CoreGraphics
public extension MTLOrigin {
    init(_ point: CGPoint) {
        self.init(x: Int(point.x), y: Int(point.y), z: 0)
    }
    
    var cgPoint: CGPoint {
        CGPoint(x: self.x, y: self.y)
    }
}

// MARK: - Equatable
extension MTLOrigin: Equatable {
    public static func == (lhs: MTLOrigin, rhs: MTLOrigin) -> Bool {
        return lhs.x == rhs.x &&
            lhs.y == rhs.y &&
            lhs.z == rhs.z
    }
}

// MARK: - Hashable
extension MTLOrigin: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
        hasher.combine(z)
    }
}

// MARK: - Codable
extension MTLOrigin: Codable {
    enum CodingKeys: String, CodingKey {
        case x
        case y
        case z
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.init(x: try container.decode(Int.self, forKey: .x),
                  y: try container.decode(Int.self, forKey: .y),
                  z: try container.decode(Int.self, forKey: .z))
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(x, forKey: .x)
        try container.encode(y, forKey: .y)
        try container.encode(z, forKey: .z)
    }
}

// MARK: - CustomStringConvertible
extension MTLOrigin: CustomStringConvertible {
    public var description: String {
        if z == 0 {
            return "(\(x), \(y))"
        } else {
            return "(\(x), \(y), \(z))"
        }
    }
}
