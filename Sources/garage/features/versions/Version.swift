//
//  Version.swift
//
//
//  Created by Jonathan Danek on 5/4/23.
//

public struct Version {

    public let major: Int

    public let minor: Int

    public let patch: Int

    public let prereleaseIdentifiers: [String]

    public let buildMetadataIdentifiers: [String]

    @inlinable
    public init(_ major: Int, _ minor: Int, _ patch: Int, pre: [String] = [], build: [String] = [])
    {
        self.major = abs(major)
        self.minor = abs(minor)
        self.patch = abs(patch)
        self.prereleaseIdentifiers = pre
        self.buildMetadataIdentifiers = build

        if major < 0 || minor < 0 || patch < 0 {
            print("warning: negative component in version: \(major).\(minor).\(patch)")
            print("notice: negative components were abs’d")
        }
    }

    @inlinable
    public init(
        major: Int, minor: Int, patch: Int, prereleaseIdentifiers: [String] = [],
        buildMetadataIdentifiers: [String] = []
    ) {
        self.init(major, minor, patch, pre: prereleaseIdentifiers, build: buildMetadataIdentifiers)
    }

    public static let null = Version(0, 0, 0)
}

extension Version: LosslessStringConvertible {

    public init?(_ string: String) {
        #if compiler(>=5)
            self.init(internal: string)
        #else

            let prereleaseStartIndex = string.firstIndex(of: "-")
            let metadataStartIndex = string.firstIndex(of: "+")

            let requiredEndIndex = prereleaseStartIndex ?? metadataStartIndex ?? string.endIndex
            let requiredCharacters = string.prefix(upTo: requiredEndIndex)
            let requiredComponents =
                requiredCharacters
                .split(separator: ".", maxSplits: 2, omittingEmptySubsequences: false)
                .compactMap({ Int($0) })

            guard requiredComponents.count == 3 else { return nil }

            self.major = requiredComponents[0]
            self.minor = requiredComponents[1]
            self.patch = requiredComponents[2]

            func identifiers(start: String.Index?, end: String.Index) -> [String] {
                guard let start = start else { return [] }
                let identifiers = string[string.index(after: start)..<end]
                return identifiers.split(separator: ".").map(String.init(_:))
            }

            self.prereleaseIdentifiers = identifiers(
                start: prereleaseStartIndex,
                end: metadataStartIndex ?? string.endIndex)
            self.buildMetadataIdentifiers = identifiers(
                start: metadataStartIndex,
                end: string.endIndex)
        #endif
    }

    #if compiler(>=5)
        public init?<S: StringProtocol>(_ string: S) {
            self.init(internal: string)
        }

        private init?<S: StringProtocol>(internal string: S) {

            let prereleaseStartIndex = string.firstIndex(of: "-")
            let metadataStartIndex = string.firstIndex(of: "+")

            let requiredEndIndex = prereleaseStartIndex ?? metadataStartIndex ?? string.endIndex
            let requiredCharacters = string.prefix(upTo: requiredEndIndex)
            let requiredComponents =
                requiredCharacters
                .split(separator: ".", maxSplits: 2, omittingEmptySubsequences: false)
                .compactMap({ Int($0) })

            guard requiredComponents.count == 3 else { return nil }

            self.major = requiredComponents[0]
            self.minor = requiredComponents[1]
            self.patch = requiredComponents[2]

            func identifiers(start: String.Index?, end: String.Index) -> [String] {
                guard let start = start else { return [] }
                let identifiers = string[string.index(after: start)..<end]
                return identifiers.split(separator: ".").map(String.init(_:))
            }

            self.prereleaseIdentifiers = identifiers(
                start: prereleaseStartIndex,
                end: metadataStartIndex ?? string.endIndex)
            self.buildMetadataIdentifiers = identifiers(
                start: metadataStartIndex,
                end: string.endIndex)
        }
    #endif

    public var description: String {
        var base = "\(major).\(minor).\(patch)"
        if !prereleaseIdentifiers.isEmpty {
            base += "-" + prereleaseIdentifiers.joined(separator: ".")
        }
        if !buildMetadataIdentifiers.isEmpty {
            base += "+" + buildMetadataIdentifiers.joined(separator: ".")
        }
        return base
    }
}

extension Version {

    public init?<S: StringProtocol>(tolerant: S) {
        let string = tolerant.dropFirst(tolerant.first == "v" ? 1 : 0)
        let prereleaseStartIndex = string.firstIndex(of: "-")
        let requiredEndIndex = prereleaseStartIndex ?? string.endIndex
        let requiredCharacters = string.prefix(upTo: requiredEndIndex)
        let maybes = requiredCharacters.split(
            separator: ".",
            maxSplits: 2,
            omittingEmptySubsequences: false
        )
        .map { Int($0) }

        guard !maybes.contains(nil), 1...3 ~= maybes.count else {
            return nil
        }

        var requiredComponents = maybes.map { $0! }
        while requiredComponents.count < 3 {
            requiredComponents.append(0)
        }

        major = requiredComponents[0]
        minor = requiredComponents[1]
        patch = requiredComponents[2]

        if let prereleaseStartIndex = prereleaseStartIndex {
            let identifiers = string[string.index(after: prereleaseStartIndex)..<string.endIndex]
            prereleaseIdentifiers = identifiers.split(separator: ".").map(String.init(_:))
        } else {
            prereleaseIdentifiers = []
        }
        buildMetadataIdentifiers = []
    }
}
