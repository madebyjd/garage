//
//  APITests.swift
//

import XCTest
import Combine
@testable import garage

final class APITests: XCTestCase {

    var pipelines = Set<AnyCancellable>()

    override class func setUp() {
        super.setUp()

        AppLog.setup()
    }

}

extension APITests {

    // MARK: - DictionaryAPI Tests

    func testDictionaryAPI() {
        let words = [
            "test",
            "notepad",
            "computer",
            "apartment"
        ]
        for word in words {
            self.fetchDictionaryEntry(word: word)
        }
    }

    func fetchDictionaryEntry(word: String) {
        let dictionaryApi = DictionaryAPI()

        let expectation = expectation(description: "Fetch dictionary entry")
        var response: DictionaryEntry?

        dictionaryApi.fetchEntry(for: word)
            .sink { result in
                switch result {
                case .finished:
                    return
                case .failure(let error):
                    AppLog.e(error.localizedDescription)
                }
            } receiveValue: { dictionaryEntry in
                response = dictionaryEntry
                expectation.fulfill()
            }
            .store(in: &pipelines)

        wait(for: [expectation], timeout: 10.0)
        XCTAssertNotNil(response)
        XCTAssert(response!.word == word)
        XCTAssertTrue(response!.meanings.count > 0)

    }
}
