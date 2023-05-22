//
//  File.swift
//
//
//  Created by Jonathan Danek on 5/4/23.
//

import Foundation

public class CSVLoader {

    var list: [String: [String]] = [:]

    var url: URL

    let delimiter = ","

    var headers: [String] = []

    init(name: String, type: String) throws {

        guard let url = Bundle.module.url(forResource: name, withExtension: type) else {
            throw ListLoaderError.invalidUrl
        }
        print(url)

        self.url = url

        try load()
    }

    public func load() throws {

        let content = try String(contentsOfFile: url.relativePath)

        var rawElements = content.components(separatedBy: "\n")
        let header = rawElements.removeFirst()
            .components(separatedBy: delimiter)
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }

        self.headers = header

        rawElements
            .map { line in
                line.components(separatedBy: delimiter)
                    .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            }
            .forEach { row in
                guard row.count == 2 else { return }
                self.list[row[0]] = row
            }
    }

    public func get(key: String, value: String) -> String {
        guard let index = headers.lastIndex(of: value) else { return "" }

        return self.list[key]?[index] ?? ""
    }

}
