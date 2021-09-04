//
//  MTLSize+Extensions.swift
//  MetalExtensions
//
//  Created by Ceylo on 22/06/2019.
//  Copyright © 2019-2021 Yalir. This code is licensed under MIT license (see LICENSE for details).
//

import Metal
import CoreGraphics

public extension MTLSize {
    init(_ width: Int, _ height: Int) {
        self.init(width: width, height: height, depth: 1)
    }
    
    init(size: Int) {
        self.init(size, size)
    }
    
    var isEmpty: Bool {
        width <= 0 || height <= 0 || depth <= 0
    }
    
    var surface: Int {
        width * height
    }
    
    func contains(_ other: MTLSize) -> Bool {
        width >= other.width && height >= other.height && depth >= other.depth
    }
    
    func inflated(by offset: MTLVector) -> MTLSize {
        MTLSize(width: width + offset.dx, height: height + offset.dy, depth: depth + offset.dz)
    }
    
    func inflated(by offset: (Int, Int)) -> MTLSize {
        inflated(by: MTLVector(dx: offset.0, dy: offset.1, dz: 0))
    }
    
    func inflated(by offset: Int) -> MTLSize {
        inflated(by: (offset, offset))
    }
    
    func deflated(by offset: MTLVector) -> MTLSize {
        MTLSize(width: width - offset.dx, height: height - offset.dy, depth: depth - offset.dz)
    }
    
    func deflated(by offset: Int) -> MTLSize {
        deflated(by: MTLVector((offset, offset)))
    }
    
    func clamped(to other: MTLSize) -> MTLSize {
        MTLSize(width: min(width, other.width),
                height: min(height, other.height),
                depth: min(depth, other.depth))
    }
    
    static func / (lhs: MTLSize, rhs: Int) -> MTLSize {
        MTLSize(width: lhs.width / rhs,
                height: lhs.height / rhs,
                depth: lhs.depth / rhs)
    }
}

// MARK: - CoreGraphics
public extension MTLSize {
    init(_ size: CGSize) {
        self.init(width: Int(size.width), height: Int(size.height), depth: 1)
    }
    
    var cgSize: CGSize {
        CGSize(width: self.width, height: self.height)
    }
}

// MARK: - Equatable
extension MTLSize: Equatable {
    public static func == (lhs: MTLSize, rhs: MTLSize) -> Bool {
        lhs.width == rhs.width &&
            lhs.height == rhs.height &&
            lhs.depth == rhs.depth
    }
}

// MARK: - Hashable
extension MTLSize: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(width)
        hasher.combine(height)
        hasher.combine(depth)
    }
}

// MARK: - Codable
extension MTLSize: Codable {
    enum CodingKeys: String, CodingKey {
        case width
        case height
        case depth
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.init(width: try container.decode(Int.self, forKey: .width),
                  height: try container.decode(Int.self, forKey: .height),
                  depth: try container.decode(Int.self, forKey: .depth))
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(width, forKey: .width)
        try container.encode(height, forKey: .height)
        try container.encode(depth, forKey: .depth)
    }
}

// MARK: - CustomStringConvertible
extension MTLSize: CustomStringConvertible {
    public var description: String {
        if depth == 1 {
            return "\(width) x \(height)"
        } else {
            return "\(width) x \(height) x \(depth)"
        }
    }
}
