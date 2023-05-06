//
//  File.swift
//
//
//  Created by Jonathan Danek on 5/4/23.
//

import XCTest

@testable import garage

class FakerTests: XCTestCase {
    func testRandomInRange() {

        XCTAssertNotEqual(0, Fake.Number.random(in: 1..<2))
        XCTAssertTrue(Fake.Number.random(in: 1_000..<10_000) > 1_000)
        XCTAssertTrue(Fake.Number.random(in: 1_000..<10_000) < 10_000)
    }

    func testRandomDecimalInRange() {

        XCTAssertTrue(Fake.Number.randomDecimal() > 0)
        XCTAssertTrue(Fake.Number.randomDecimal() < 10)
        XCTAssertTrue(Fake.Number.randomDecimal(in: -10.0..<0.0) < 0.0)
        XCTAssertTrue(Fake.Number.randomDecimal(in: 1_000..<10_000) > 1_000)
    }

    func testRandomMinMax() {

        XCTAssertNotEqual(0, Fake.Number.random(min: 1, max: 2))
        XCTAssertTrue(Fake.Number.random(min: 1_000, max: 10_000) > 1_000)
        XCTAssertTrue(Fake.Number.random(min: 1_000, max: 10_000) < 10_000)
    }

    func testRandomDecimalMinMax() {

        XCTAssertTrue(Fake.Number.random(min: 1.0, max: 2.0) > 0)
        XCTAssertTrue(Fake.Number.random(min: 1.0, max: 10.0) < 10)
        XCTAssertTrue(Fake.Number.random(min: -10.0, max: 0.0) < 0.0)
        XCTAssertTrue(Fake.Number.random(min: 1_000.0, max: 2_000.0) > 1_000)
    }

    func testListLoader() throws {

        let firstNameLoader = try ListLoader(name: "first-names", type: "txt")
        XCTAssertGreaterThan(firstNameLoader.list.count, 0)
        let lastNameLoader = try ListLoader(name: "last-names", type: "txt")
        XCTAssertGreaterThan(lastNameLoader.list.count, 0)
        XCTAssertTrue(!lastNameLoader.list.contains(""))
        XCTAssertTrue(!firstNameLoader.list.contains(""))
    }

    func testPerson() throws {

        let firstName = Fake.Person.randomFirstName()
        XCTAssert(!firstName.isEmpty)

        let lastName = Fake.Person.randomLastName()
        XCTAssert(!lastName.isEmpty)
    }

    func testPersonName() throws {
        let name = Fake.Person.randomName()
        XCTAssertEqual(name.components(separatedBy: " ").count, 2)
        XCTAssert(name.count > 0)
    }

    func testPersonAge() throws {
        let name = Fake.Person.randomAge()
        XCTAssert(name > 0)
        XCTAssert(name < 200)
    }

    func testDate() throws {

        let date = Fake.Object.randomDate()
        XCTAssertTrue(date < Date())
        let date2 = Fake.Object.randomDate(
            start: Date(timeIntervalSince1970: TimeInterval(0.0)))
        XCTAssertTrue(date2 < Date())
    }

    func testRandomAddress() throws {
        let address = Fake.Person.randomAddress()

        XCTAssert(address.components(separatedBy: " ").count >= 2)
    }

    func testLoremIpsum() throws {
        let length = 20
        let lorem = Fake.Text.loremIpsumSentences(number: length)
        let words = lorem.components(separatedBy: " ").count
        XCTAssert(words == length)
    }

    func testLoremIpsumHuge() throws {
        let length = 200
        let lorem = Fake.Text.loremIpsumSentences(number: length)
        let words = lorem.components(separatedBy: " ").count
        XCTAssert(words == length)
    }

    func testLoremIpsumHeadline() throws {
        let length = 5
        let lorem = Fake.Text.loremIpsumHeadline(number: length)
        let words = lorem.components(separatedBy: " ").count
        XCTAssert(words == length)

    }

    func testCountries() throws {
        let country = Fake.Person.randomCountry()
        XCTAssert(country.1.count == 3)
        XCTAssert(!country.0.isEmpty)

    }
}
