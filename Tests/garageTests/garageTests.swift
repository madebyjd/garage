import XCTest
@testable import garage

final class garageTests: XCTestCase {
    func testName() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(garage().name, "garage")
    }
}
