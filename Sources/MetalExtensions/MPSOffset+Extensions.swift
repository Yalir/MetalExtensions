//
//  MPSOffset+Extensions.swift
//  ArtOverflow
//
//  Created by Ceylo on 21/08/2019.
//  Copyright © 2019 Yalir. All rights reserved.
//

import MetalPerformanceShaders

public extension MPSOffset {
    init(_ origin: MTLOrigin) {
        self.init(x: origin.x, y: origin.y, z: origin.z)
    }
}
