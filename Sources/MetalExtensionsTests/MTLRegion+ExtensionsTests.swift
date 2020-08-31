//
//  MTLRegion+ExtensionsTests.swift
//  MetalExtensionsTests
//
//  Created by Ceylo on 01/05/2019.
//  Copyright © 2019 Yalir. This code is licensed under MIT license (see LICENSE for details).
//

import XCTest
@testable import MetalExtensions

class MTLRegion_ExtensionsTests: XCTestCase {
    func testEmptyRegionIncludingEmpty_remainsEmpty() {
        XCTAssertEqual(MTLRegion(), MTLRegion().union(MTLRegion()))
    }
    
    func testEmptyRegionIncludingNewRegion_returnsNewRegion() {
        let region = MTLRegion(origin: MTLOrigin(x: 1, y: 2, z: 3),
                                  size: MTLSize(width: 4, height: 5, depth: 6))
        XCTAssertEqual(region, MTLRegion().union(region))
    }
    
    func testRegionIncludingEmptyRegion_returnsOriginalRegion() {
        let region = MTLRegion(origin: MTLOrigin(x: 1, y: 2, z: 3),
                                  size: MTLSize(width: 4, height: 5, depth: 6))
        XCTAssertEqual(region, region.union(MTLRegion()))
    }
    
    func testRegionIncludingOverlappingRegion_returnsExtendedRegion() {
        let r1 = MTLRegion(origin: MTLOrigin(x: 1, y: 2, z: 3),
                               size: MTLSize(width: 4, height: 5, depth: 6))
        let r2 = MTLRegion(origin: MTLOrigin(x: 2, y: -3, z: 4),
                           size: MTLSize(width: 7, height: 8, depth: 9))
        let r3 = MTLRegion(origin: MTLOrigin(x: 1, y: -3, z: 3),
                           size: MTLSize(width: 8, height: 10, depth: 10))
        XCTAssertEqual(r3, r1.union(r2))
    }
    
    func testRegionIncludingNonOverlappingRegion_returnsExtendedRegion() {
        let r1 = MTLRegion(origin: MTLOrigin(x: 1, y: 2, z: 3),
                           size: MTLSize(width: 4, height: 5, depth: 6))
        let r2 = MTLRegion(origin: MTLOrigin(x: 20, y: -30, z: 40),
                           size: MTLSize(width: 7, height: 8, depth: 9))
        let r3 = MTLRegion(origin: MTLOrigin(x: 1, y: -30, z: 3),
                           size: MTLSize(width: 26, height: 37, depth: 46))
        XCTAssertEqual(r3, r1.union(r2))
    }
    
    func testCodable() throws {
        let region = MTLRegionMake2D(1, 2, 3, 4)
        
        let encoder = NSKeyedArchiver(requiringSecureCoding: true)
        try encoder.encodeEncodable(region, forKey: "Region")
        let data = encoder.encodedData
        
        let decoder = try NSKeyedUnarchiver(forReadingFrom: data)
        let region2 = decoder.decodeDecodable(MTLRegion.self, forKey: "Region")
        XCTAssertEqual(region, region2)
    }
    
    func testRegionContainsRegionInside_succeeds() {
        XCTAssertTrue(MTLRegion((1, 2, 3), (4, 5, 6))
            .contains(MTLRegion((1, 2, 3), (4, 5, 6))))
        
        XCTAssertTrue(MTLRegion((1, 2, 3), (4, 5, 6))
            .contains(MTLRegion((2, 3, 4), (2, 2, 3))))
    }
    
    func testRegionContainsRegionOverlapping_fails() {
        // on x
        XCTAssertFalse(MTLRegion((1, 2, 3), (4, 5, 6))
            .contains(MTLRegion((3, 6, 4), (4, 1, 3))))
        // on y
        XCTAssertFalse(MTLRegion((1, 2, 3), (4, 5, 6))
            .contains(MTLRegion((1, 6, 4), (4, 2, 3))))
        // on z
        XCTAssertFalse(MTLRegion((1, 2, 3), (4, 5, 6))
            .contains(MTLRegion((3, 3, 5), (4, 1, 5))))
    }
    
