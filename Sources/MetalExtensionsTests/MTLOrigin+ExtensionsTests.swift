//
//  MTLOrigin+ExtensionsTests.swift
//  MetalExtensionsTests
//
//  Created by Ceylo on 22/06/2019.
//  Copyright © 2019 Yalir. This code is licensed under MIT license (see LICENSE for details).
//

import XCTest
@testable import MetalExtensions

class MTLOrigin_ExtensionsTests: XCTestCase {
    func testCodable() throws {
        let orig = MTLOriginMake(1, 2, 3)
        
        let encoder = NSKeyedArchiver(requiringSecureCoding: true)
        try encoder.encodeEncodable(orig, forKey: "Orig")
        let data = encoder.encodedData
        
        let decoder = try NSKeyedUnarchiver(forReadingFrom: data)
        let orig2 = decoder.decodeDecodable(MTLOrigin.self, forKey: "Orig")
        XCTAssertEqual(orig, orig2)
    }
}
