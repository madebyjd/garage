//
//  DateTests.swift
//  
//
//  Created by Jonathan Danek on 5/3/23.
//

import XCTest
@testable import garage

final class DateTests: XCTestCase {

    func testDayComponents() {
        let sut = Day(date: Date(timeIntervalSinceReferenceDate: TimeInterval(699921248.705154)))
        XCTAssertEqual(sut.day, 7)
        XCTAssertEqual(sut.year, 2023)
        XCTAssertEqual(sut.month, 3)
    }

    func testDayAppending() {
        let sut = Day(date: .now)
        let futureMonth = sut.adding(months: 1)!
        let futureMonthDifference = sut.difference(to: futureMonth)
        let futureDay = sut.adding(days: 1)!
        let futureDayDifference = sut.difference(to: futureDay)
        let futureYear = sut.adding(years: 1)!
        let futureYearDifference = sut.difference(to: futureYear)


        XCTAssert(futureMonthDifference.isClose(to: 30))
        XCTAssert(futureDayDifference == 1)
        XCTAssert(futureYearDifference.isClose(to: 365))
    }

    func testDayComplex() {
        let sut = Day(date: .now)
        let future = sut.adding(months: 6, days: 14, years: 2)!
        let difference = sut.difference(to: future)
        XCTAssert(difference.isClose(to: 924, buffer: 10))
    }

    func testDateExtensions() {
        let sut = Date(timeIntervalSinceReferenceDate: TimeInterval(699921248.705154))
        XCTAssertEqual(sut.day, 7)
        XCTAssertEqual(sut.year, 2023)
        XCTAssertEqual(sut.month, 3)
        XCTAssertEqual(sut.dayName, "Tuesday")
    }
}
