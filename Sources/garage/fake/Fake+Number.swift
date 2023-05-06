//
//  Fake+Number.swift
//
//
//  Created by Jonathan Danek on 5/4/23.
//

import Foundation

extension Fake.Number {

    public static func random(in range: Range<Int> = 0..<100) -> Int {
        range.shuffled().first ?? 0
    }

    public static func random(min: Int = 0, max: Int = 100) -> Int {
        Array(min..<max).shuffled().first ?? 0
    }

    public static func randomDecimal(in range: Range<Double> = 0.0..<10.0) -> Double {
        Double.random(in: range)
    }

    public static func random(min: Double = 0.0, max: Double = 100.0) -> Double {
        Double.random(in: min..<max)
    }

}
