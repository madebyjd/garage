//
//  EmojiTests.swift
//

import XCTest
@testable import garage

final class EmojiTests: XCTestCase {

    override class func setUp() {
        super.setUp()

        AppLog.setup()
    }

    func testEmojiList() {

        let emojis = Emoji.list()
        var set = Set<Emoji>()
        for emoji in emojis {
            XCTAssertTrue(emoji.name.count > 0)
            XCTAssertTrue(emoji.value.count > 0)
            XCTAssertFalse(set.contains(emoji))
            set.insert(emoji)
        }

        XCTAssert(emojis.count > 500)
    }

}
