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

  func testSymanticVersioning() {
    XCTAssertEqual(Semantic.Same, "1.0".semanticCompare("1.0"))
    XCTAssertEqual(Semantic.Major, "1.0".semanticCompare("2.0"))
    XCTAssertEqual(Semantic.Minor, "1.2".semanticCompare("1.3"))
    //FIXME: Crash XCTAssertEqual(Semantic.Minor, "1.3".semanticCompare("1.2"))

    XCTAssertEqual(Semantic.Patch, "1.2.1".semanticCompare("1.2.2"))
  }

  func testMajorChange() {
    XCTAssertTrue("1.0".majorChange("2.0"))
    XCTAssertFalse("1.0".majorChange("1.1"))
  }

  func testMinorChange() {
    XCTAssertTrue("1.0".minorChange("1.1"))
    XCTAssertFalse("1.1".minorChange("1.0.1"))
  }
  func testPatchChange() {
    XCTAssertTrue("1.1.0".patchChange("1.1.1"))
    XCTAssertFalse("1.1.1".patchChange("1.1.1"))
  }
}
