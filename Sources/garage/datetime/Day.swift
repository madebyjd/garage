//
//  Day.swift
//  
//
//  Created by Jonathan Danek on 5/3/23.
//

import Foundation

public struct Day {

    // MARK: - Properties
    public var month: Int
    public var day: Int
    public var year: Int

    // MARK: - Inits
    public init(month: Int, day: Int, year: Int) {
        self.month = month
        self.day = day
        self.year = year
    }

    public init(date: Date) {
        self.month = date.month
        self.day = date.day
        self.year = date.year
    }

    public static var today: Day {
        Day(date: .now)
    }

    // MARK: - Utilities

    public func makeDate() -> Date? {
        var components = DateComponents()

        components.month = month
        components.day = day
        components.year = year
        components.hour = 12
        components.minute = 00
        components.timeZone = .current

        return Calendar.current.date(from: components)
    }
}

extension Day: Identifiable, Sendable, Hashable, Codable {

    public func hash(into hasher: inout Hasher) {
        hasher.combine(month)
        hasher.combine(day)
        hasher.combine(year)
    }

    public var id: String {
        String(format: "%02d%02d%02d", year, month, day)
    }

    public var formatted: String {
        String(format: "%02d-%02d-%02d", year, month, day)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Day.CodingKeys.self)
        try container.encode(month, forKey: .month)
        try container.encode(day, forKey: .day)
        try container.encode(year, forKey: .year)
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Day.CodingKeys.self)
        month = try container.decode(Int.self, forKey: .month)
        day = try container.decode(Int.self, forKey: .day)
        year = try container.decode(Int.self, forKey: .year)
    }

    public enum CodingKeys: String, CodingKey {
        case day
        case month
        case year
    }
}

extension Day {
    public func adding(months: Int = 0, days: Int = 0, years: Int = 0) -> Day? {

        guard let date = makeDate() else { return nil }
        var components = DateComponents()
        components.month = months
        components.day = days
        components.year = years
        guard let newDate = Calendar.current.date(byAdding: components, to: date) else { return nil }

        return Day(date: newDate)
    }


    /// - Returns: Number of days between the days.
    public func difference(to day: Day) -> Int {
        guard let date = self.makeDate(), let otherDate = day.makeDate() else { return 0 }
        let seconds = date.distance(to: otherDate)
        return Int(seconds / (60.0 * 60.0 * 24.0))
    }
}
