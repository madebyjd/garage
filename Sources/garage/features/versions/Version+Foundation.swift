//
//  Version+Foundation.swift
//
//
//  Created by Jonathan Danek on 5/4/23.
//

import struct Foundation.OperatingSystemVersion
import class Foundation.ProcessInfo
import class Foundation.Bundle

public extension Bundle {

    var version: Version {
        return (infoDictionary?["CFBundleShortVersionString"] as? String).flatMap(Version.init(tolerant:)) ?? .null
    }
}

public extension ProcessInfo {
    @available(OSX, introduced: 10.10)
    @available(iOS, introduced: 8.0)
    var osVersion: Version {
        let v: OperatingSystemVersion = operatingSystemVersion
        return Version(major: v.majorVersion, minor: v.minorVersion, patch: v.patchVersion)
    }
}
