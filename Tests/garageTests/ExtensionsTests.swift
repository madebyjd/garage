//
//  ExtensionsTests.swift
//  
//
//  Created by Jonathan Danek on 5/5/23.
//

import XCTest
import SwiftUI
@testable import garage

final class ExtensionsTests: XCTestCase {

}

// MARK: - NSimage

#if os(macOS)
extension ExtensionsTests {

    func testPngData() throws {
        let url = Bundle.module.url(forResource: "test", withExtension: "png")!
        let data = try! Data(contentsOf: url)
        let sut = NSImage(data: data)
        let pngData = sut?.pngData()
        XCTAssertNotNil(pngData)
    }
}
#endif

// MARK: - String

extension ExtensionsTests {

    func testRegexMatches() {
        let sut = "123test456"
        let regex = "[0-9]+[a-zA-Z]+[0-9]+"
        let didMatch = sut.matches(regex)
        let firstMatch = sut.firstMatch(regex)
        XCTAssertTrue(didMatch)
        XCTAssertEqual(sut, firstMatch)
    }
}

// MARK: - Array

extension ExtensionsTests {

    func testRemoveDuplicates() {
        var sut = [
            "1",
            "2",
            "3",
            "4",
            "1"
        ]
        let initialCount = sut.count
        sut.removeDuplicates()
        XCTAssertNotEqual(sut.count, initialCount)
    }

    func testChunked() {
        let sut = [
            "1",
            "2",
            "3",
            "4",
            "1"
        ]
        let initialCount = sut.chunked(into: 2)
        XCTAssertEqual(initialCount[0].count, 2)
        XCTAssertEqual(initialCount[1].count, 2)
        XCTAssertEqual(initialCount[2].count, 1)
    }
}

// MARK: - Color

extension ExtensionsTests {

    func testColors() {
        let sut = Color.all
        let randomSut = Color.random
        XCTAssert(sut.count > 0)
        XCTAssertNotEqual(randomSut, .white)
    }

    func testSystemsColors() {
        let sut = Color.allSystem
        let randomSut = Color.randomSystem
        XCTAssert(sut.count > 0)
        XCTAssertNotEqual(randomSut, .white)
    }

    func testIsBrightColors() {
        let brightSut: [Color] = [.white, .appOrange, .appYellow]
        let darkSut: [Color] = [.brown, .black, .appPurple]
        XCTAssertEqual(
            brightSut.map { color in
                color.isBright
            }.allSatisfy { isBright in
                    isBright
                },
            true
        )
        XCTAssertEqual(
            darkSut.map(\.isBright)
                .allSatisfy { isBright in
                    !isBright
                },
            true
        )
    }
}

// MARK: - URL

extension ExtensionsTests {

    func testDocumentURL() {
        let sut = URL.documents
        XCTAssert(FileManager.default.fileExists(atPath: sut.relativePath))
    }

    func testDeletingPathComponents() {
        var sut = URL(string: "https://github.com/jdanek4/garage")
        XCTAssertNotNil(sut)
        let baseSut = sut!.deletingAllPathComponents()
        XCTAssertEqual(baseSut.absoluteString, "https://github.com/")
        sut?.deleteAllPathComponents()
        XCTAssertEqual(sut!.absoluteString, "https://github.com/")
    }
}
