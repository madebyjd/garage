//
//  Emoji.swift
//

import Foundation

public class Emoji {

    static var listCache: [Emoji] = []

    var value: String
    var name: String

    public init(value: String, name: String) {
        self.value = value.trimmingCharacters(in: .whitespacesAndNewlines)
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
        guard listCache.count == 0 else {
            return listCache
        }

        let ranges = [
            0x1F600...0x1F64F, // Emoticons
            0x1F300...0x1F5FF, // Misc Symbols and Pictographs
            0x1F680...0x1F6FF, // Transport and Map
            0x2600...0x26FF,   // Misc symbols
            0x2700...0x27BF,   // Dingbats
            0xFE00...0xFE0F,   // Variation Selectors
            0x1F900...0x1F9FF // Supplemental Symbols and Pictographs
        ]

        let all = ranges.joined().map { codePoint -> String? in
            guard let scalarValue = Unicode.Scalar(codePoint) else {
                return nil
            }
            if scalarValue.properties.isEmoji {
                return String(Character(UnicodeScalar(codePoint)!))
            } else {
                return nil
            }
        }

        let allEmojis = all
            .compactMap { $0 }
            .map({ Emoji(value: $0, name: name(emoji: $0) ) })
            .filter { !$0.value.isEmpty }

        self.listCache = allEmojis

        return allEmojis
    }
}
