//
//  APITests.swift
//  
//
//  Created by Jonathan Danek on 5/10/23.
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

    func testDictionaryAPI() {
        let word = "test"
        let dictionaryApi = DictionaryAPI()

        let expectation = expectation(description: "Fetch dictionary entry")
        var response: DictionaryEntry?

        dictionaryApi.fetchEntry(for: word)
            .sink { result in
                print(result)
                switch result {
                case .finished:
                    return
                case .failure(let error):
                    AppLog.e(error.localizedDescription)
                }
            } receiveValue: { dictionaryEntry in
                guard let dictionaryEntry = dictionaryEntry else { return }
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
