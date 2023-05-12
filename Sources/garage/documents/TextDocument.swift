//
//  TextDocument.swift
//  
//
//  Created by Jonathan Danek on 5/12/23.
//

import Foundation

public struct TextDocument: DocumentProtocol {

    public enum Kind: String, RawRepresentable {
        case text
        case bold
        case emoji
    }

    public var id = UUID().uuidString

    public var kind: Kind = .text

    public var content: String

    public var createdOn: Date

    public init(kind: TextDocument.Kind = .text, content: String) {
        self.kind = kind
        self.content = content
        self.createdOn = Date()
    }
}

extension TextDocument: Equatable, Hashable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(content, forKey: .content)
        try container.encode(kind.rawValue, forKey: .kind)
        try container.encode(createdOn, forKey: .createdOn)
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.content = try container.decodeIfPresent(String.self, forKey: .content) ?? ""

        let kindString = try container.decodeIfPresent(String.self, forKey: .kind)

        self.kind = Kind(rawValue: kindString ?? "") ?? kind
        self.createdOn = try container.decodeIfPresent(Date.self, forKey: .createdOn) ?? .now
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(kind)
        hasher.combine(content)
        hasher.combine(createdOn)
    }

    enum CodingKeys: String, CodingKey {
        case id
        case kind
        case content
        case createdOn
    }

    public static func == (lhs: TextDocument, rhs: TextDocument) -> Bool {
        lhs.id == rhs.id &&
        lhs.createdOn == rhs.createdOn &&
        lhs.kind == rhs.kind &&
        lhs.content == rhs.content
    }
}
