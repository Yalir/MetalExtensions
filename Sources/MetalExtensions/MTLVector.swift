//
//  MTLVector.swift
//  MetalExtensions
//
//  Created by Ceylo on 22/06/2019.
//  Copyright © 2019 Yalir. This code is licensed under MIT license (see LICENSE for details).
//

import Foundation

public struct MTLVector {
    var dx: Int = 0
    var dy: Int = 0
    var dz: Int = 0
    
    init(dx: Int = 0, dy: Int = 0, dz: Int = 0) {
        self.dx = dx
        self.dy = dy
        self.dz = dz
    }
    
    init(vector: CGVector, residual: inout CGVector) {
        dx = Int(vector.dx)
        dy = Int(vector.dy)
        
        residual = CGVector(dx: vector.dx - CGFloat(dx), dy: vector.dy - CGFloat(dy))
    }
    
    var isNull: Bool {
        dx == 0 && dy == 0 && dz == 0
    }
}
