import XCTest

@testable import garage

final class garageTests: XCTestCase {
    func testGarageName() throws {
        XCTAssertEqual(garage().name, "garage")
    }
}
