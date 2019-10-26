//
//  MTLRegion+Extensions.swift
//  ArtOverflow
//
//  Created by Ceylo on 30/04/2019.
//  Copyright © 2019 Yalir. All rights reserved.
//

import Metal
import CoreGraphics

// MARK: Concise initialization
public extension MTLRegion {
    /// Create a 2D MTLRegion from the given tuples.
    init(_ origin: (Int, Int), _ size: (Int, Int)) {
        self.init(origin: MTLOrigin(x: origin.0, y: origin.1, z: 0),
                  size: MTLSize(width: size.0, height: size.1, depth: 1))
    }
    
    /// Create a 3D MTLRegion from the given tuples.
    init(_ origin: (Int, Int, Int), _ size: (Int, Int, Int)) {
        self.init(origin: MTLOrigin(x: origin.0, y: origin.1, z: origin.2),
                  size: MTLSize(width: size.0, height: size.1, depth: size.2))
    }
}
 
// MARK: - Core Graphics helpers
public extension MTLRegion {
    init(_ size: CGSize) {
        self.init(origin: .zero, size: MTLSize(size))
    }
    
    init(_ rect: CGRect) {
        self.init(origin: MTLOrigin(rect.origin), size: MTLSize(rect.size))
    }
}

// MARK: - Geometry helpers
public extension MTLRegion {
    /// - Returns: the smallest region that contains the two source regions.
    func union(_ other: MTLRegion) -> MTLRegion {
        guard !isEmpty else { return other }
        guard !other.isEmpty else { return self }
        
        let left = min(origin.x, other.origin.x)
        let bottom = min(origin.y, other.origin.y)
        let front = min(origin.z, other.origin.z)
        let right = max(origin.x + size.width, other.origin.x + other.size.width)
        let top = max(origin.y + size.height, other.origin.y + other.size.height)
        let back = max(origin.z + size.depth, other.origin.z + other.size.depth)
        guard right >= left && top >= bottom && back >= front else { fatalError() }
        
        return MTLRegion((left, bottom, front), (right - left, top - bottom, back - front))
    }
    
    func contains(_ other: MTLRegion) -> Bool {
        return intersection(other) == other
    }
    
    func intersects(_ other: MTLRegion) -> Bool {
        return intersection(other) != nil
    }
    
    func intersection(_ other: MTLRegion) -> MTLRegion? {
        let l1 = origin.x
        let l2 = other.origin.x
        let r1 = l1 + size.width
        let r2 = l2 + other.size.width
        let l3 = max(l1, l2)
        let r3 = min(r1, r2)
        guard l3 < r3 else { return nil }
        
        let b1 = origin.y
        let b2 = other.origin.y
        let t1 = b1 + size.height
        let t2 = b2 + other.size.height
        let b3 = max(b1, b2)
        let t3 = min(t1, t2)
        guard b3 < t3 else { return nil }
        
        let f1 = origin.z
        let f2 = other.origin.z
        let d1 = f1 + size.depth
        let d2 = f2 + other.size.depth
        let f3 = max(f1, f2)
        let d3 = min(d1, d2)
        guard f3 < d3 else { return nil }
        
        return MTLRegion((l3, b3, f3), (r3 - l3, t3 - b3, d3 - f3))
    }
    
    var isEmpty: Bool {
        return size.isEmpty
    }
}

// MARK: - Equatable
extension MTLRegion: Equatable {
    public static func == (lhs: MTLRegion, rhs: MTLRegion) -> Bool {
        return lhs.origin == rhs.origin && lhs.size == rhs.size
    }
}

// MARK: - Hashable
extension MTLRegion: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(origin)
        hasher.combine(size)
    }
}

// MARK: - Codable
extension MTLRegion: Codable {
    enum CodingKeys: String, CodingKey {
        case origin
        case size
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.init()
        self.origin = try container.decode(MTLOrigin.self, forKey: .origin)
        self.size = try container.decode(MTLSize.self, forKey: .size)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(origin, forKey: .origin)
        try container.encode(size, forKey: .size)
    }
}

// MARK: - CustomStringConvertible
extension MTLRegion: CustomStringConvertible {
    public var description: String {
        return "{\(origin), \(size)}"
    }
}