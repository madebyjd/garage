//
//  Emoji.swift
//  
//
//  Created by Jonathan Danek on 5/11/23.
//

import Foundation

public class Emoji {

    var value: String
    var name: String

    public init(value: String, name: String) {
        self.value = value
        self.name = name
    }
}

extension Emoji: Hashable {
    public static func == (lhs: Emoji, rhs: Emoji) -> Bool {
        lhs.value == rhs.value &&
            lhs.name == rhs.name
    }


    public func hash(into hasher: inout Hasher) {
        hasher.combine(value)
        hasher.combine(name)
    }
}

extension Emoji {
    public static func name(emoji: String) -> String {
      let string = NSMutableString(string: String(emoji))
      var range = CFRangeMake(0, CFStringGetLength(string))
      CFStringTransform(string, &range, kCFStringTransformToUnicodeName, false)

        return string.trimmingCharacters(in: .whitespacesAndNewlines)
        .components(separatedBy: "\\N")
        .joined(separator: "")
        .replacingOccurrences(of: "{", with: "")
        .replacingOccurrences(of: "}", with: "")
    }

    public static func list() -> [Emoji] {
      let ranges = [
        0x1F601...0x1F64F,
        0x2600...0x27B0,
        0x23F0...0x23FA,
        0x1F680...0x1F6C0,
        0x1F170...0x1F251
      ]

      var all = ranges.joined().map {
        return String(Character(UnicodeScalar($0)!))
      }

      let solos = [0x231A, 0x231B, 0x2328, 0x2B50]
      all.append(contentsOf: solos.map({ String(Character(UnicodeScalar($0)!))}))

        return all.map({ Emoji(value: $0, name: name(emoji: $0) ) })
    }
}
