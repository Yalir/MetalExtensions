//
//  MTLClearColor+Extensions.swift
//  MetalExtensions
//
//  Created by Ceylo on 14/06/2019.
//  Copyright © 2019 Yalir. This code is licensed under MIT license (see LICENSE for details).
//

#if os(macOS)
import AppKit
import Metal

public extension MTLClearColor {
    init(_ color: NSColor) {
        self.init(red: Double(color.redComponent),
                  green: Double(color.greenComponent),
                  blue: Double(color.blueComponent),
                  alpha: Double(color.alphaComponent))
    }
}
#endif
