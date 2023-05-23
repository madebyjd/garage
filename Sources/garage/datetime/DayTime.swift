//
//  File.swift
//  
//
//  Created by Jonathan Danek on 5/22/23.
//

import Foundation

public struct DayTime {
    public var day: Day
    public var time: Time

    public init(day: Day = .today, time: Time = .now) {
        self.day = day
        self.time = time
    }

    public static var now: DayTime {
        DayTime(day: .today, time: .now)
    }
}
