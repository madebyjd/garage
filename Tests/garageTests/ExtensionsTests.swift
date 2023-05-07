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
                print(color)

                let isBright = color.isBright
                print(isBright)
                return isBright
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
