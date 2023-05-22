//
//  File.swift
//  
//
//  Created by Jonathan Danek on 5/21/23.
//

import Foundation

public struct Time {

    public var hour: Int
    public var minute: Int

    public init(hour: Int, minute: Int) {
        self.hour = hour
        self.minute = minute
    }
}

extension Time {

    public var formatted: String {
        let isAm = hour > 12
        return "\(hour % 12):\(String(format: "%02d", minute)) \(isAm ? "AM" : "PM")"
    }
}

extension Time {

    public static var now: Time {
        let date = Date()

        return Time(hour: date.hour, minute: date.minute)
    }
}
