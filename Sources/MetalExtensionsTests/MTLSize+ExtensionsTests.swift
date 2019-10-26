//
//  MTLSize+ExtensionsTests.swift
//  MetalExtensionsTests
//
//  Created by Ceylo on 22/06/2019.
//  Copyright © 2019 Yalir. This code is licensed under MIT license (see LICENSE for details).
//

import XCTest
@testable import MetalExtensions

class MTLSize_ExtensionsTests: XCTestCase {
    func testCodable() throws {
        let size = MTLSizeMake(1, 2, 3)
        
        let encoder = NSKeyedArchiver(requiringSecureCoding: true)
        try encoder.encodeEncodable(size, forKey: "Size")
        let data = encoder.encodedData
        
        let decoder = try NSKeyedUnarchiver(forReadingFrom: data)
        let size2 = decoder.decodeDecodable(MTLSize.self, forKey: "Size")
        XCTAssertEqual(size, size2)
    }
    
    func testContainsBiggerSize_fails() {
        XCTAssertFalse(MTLSize(width: 10, height: 10, depth: 1)
            .contains(MTLSize(width: 11, height: 10, depth: 1)))
        XCTAssertFalse(MTLSize(width: 10, height: 10, depth: 1)
            .contains(MTLSize(width: 10, height: 11, depth: 1)))
        XCTAssertFalse(MTLSize(width: 10, height: 10, depth: 1)
            .contains(MTLSize(width: 10, height: 10, depth: 2)))
    }
    
    func testContainsSmallerSize_succeeds() {
        XCTAssertTrue(MTLSize(width: 10, height: 10, depth: 1)
            .contains(MTLSize(width: 9, height: 10, depth: 1)))
        XCTAssertTrue(MTLSize(width: 10, height: 10, depth: 1)
            .contains(MTLSize(width: 10, height: 9, depth: 1)))
        XCTAssertTrue(MTLSize(width: 10, height: 10, depth: 1)
            .contains(MTLSize(width: 10, height: 10, depth: 0)))
    }
    
    func testContainsSameSize_succeeds() {
        XCTAssertTrue(MTLSize(width: 10, height: 10, depth: 1)
            .contains(MTLSize(width: 10, height: 10, depth: 1)))
    }
}
