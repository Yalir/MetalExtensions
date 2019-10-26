//
//  MTLOrigin+Extensions.swift
//  ArtOverflow
//
//  Created by Ceylo on 22/06/2019.
//  Copyright © 2019 Yalir. All rights reserved.
//

import Metal
import CoreGraphics

public extension MTLOrigin {
    init(_ point: CGPoint) {
        self.init(x: Int(point.x), y: Int(point.y), z: 0)
    }
    
    static func -(lhs: MTLOrigin, rhs: MTLOrigin) -> MTLOrigin {
        return MTLOrigin(x: lhs.x - rhs.x,
                         y: lhs.y - rhs.y,
                         z: lhs.z - rhs.z)
    }
    
    static func +=(lhs: inout MTLOrigin, rhs: CGVector) {
        lhs.x += Int(rhs.dx)
        lhs.y += Int(rhs.dy)
    }
    
    static let zero = MTLOrigin()
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
