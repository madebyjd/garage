//
//  StorageManager++.swift
//  
//
//  Created by Jonathan Danek on 5/10/23.
//

import Foundation

extension StorageManager {

    // MARK: - Day Persistence

    public func getAll() async throws -> [Day] {
        try await p_getAll()
    }

    public func save(day: Day) async throws {
        try await p_save(storable: day)
    }

    public func fetch(day: Day) async throws -> Day {
        return try await p_fetch(id: day.id)
    }

    public func delete(day: Day) async throws {
        return try await p_delete(item: day)
    }

    public func deleteAllDays() async throws {
        return try await p_delete(type: Day.self)
    }
}
