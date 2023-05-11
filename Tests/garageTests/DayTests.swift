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

    func testDayNameOfMonth() {
        let sut = Day(month: 1, day: 1, year: 2023)
        let short = sut.nameOfMonth(style: .short)
        let medium = sut.nameOfMonth(style: .medium)
        let full = sut.nameOfMonth(style: .full)
        XCTAssertEqual(short, "J")
        XCTAssertEqual(medium, "Jan")
        XCTAssertEqual(full, "January")
    }

    func testDayComplex() {
        let sut = Day(date: .now)
        let future = sut.adding(months: 6, days: 14, years: 2)!
        let difference = sut.difference(to: future)
        XCTAssert(difference.isClose(to: 924, buffer: 10))
    }

    func testDayToFuture() {
        let sut = Day(month: 01, day: 01, year: 2023)
        let futureSut = sut.adding(days: 48)
        XCTAssertNotNil(futureSut)
        let days = sut.daysTo(day: futureSut!)
        XCTAssertEqual(days.count, 50)
        XCTAssert(days.contains(sut))
        XCTAssert(days.contains(futureSut!))
    }

    func testDateExtensions() {
        let sut = Date(timeIntervalSinceReferenceDate: TimeInterval(699921248.705154))
        XCTAssertEqual(sut.day, 7)
        XCTAssertEqual(sut.year, 2023)
        XCTAssertEqual(sut.month, 3)
        XCTAssertEqual(sut.dayName, "Tuesday")
    }

    func testMondayDayOfWeek() {
        let date = Date(timeIntervalSinceReferenceDate: TimeInterval(699821248.705154))
        let sut = Day(date: date)
        XCTAssertEqual(sut.dayOfWeek(style: .short), "M")
        XCTAssertEqual(sut.dayOfWeek(style: .medium), "Mon")
        XCTAssertEqual(sut.dayOfWeek(style: .full), "Monday")
    }

    func testTuesdayDayOfWeek() {
        let date = Date(timeIntervalSinceReferenceDate: TimeInterval(699921248.705154))
        let sut = Day(date: date)
        XCTAssertEqual(sut.dayOfWeek(style: .short), "T")
        XCTAssertEqual(sut.dayOfWeek(style: .medium), "Tue")
        XCTAssertEqual(sut.dayOfWeek(style: .full), "Tuesday")
    }
}