    func testRegionContainsRegionOutside_fails() {
        // on x
        XCTAssertFalse(MTLRegion((1, 2, 3), (4, 5, 6))
            .contains(MTLRegion((6, 6, 4), (4, 1, 3))))
        // on y
        XCTAssertFalse(MTLRegion((1, 2, 3), (4, 5, 6))
            .contains(MTLRegion((1, 8, 4), (4, 2, 3))))
        // on z
        XCTAssertFalse(MTLRegion((1, 2, 3), (4, 5, 6))
            .contains(MTLRegion((3, 3, 10), (4, 1, 5))))
    }
    
    // I wish XCTest supported parametrized tests!
    let intersectsTestCases: [(label: String, r1: MTLRegion, r2: MTLRegion, expectIntersection: Bool)] = [
        ("regionAbove",
         MTLRegion((1, 2, 3), (4, 5, 6)), MTLRegion((1, 8, 3), (4, 5, 6)), false),
        ("regionBelow",
         MTLRegion((1, 2, 3), (4, 5, 6)), MTLRegion((1, -5, 3), (4, 5, 6)), false),
        ("regionOnLeft",
         MTLRegion((1, 2, 3), (4, 5, 6)), MTLRegion((-5, 2, 3), (4, 5, 6)), false),
        ("regionOnRight",
         MTLRegion((1, 2, 3), (4, 5, 6)), MTLRegion((6, 2, 3), (4, 5, 6)), false),
        ("regionInside",
         MTLRegion((1, 2, 3), (4, 5, 6)), MTLRegion((2, 3, 4), (2, 3, 4)), true),
        ("regionOverlappingOnLeft",
         MTLRegion((1, 2, 3), (4, 5, 6)), MTLRegion((-1, 2, 3), (4, 5, 6)), true),
        ("regionOverlappingOnTop",
         MTLRegion((1, 2, 3), (4, 5, 6)), MTLRegion((1, 5, 3), (4, 5, 6)), true),
        ("regionOverlappingOnRight",
         MTLRegion((1, 2, 3), (4, 5, 6)), MTLRegion((4, 2, 3), (4, 5, 6)), true),
        ("regionOverlappingOnBottom",
         MTLRegion((1, 2, 3), (4, 5, 6)), MTLRegion((1, -2, 3), (4, 5, 6)), true),
    ]
    
    func testRegionIntersects() {
        for tc in intersectsTestCases {
            XCTAssertEqual(tc.expectIntersection, tc.r1.intersects(tc.r2), tc.label)
        }
    }
    
    let intersectionTestCases: [(label: String, r1: MTLRegion, r2: MTLRegion, expectedIntersection: MTLRegion?)] = [
        ("regionAbove",
         MTLRegion((1, 2, 3), (4, 5, 6)), MTLRegion((1, 8, 3), (4, 5, 6)), nil),
        ("regionBelow",
         MTLRegion((1, 2, 3), (4, 5, 6)), MTLRegion((1, -5, 3), (4, 5, 6)), nil),
        ("regionOnLeft",
         MTLRegion((1, 2, 3), (4, 5, 6)), MTLRegion((-5, 2, 3), (4, 5, 6)), nil),
        ("regionOnRight",
         MTLRegion((1, 2, 3), (4, 5, 6)), MTLRegion((6, 2, 3), (4, 5, 6)), nil),
        ("regionInside",
         MTLRegion((1, 2, 3), (4, 5, 6)), MTLRegion((2, 3, 4), (2, 3, 4)), MTLRegion((2, 3, 4), (2, 3, 4))),
        ("regionOverlappingOnLeft",
         MTLRegion((1, 2, 3), (4, 5, 6)), MTLRegion((-1, 2, 3), (4, 5, 6)), MTLRegion((1, 2, 3), (2, 5, 6))),
        ("regionOverlappingOnTop",
         MTLRegion((1, 2, 3), (4, 5, 6)), MTLRegion((1, 5, 3), (4, 5, 6)), MTLRegion((1, 5, 3), (4, 2, 6))),
        ("regionOverlappingOnRight",
         MTLRegion((1, 2, 3), (4, 5, 6)), MTLRegion((4, 2, 3), (4, 5, 6)), MTLRegion((4, 2, 3), (1, 5, 6))),
        ("regionOverlappingOnBottom",
         MTLRegion((1, 2, 3), (4, 5, 6)), MTLRegion((1, -2, 3), (4, 5, 6)), MTLRegion((1, 2, 3), (4, 1, 6))),
    ]
    
