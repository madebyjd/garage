//
//  Fake+Text.swift
//
//
//  Created by Jonathan Danek on 5/4/23.
//

import Foundation

extension Fake.Text {

    public static func loremIpsumSentences(number: Int = 20) -> String {
        let listLoader = try? ListLoader(name: "lorem", type: "txt")
        return listLoader?.list
            .shuffled()
            .prefix(upTo: number)
            .chunked(into: 7)
            .map { chunk in
                var chunk = chunk.joined(separator: " ").capitalized
                chunk.append(".")
                return chunk
            }
            .joined(separator: " ") ?? ""
    }

    public static func loremIpsumHeadline(number: Int = 3) -> String {
        let listLoader = try? ListLoader(name: "lorem", type: "txt")
        return listLoader?.list
            .shuffled()
            .prefix(upTo: number)
            .map { word in
                return word.capitalized
            }
            .joined(separator: " ") ?? ""
    }
}
