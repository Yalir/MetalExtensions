//
//  MTLSize+Extensions.swift
//  ArtOverflow
//
//  Created by Ceylo on 22/06/2019.
//  Copyright © 2019 Yalir. All rights reserved.
//

import Metal
import CoreGraphics

public extension MTLSize {
    init(_ size: CGSize) {
        self.init(width: Int(size.width), height: Int(size.height), depth: 1)
    }
    
    var isEmpty: Bool {
        return width <= 0 || height <= 0 || depth <= 0
    }
    
    var surface: Int {
        return width * height
    }
    
    func contains(_ other: MTLSize) -> Bool {
        return width >= other.width && height >= other.height && depth >= other.depth
    }
}

// MARK: - Equatable
extension MTLSize: Equatable {
    public static func == (lhs: MTLSize, rhs: MTLSize) -> Bool {
        return lhs.width == rhs.width &&
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
            return "(\(width) x \(height))"
        } else {
            return "(\(width) x \(height) x \(depth))"
        }
    }
}