//
//  StorageManagerTests.swift
//

import XCTest
@testable import garage

final class StorageManagerTests: XCTestCase {

    let sut = StorageManager()


    override class func setUp() {
        super.setUp()

        AppLog.setup()
    }

    func testDaySaveLoadDelete() async throws {
        let day = Day.today.adding(months: -1)
        XCTAssertNotNil(day)
        try await sut.save(day: day!)
        let response: Day = try await sut.fetch(day: day!)
        XCTAssertEqual(response, day)
        try await sut.delete(day: day!)
        let deletedResponse = try? await sut.fetch(day: day!)
        XCTAssertNil(deletedResponse)
    }

    func testDayHighVolume() async throws {
        try await sut.deleteAllDays()

        for i in 1...500 {
            let day = Day.today.adding(months: -1 * i)
            try await sut.save(day: day!)
        }

        let days: [Day] = try await sut.getAll()
        XCTAssertEqual(days.count, 500)
    }


    func testTextDocumentSaveLoadDelete() async throws {
        let doc = TextDocument(kind: .text, content: "this is a test")
        try await sut.p_save(storable: doc)
        let response: TextDocument = try await sut.p_fetch(id: doc.id)
        XCTAssertEqual(response, doc)
        try await sut.p_delete(item: doc)
        let deletedResponse: TextDocument? = try? await sut.p_fetch(id: response.id)
        XCTAssertNil(deletedResponse)
    }

    func testImageDocumentSaveLoadDelete() async throws {

        let url = Bundle.module.url(forResource: "test", withExtension: "png")!
        let data = try! Data(contentsOf: url)

        let doc = ImageDocument(content: data)
        try await sut.p_save(storable: doc)
        let response: ImageDocument = try await sut.p_fetch(id: doc.id)
        XCTAssertEqual(response, doc)
        try await sut.p_delete(item: doc)
        let deletedResponse: ImageDocument? = try? await sut.p_fetch(id: response.id)
        XCTAssertNil(deletedResponse)
    }

    func testImageDocument() async throws {
        let url = Bundle.module.url(forResource: "test", withExtension: "png")!
        let data = try! Data(contentsOf: url)

        let doc = ImageDocument(content: data)
        try await sut.p_save(storable: doc)
        let response: ImageDocument = try await sut.p_fetch(id: doc.id)
        XCTAssertNotNil(response.image)
        try await sut.p_delete(item: doc)
        let deletedResponse: ImageDocument? = try? await sut.p_fetch(id: response.id)
        XCTAssertNil(deletedResponse)
    }
}
