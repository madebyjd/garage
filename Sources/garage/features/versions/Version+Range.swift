//
//  Version+Range.swift
//
//
//  Created by Jonathan Danek on 5/4/23.
//

extension ClosedRange where Bound == Version {

    public func contains(_ version: Version) -> Bool {
        if !version.prereleaseIdentifiers.isEmpty, lowerBound.prereleaseIdentifiers.isEmpty && upperBound.prereleaseIdentifiers.isEmpty {
            return false
        }

        return version >= lowerBound && version <= upperBound
    }
}

extension Range where Bound == Version {

    public func contains(_ version: Version) -> Bool {
        if !version.prereleaseIdentifiers.isEmpty {
            if lowerBound.prereleaseIdentifiers.isEmpty && upperBound.prereleaseIdentifiers.isEmpty {
                return false
            }

            if upperBound.prereleaseIdentifiers.isEmpty && upperBound.isEqualWithoutPrerelease(version) {
                return false
            }
        }

        return version >= lowerBound && version < upperBound
    }
}
