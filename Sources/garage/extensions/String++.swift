//
//  File.swift
//

import Foundation

extension String {
    func nsRange(from range: Range<String.Index>) -> NSRange {
        let utf16view = utf16
        let from = range.lowerBound.samePosition(in: utf16view) ?? startIndex
        let to = range.upperBound.samePosition(in: utf16view) ?? endIndex
        return NSRange(
            location: utf16view.distance(from: utf16view.startIndex, to: from),
            length: utf16view.distance(from: from, to: to)
        )
    }

    func range(from nsRange: NSRange) -> Range<String.Index>? {
        guard
            let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location, limitedBy: utf16.endIndex),
            let to16 = utf16.index(from16, offsetBy: nsRange.length, limitedBy: utf16.endIndex),
            let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self)
        else { return nil }
        return from ..< to
    }

    func firstMatch(_ regex: String) -> String? {
        allMatch(regex).first
    }

    func matches(_ regex: String) -> Bool {
        range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }

    func allMatch(_ regex: String) -> [String] {
        guard let regularExpression = try? NSRegularExpression(pattern: regex, options: .caseInsensitive)
        else { return [] }

        return regularExpression.matches(in: self, options: [], range: nsRange(from: startIndex ..< endIndex))
            .compactMap { self.range(from: $0.range) }
            .compactMap {
                let substring = String(self[$0])
                guard !substring.isEmpty else { return nil }
                return substring
            }
    }
}
