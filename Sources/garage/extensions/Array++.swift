//
//  File.swift
//
//
//  Created by Jonathan Danek on 5/4/23.
//

import Foundation

extension Array where Element: Equatable {

    @discardableResult
    public mutating func removeDuplicates() -> [Element] {
        self = reduce(into: [Element]()) {
            if !$0.contains($1) {
                $0.append($1)
            }
        }
        return self
    }
}
