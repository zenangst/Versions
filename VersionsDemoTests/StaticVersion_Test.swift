//
//  StaticVersion_Test.swift
//  Versions
//
//  Created by Konstantin Koval on 11/03/15.
//
//

import UIKit
import XCTest
import Version

class StaticVersion_Test: XCTestCase {

  func testVersionStructInit() {

    let v = Version("1.2.3")
    let wrongV = Version("1.A.3")
    XCTAssertTrue(v != nil)
    XCTAssertTrue(wrongV == nil)
  }

  func testVersionStruct() {

    if let v = Version("1.2.3") {
      XCTAssertEqual(v.major, 1)
      XCTAssertEqual(v.minor, 2)
      XCTAssertEqual(v.patch, 3)
    }
  }

  func testCompare() {

    let v = Version("1.2.3")
    let v2 = Version("1.2.4")
    let vSame = Version("1.2.3")

    XCTAssertFalse(v == v2)
    XCTAssertFalse(v > vSame)
    XCTAssertFalse(v < vSame)

    XCTAssertTrue(v == vSame)
    XCTAssertTrue(v < v2)
    XCTAssertTrue(v2 > v)
  }
}
