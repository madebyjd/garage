//
//  VersionTests.swift
//
//
//  Created by Jonathan Danek on 5/4/23.
//

import XCTest

@testable import garage

final class VersionTests: XCTestCase {

    func testBasicProperties() {
        let major = 2
        let minor = 3
        let patch = 4
        let sut = Version(major, minor, patch)
        XCTAssertEqual(sut.major, major)
        XCTAssertEqual(sut.minor, minor)
        XCTAssertEqual(sut.patch, patch)
    }

    func testStringInit() {
        let major = 2
        let minor = 3
        let patch = 4
        let string = "\(major).\(minor).\(patch)"
        let sut = Version(string)
        XCTAssertNotNil(sut)
        XCTAssertEqual(sut!.major, major)
        XCTAssertEqual(sut!.minor, minor)
        XCTAssertEqual(sut!.patch, patch)
    }

    func testDecodeEncode() throws {
        let major = 2
        let minor = 3
        let patch = 4
        let version = Version(major, minor, patch)
        let encoded = try JSONEncoder().encode(version)
        let sut = try JSONDecoder().decode(Version.self, from: encoded)
        XCTAssertEqual(sut.major, major)
        XCTAssertEqual(sut.minor, minor)
        XCTAssertEqual(sut.patch, patch)
    }

    func testComparables() {
        let versionA = Version(1, 2, 3)
        let versionB = Version(2, 3, 4)
        XCTAssert(versionA != versionB)
        XCTAssert(versionA <= versionB)
        XCTAssert(versionA < versionB)
        XCTAssert(versionA == versionA)
    }

    func testPrereleaseComparables() {
        let zero = Version(0, 0, 0, pre: ["beta"])
        let sut = Version(0, 0, 0, pre: ["beta.2"])
        XCTAssert(zero < sut)
    }

    func testBundleVersion() {
        let zero = Version(0, 0, 0)
        let sut = Bundle.main.version
        XCTAssert(zero < sut)
    }

    func testOSVersion() {
        let zero = Version(0, 0, 0)
        let sut = ProcessInfo.processInfo.osVersion
        XCTAssert(zero < sut)
    }

    func testVersionHash() {
        let zero = Version(0, 0, 0)
        let minor = Version(0, 0, 1)
        XCTAssertNotEqual(zero.hashValue, minor.hashValue)
    }

    func testUncheckedRangeContains() {
        let versionA = Version(1, 2, 3)
        let versionB = Version(2, 3, 4)
        let versionC = Version(1, 5, 0)
        let versionD = Version(2, 5, 0)
        let sut = Range(uncheckedBounds: (versionA, versionB))
        let sut2 = ClosedRange(uncheckedBounds: (versionA, versionB))
        XCTAssert(sut.contains(versionC))
        XCTAssertFalse(sut.contains(versionD))
        XCTAssert(sut2.contains(versionC))
        XCTAssertFalse(sut2.contains(versionD))
    }

    func testRangeContains() {
        let versionA = Version(1, 2, 3, pre: ["1"])
        let versionB = Version(2, 3, 4, pre: ["1"])
        let versionC = Version(1, 5, 0, pre: ["1"])
        let versionD = Version(2, 5, 0)
        let sut = versionA..<versionB
        XCTAssert(sut.contains(versionC))
        XCTAssertFalse(sut.contains(versionD))
    }
}
