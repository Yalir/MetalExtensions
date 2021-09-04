//
//  MPSOffset+Extensions.swift
//  MetalExtensions
//
//  Created by Ceylo on 21/08/2019.
//  Copyright © 2019-2021 Yalir. This code is licensed under MIT license (see LICENSE for details).
//

import MetalPerformanceShaders

public extension MPSOffset {
    init(_ origin: MTLOrigin) {
        self.init(x: origin.x, y: origin.y, z: origin.z)
    }
}
