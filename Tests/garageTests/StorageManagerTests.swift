//
//  StorageManagerTests.swift
//  
//
//  Created by Jonathan Danek on 5/10/23.
//

import XCTest
@testable import garage

final class StorageManagerTests: XCTestCase {

    let sut = StorageManager()

    func testSaveLoadDelete() async throws {
        let day = Day.today.adding(months: -1)
        XCTAssertNotNil(day)
        try await sut.save(day: day!)
        let response: Day = try await sut.fetch(day: day!)
        XCTAssertEqual(response, day)
        try await sut.delete(day: day!)
        let deletedResponse = try? await sut.fetch(day: day!)
        XCTAssertNil(deletedResponse)
    }

    func testHighVolume() async throws {
        try await sut.deleteAllDays()

        for i in 1...500 {
            let day = Day.today.adding(months: -1 * i)
            try await sut.save(day: day!)
        }

        let days: [Day] = try await sut.getAll()
        XCTAssertEqual(days.count, 500)
    }
}
