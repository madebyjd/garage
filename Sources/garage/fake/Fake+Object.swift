//
//  Fake+Object.swift
//
//
//  Created by Jonathan Danek on 5/4/23.
//

import Foundation

extension Fake.Object {

    public static func randomDate(start: Date? = nil, end: Date = Date()) -> Date {

        let start = start ?? Date(timeIntervalSinceReferenceDate: TimeInterval(0.0))
        let span = abs(end.timeIntervalSince(start))

        let randomSpan = Fake.Number.randomDecimal(in: 0..<span)

        return start.addingTimeInterval(TimeInterval(randomSpan))

    }
}
