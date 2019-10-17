//
//  Versions_Tests.swift
//  Versions Tests
//
//  Created by Christoffer Winterkvist on 3/2/15.
//
//

import UIKit
import XCTest
import Version

class Versions_Tests: XCTestCase {

  func testNumericNewerThan() {
    XCTAssertTrue("1.0".newerThan(version: "0.9"))
  }

  func testAlphabeticVersion() {
    XCTAssertTrue("B".newerThan(version: "A"))
  }

  func testVerboseVersion() {
    XCTAssertTrue("1.1.3b".newerThan(version: "1.0.1a"))
  }

  func testMajorVerboseVersion() {
    XCTAssertTrue("2.1".newerThan(version: "1.0.0"))
  }

  func testFaultyVersion()
  {
    XCTAssertFalse("0.9".newerThan(version: "1.0.0"))
  }

  func testSameVersion()
  {
    XCTAssertFalse("1.0".newerThan(version: "1.0"))
  }

  func testMultiDigitMinorVersion() {
    XCTAssertTrue("1.9.3".olderThan(version: "1.9.10"))
    XCTAssertTrue("1.9.10".newerThan(version: "1.9.3"))
  }

  func testEmptyVersionString()
  {
    XCTAssertTrue("1.0".newerThan(version: ""))
    XCTAssertFalse("".newerThan(version: "1.0"))
  }

  func testSymanticVersioning() {
    XCTAssertEqual(.same, "1.0".semanticCompare(version: "1.0"))
    XCTAssertEqual(.major, "1.0".semanticCompare(version: "2.0"))
    XCTAssertEqual(.minor, "1.2".semanticCompare(version: "1.3"))
    //FIXME: Crash XCTAssertEqual(Semantic.Minor, "1.3".semanticCompare("1.2"))

    XCTAssertEqual(.patch, "1.2.1".semanticCompare(version: "1.2.2"))
  }

  func testMajorChange() {
    XCTAssertTrue("1.0".majorChange(version: "2.0"))
    XCTAssertFalse("1.0".majorChange(version: "1.1"))
  }

  func testMinorChange() {
    XCTAssertTrue("1.0".minorChange(version: "1.1"))
    XCTAssertFalse("1.1".minorChange(version: "1.0.1"))
  }
  func testPatchChange() {
    XCTAssertTrue("1.1.0".patchChange(version: "1.1.1"))
    XCTAssertFalse("1.1.1".patchChange(version: "1.1.1"))
  }
}
