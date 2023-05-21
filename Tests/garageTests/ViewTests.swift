//
//  ViewTests.swift
//

import XCTest
import SwiftUI
import ViewInspector
@testable import garage

final class ViewTests: XCTestCase {

    func testDayView() throws {

        let sut = DayView {
            EmptyView()
        }

        let text = try sut.inspect().find(text: "\(Day.today.day)").string()
        XCTAssert(!text.isEmpty)
    }

    func testOverviewView() throws {

        let model = OverviewViewModel(symbol: "hare.fill", title: "title", subtitle: "subtitle", description: "just some description", details: ["key" : "value"])
        let sut = OverviewView(model: model)

        let text = try sut.inspect().find(text: "title").string()
        XCTAssert(!text.isEmpty)
    }

    func testTagsView() throws {

        let sut = TagsView(tags: [Tag(title: "test1"), Tag(title: "test2")])

        let text = try sut.inspect().find(text: "test1").string()
        XCTAssert(!text.isEmpty)
    }

    func testEmojiPicker() throws {

        let sut = EmojiPicker()

        let text = try sut.inspect().find(text: "Search").string()
        XCTAssert(!text.isEmpty)
    }

    func testKeyValueView() throws {

        let sut = KeyValueView(key: "key", value: "value")

        let text = try sut.inspect().find(text: "value").string()
        XCTAssert(!text.isEmpty)
    }

    func testTextDocumentView() throws {

        let model = TextDocument(kind: .text, content: "test")
        let sut = TextDocumentDetailView(document: model)

        let text = try sut.inspect().find(text: "test").string()
        XCTAssert(!text.isEmpty)
    }

    func testImageDocumentView() throws {
        let url = Bundle.module.url(forResource: "test", withExtension: "png")!
        let data = try! Data(contentsOf: url)
        let model = ImageDocument(content: data)
        let sut = ImageDocumentDetailView(document: model)

        let image = try? sut.inspect().image().actualImage()
        XCTAssertNotNil(image)
    }

    func testRoundedTextFieldStyle() throws {
        let sut = TextField("test", text: .constant(""))
            .textFieldStyle(RoundedTextFieldStyle(active: false))
        let text = try sut.inspect().find(text: "test").string()
        XCTAssert(!text.isEmpty)
    }
}
