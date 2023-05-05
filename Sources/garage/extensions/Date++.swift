//
//  Date++.swift
//  
//
//  Created by Jonathan Danek on 5/4/23.
//

import Foundation

extension Date {

    public var month: Int {
        return Calendar.current.component(.month, from: self)
    }

    public var day: Int {
        return Calendar.current.component(.day, from: self)
    }

    public var year: Int {
        return Calendar.current.component(.year, from: self)
    }

}
