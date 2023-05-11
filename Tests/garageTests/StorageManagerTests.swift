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

    func testSaveLoad() async throws {
        let day = Day.today.adding(months: -1)
        XCTAssertNotNil(day)
        try await sut.p_save(storable: day!)
        let response: Day = try await sut.p_fetch(id: day!.id)
        XCTAssertEqual(response, day)
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
