//
//  EmojiTests.swift
//  
//
//  Created by Jonathan Danek on 5/11/23.
//

import XCTest
@testable import garage

final class EmojiTests: XCTestCase {

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
