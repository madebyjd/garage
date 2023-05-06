//
//  File.swift
//
//
//  Created by Jonathan Danek on 5/4/23.
//

import Foundation

enum ListLoaderError: Error {
    case invalidUrl
}

class ListLoader {

    var list: [String] = []

    var url: URL

    init(name: String, type: String) throws {

        guard let url = Bundle.module.url(forResource: name, withExtension: type) else {
            throw ListLoaderError.invalidUrl
        }
        print(url)

        self.url = url

        try load()
    }

    func load() throws {

        let content = try String(contentsOfFile: url.relativePath)

        let rawElements = content.components(separatedBy: "\n")

        list =
            rawElements
            .map { element in
                element.trimmingCharacters(in: .whitespacesAndNewlines)
            }
            .filter { element in
                !element.isEmpty
            }
    }
}
