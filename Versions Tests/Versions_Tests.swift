//
//  Versions_Tests.swift
//  Versions Tests
//
//  Created by Christoffer Winterkvist on 3/2/15.
//
//

import UIKit
import XCTest

class Versions_Tests: XCTestCase {
    
    func testNumericNewerThan() {
        XCTAssertTrue("1.0".newerThan("0.9"))
    }
    
    func testAlphabeticVersion() {
        XCTAssertTrue("B".newerThan("A"))
    }
    
    func testVerboseVersion() {
        XCTAssertTrue("1.1.3b".newerThan("1.0.1a"))
    }
    
    func testMajorVerboseVersion() {
        XCTAssertTrue("2.1".newerThan("1.0.0"))
    }
    
    func testFaultyVersion()
    {
        XCTAssertFalse("0.9".newerThan("1.0.0"))
    }
    
    func testSameVersion()
    {
        XCTAssertFalse("1.0".newerThan("1.0"))
    }
    
    func testEmptyVersionString()
    {
        XCTAssertTrue("1.0".newerThan(""))
        XCTAssertFalse("".newerThan("1.0"))
    }
    
}