    func testRegionIntersection() {
        for tc in intersectionTestCases {
            XCTAssertEqual(tc.expectedIntersection, tc.r1.intersection(tc.r2), tc.label)
        }
    }
    
    func testRegionSplit() {
        // Empty region
        XCTAssertEqual([MTLRegion()], MTLRegion().split(by: MTLSize(3, 5)))
        
        // Split by size bigger than original region, returns original region
        XCTAssertEqual([MTLRegion((3, 5), (1, 1))],
                       MTLRegion((3, 5), (1, 1)).split(by: MTLSize(3, 5)))
        
        // Split by size smaller than original region, last row is clamped
        XCTAssertEqual([MTLRegion((3, 5), (3, 5)), MTLRegion((6, 5), (3, 5)),
                        MTLRegion((3, 10), (3, 2)), MTLRegion((6, 10), (3, 2))],
                       MTLRegion((3, 5), (6, 7)).split(by: MTLSize(3, 5)))
        
        XCTAssertEqual([
            MTLRegion((3, 5), (1, 1)), MTLRegion((4, 5), (1, 1)), MTLRegion((5, 5), (1, 1)),
            MTLRegion((3, 6), (1, 1)), MTLRegion((4, 6), (1, 1)), MTLRegion((5, 6), (1, 1))],
                       MTLRegion((3, 5), (3, 2)).split(by: MTLSize(1, 1)))
        
        XCTAssertEqual([
            MTLRegion((1066, 400), (312, 512)),
            MTLRegion((1066, 912), (312, 21))
        ], MTLRegion((1066, 400), (312, 533)).split(by: MTLSize(512, 512)))
    }
    
    func testRemovingVerticalStrip() {
        // Remove all
        XCTAssertEqual([], MTLRegion((0, 0), (10, 10))
            .removingVerticalStrip(MTLRegion((0, 0), (10, 10))))
        
        // Remove right part
        XCTAssertEqual([MTLRegion((0, 0), (5, 10))],
                       MTLRegion((0, 0), (10, 10))
            .removingVerticalStrip(MTLRegion((5, 0), (10, 10))))
        
        // Remove middle
        XCTAssertEqual([MTLRegion((0, 0), (5, 10)), MTLRegion((8, 0), (2, 10))],
                       MTLRegion((0, 0), (10, 10))
            .removingVerticalStrip(MTLRegion((5, 0), (3, 10))))
        
        // Remove left part
        XCTAssertEqual([MTLRegion((3, 0), (7, 10))],
                       MTLRegion((0, 0), (10, 10))
            .removingVerticalStrip(MTLRegion((0, 0), (3, 10))))
        
        // Remove none
        XCTAssertEqual([MTLRegion((0, 0), (10, 10))],
                       MTLRegion((0, 0), (10, 10))
            .removingVerticalStrip(MTLRegion((10, 0), (3, 10))))
    }
    
