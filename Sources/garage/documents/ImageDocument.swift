//
//  File.swift
//  
//
//  Created by Jonathan Danek on 5/12/23.
//

import SwiftUI
import Foundation
#if os(iOS)
import UIKit
#else
import AppKit
#endif

public struct ImageDocument: DocumentProtocol {

    public var id = UUID().uuidString

    public var content: Data

    public var createdOn: Date

    public init(content: Data) {
        self.content = content
        self.createdOn = Date()
    }
}

extension ImageDocument {

    #if os(iOS)
    public var uiImage: UIImage? {
        UIImage(data: content)
    }
    #else
    public var nsImage: NSImage? {
        NSImage(data: content   )
    }
    #endif

    public var image: Image? {
    #if os(iOS)
        guard let uiImage = uiImage else { return nil }
        return Image(uiImage: uiImage)
    #else
        guard let nsImage = nsImage else { return nil }
        return Image(nsImage: nsImage)
    #endif
    }
}

extension ImageDocument: Equatable, Hashable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(content, forKey: .content)
        try container.encode(createdOn, forKey: .createdOn)
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.content = try container.decodeIfPresent(Data.self, forKey: .content) ?? Data()
        self.createdOn = try container.decodeIfPresent(Date.self, forKey: .createdOn) ?? .now
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(content)
        hasher.combine(createdOn)
    }

    enum CodingKeys: String, CodingKey {
        case id
        case content
        case createdOn
    }

    public static func == (lhs: ImageDocument, rhs: ImageDocument) -> Bool {
        lhs.id == rhs.id &&
        lhs.createdOn == rhs.createdOn &&
        lhs.content == rhs.content
    }
}
