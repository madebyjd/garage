//
//  Version+Foundation.swift
//
//
//  Created by Jonathan Danek on 5/4/23.
//

import class Foundation.Bundle
import struct Foundation.OperatingSystemVersion
import class Foundation.ProcessInfo

extension Bundle {

    public var version: Version {
        return (infoDictionary?["CFBundleShortVersionString"] as? String).flatMap(
            Version.init(tolerant:))
            ?? .null
    }
}

extension ProcessInfo {
    @available(OSX, introduced: 10.10)
    @available(iOS, introduced: 8.0)
    public var osVersion: Version {
        let v: OperatingSystemVersion = operatingSystemVersion
        return Version(major: v.majorVersion, minor: v.minorVersion, patch: v.patchVersion)
    }
}
