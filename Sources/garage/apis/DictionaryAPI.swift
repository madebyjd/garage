//
//  DictionaryAPI.swift
//  
//
//  Created by Jonathan Danek on 5/10/23.
//

import Foundation
import Combine

public class DictionaryAPI: API {

    public var urlSesssion: URLSession

    public var baseUrl: URL

    public init(urlSesssion: URLSession = .shared) {
        self.urlSesssion = urlSesssion
        self.baseUrl = URL(string: "https://api.dictionaryapi.dev/api/v2")!
    }

    public func fetchEntry(for word: String) -> AnyPublisher<DictionaryEntry?, Error> {
        let url = baseUrl.appending(path: "entries/en").appending(path: word)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        return self.urlSesssion.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: [DictionaryEntry].self, decoder: JSONDecoder())
            .map(\.first)
            .eraseToAnyPublisher()
    }
}
