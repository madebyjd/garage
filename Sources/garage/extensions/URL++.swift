//
//  URL++.swift
//
//
//  Created by Jonathan Danek on 5/4/23.
//

import Foundation

extension URL {

    public static var documents: URL {
        return FileManager
            .default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
    }

    public func deletingAllPathComponents() -> URL {
        guard !pathComponents.isEmpty else { return self }

        var url: URL = self
        for _ in 0..<pathComponents.count - 1 {
            url.deleteLastPathComponent()
        }
        return url
    }

    public mutating func deleteAllPathComponents() {
        guard !pathComponents.isEmpty else { return }

        for _ in 0..<pathComponents.count - 1 {
            deleteLastPathComponent()
        }
    }
}
