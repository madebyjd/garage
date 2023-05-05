//
//  Version+Codable.swift
//
//
//  Created by Jonathan Danek on 5/4/23.
//

extension Version: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let s = try container.decode(String.self)
        let initializer: (String) -> Version?
        if decoder.userInfo[.decodingMethod] as? DecodingMethod == .tolerant {
            initializer = Version.init(tolerant:)
        } else {
            initializer = Version.init
        }
        guard let v = initializer(s) else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid semantic version")
        }
        self = v
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(description)
    }
}

public enum DecodingMethod {
    case strict
    case tolerant
}

public extension CodingUserInfoKey {
    static let decodingMethod = CodingUserInfoKey(rawValue: "dev.mxcl.Version.decodingMethod")!
}