    func testRemovingHorizontalStrip() {
        // Remove all
        XCTAssertEqual([], MTLRegion((0, 0), (10, 10))
            .removingHorizontalStrip(MTLRegion((0, 0), (10, 10))))
        
        // Remove bottom part
        XCTAssertEqual([MTLRegion((0, 5), (10, 5))],
                       MTLRegion((0, 0), (10, 10))
            .removingHorizontalStrip(MTLRegion((0, 0), (10, 5))))
        
        // Remove middle
        XCTAssertEqual([MTLRegion((0, 0), (10, 5)), MTLRegion((0, 8), (10, 2))],
                       MTLRegion((0, 0), (10, 10))
            .removingHorizontalStrip(MTLRegion((0, 5), (10, 3))))
        
        // Remove top part
        XCTAssertEqual([MTLRegion((0, 0), (10, 7))],
                       MTLRegion((0, 0), (10, 10))
            .removingHorizontalStrip(MTLRegion((0, 7), (10, 3))))
        
        // Remove none
        XCTAssertEqual([MTLRegion((0, 0), (10, 10))],
                       MTLRegion((0, 0), (10, 10))
            .removingHorizontalStrip(MTLRegion((0, 10), (10, 3))))
    }
    
    func testRemovingHorizontalAndVerticalStrips_realCase() {
        let region = MTLRegion((0, 0), (1024, 1024))
        
        let verticalStrips = [
            MTLRegion((0, 0), (192, 1024)),
            MTLRegion((864, 0), (160, 1024))
        ]
        
        let horizontalStrips = [
            MTLRegion((0, 0), (1024, 64)),
            MTLRegion((0, 480), (1024, 64)),
            MTLRegion((0, 896), (1024, 128))
        ]
        
        XCTAssertEqual([MTLRegion((192, 64), (672, 416)),
                        MTLRegion((192, 544), (672, 352))],
                       region.removing(verticalStrips: verticalStrips,
                                       horizontalStrips: horizontalStrips))
    }
    
    func testRemovingHorizontalAndVerticalStrips_nothingToRemove() {
        let region = MTLRegion((0, 0), (1024, 1024))
        
        XCTAssertEqual([region],
                       region.removing(verticalStrips: [],
                                       horizontalStrips: []))
    }
    
    func testMergingAdjacentVerticalStrips() {
        // Unordered and adjacent => not merged
        let r1 = MTLRegion((1, 2), (3, 4))
        let r2 = MTLRegion((-2, 2), (3, 4))
        XCTAssertEqual(r2.right, r1.left)
        XCTAssertEqual([r1, r2], [r1, r2].mergingAdjacentVerticalStrips)
        
        // Ordered and non adjacent => not merged
        let r3 = MTLRegion((1, 2), (3, 4))
        let r4 = MTLRegion((5, 2), (3, 4))
        XCTAssertNotEqual(r3.right, r4.left)
        XCTAssertEqual([r3, r4], [r3, r4].mergingAdjacentVerticalStrips)
        
        // Ordered and adjacent => merged
        let r5 = MTLRegion((1, 2), (3, 4))
        let r6 = MTLRegion((4, 2), (3, 4))
        XCTAssertEqual(r5.right, r6.left)
        XCTAssertEqual([r5.union(r6)], [r5, r6].mergingAdjacentVerticalStrips)
    }
    
    func testMergingAdjacentHorizontalStrips() {
        // Unordered and adjacent => not merged
        let r1 = MTLRegion((1, 2), (3, 4))
        let r2 = MTLRegion((1, -2), (3, 4))
        XCTAssertEqual(r2.top, r1.bottom)
        XCTAssertEqual([r1, r2], [r1, r2].mergingAdjacentHorizontalStrips)
        
        // Ordered and non adjacent => not merged
        let r3 = MTLRegion((1, 2), (3, 4))
        let r4 = MTLRegion((1, 7), (3, 4))
        XCTAssertNotEqual(r3.top, r4.bottom)
        XCTAssertEqual([r3, r4], [r3, r4].mergingAdjacentHorizontalStrips)
        
        // Ordered and adjacent => merged
        let r5 = MTLRegion((1, 2), (3, 4))
        let r6 = MTLRegion((1, 6), (3, 4))
        XCTAssertEqual(r5.top, r6.bottom)
        XCTAssertEqual([r5.union(r6)], [r5, r6].mergingAdjacentHorizontalStrips)
    }
}
