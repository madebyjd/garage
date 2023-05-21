//
//  DictionaryEntry.swift
//

import Foundation

public struct DictionaryEntry: Codable {
    public let word: String
    public let meanings: [Meaning]
}

public struct Meaning: Codable {
    public let partOfSpeech: String
    public let definitions: [Definition]
    public let synonyms, antonyms: [String]
}

public struct Definition: Codable {
    public let definition: String
    public let example: String?
}
