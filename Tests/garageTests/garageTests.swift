import XCTest
@testable import garage
@testable import interface
@testable import datetime

final class garageTests: XCTestCase {
    func testGarageName() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(garage().name, "garage")
    }

    func testInterfaceName() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(interface().name, "interface")
    }

    func testDateTimeName() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(datetime().name, "datetime")
    }
}
