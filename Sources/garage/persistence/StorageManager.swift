//
//  StorageManager.swift
//

import Foundation
import Semaphore


enum StorageManagerError: Error {
    case badUrl
}


public class StorageManager {

    public init() {

    }
    
    var semaphore = AsyncSemaphore(value: 1)

    var documentsDirectory: URL {
      Foundation.FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }

    func directory(for storable: Storable.Type) -> URL {
        documentsDirectory.appending(component: storable.name)
    }
}

extension StorageManager {

    // MARK: - Storable Persistence

    @MainActor
    public func p_getAll<Item: Storable>() async throws -> [Item] {
        let files = getFiles(in: directory(for: Item.self))
        var items: [Item] = []
        for file in files {
            let url = directory(for: Item.self).appending(path: file)
            let item: Item = try await self.p_fetch(url: url)
            items.append(item)
        }
        return items
    }

    @MainActor
    public func p_save<Item: Storable>(storable: Item) async throws {
        await semaphore.wait()
        defer { semaphore.signal() }
        let data = try JSONEncoder().encode(storable)
        let url = p_url(with: storable.id, for: directory(for: Item.self))
        AppLog.d(url.absoluteString)
        try data.write(to: url)
    }

    @MainActor
    public func p_fetch<Item: Storable>(id: String) async throws -> Item {
        let url = p_url(with: id, for: directory(for: Item.self))
        return try await p_fetch(url: url)
    }

    @MainActor
    public func p_fetch<Item: Storable>(url: URL) async throws -> Item {
        await semaphore.wait()
        defer { semaphore.signal() }
        let data = try Data(contentsOf: url)
        let object = try JSONDecoder().decode(Item.self, from: data)
        return object
    }

    @MainActor
    public func p_delete<Item: Storable>(item: Item) async throws {
        await semaphore.wait()
        defer { semaphore.signal() }
        let url = p_url(with: item.id, for: directory(for: Item.self))
        if FileManager.default.fileExists(atPath: url.relativePath) {
            try FileManager.default.removeItem(at: url)
        }
    }
    @MainActor
    public func p_delete<Item: Storable>(type: Item.Type) async throws {
        await semaphore.wait()
        defer { semaphore.signal() }
        let url = directory(for: type)
        if FileManager.default.fileExists(atPath: url.relativePath) {
            try FileManager.default.removeItem(at: url)
        }
    }

    func p_url(with id: String, for url: URL) -> URL {

        let fileUrl = url.appending(component: id).appendingPathExtension("json")

        if !FileManager.default.fileExists(atPath: url.relativePath) {
            try? FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
        }

        return fileUrl

    }

}


extension StorageManager {

    func getFiles(in directory: URL) -> [String] {
        let contents = try? FileManager().contentsOfDirectory(atPath: directory.relativePath)
        return (contents ?? []).filter { file in
            ![".DS_Store"].contains(file)
        }
    }
}

