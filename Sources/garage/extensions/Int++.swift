//
//  Int++.swift
//
//
//  Created by Jonathan Danek on 5/4/23.
//

import Foundation

extension Int {

    public func isClose(to value: Int, buffer: Int = 3) -> Bool {
        Array((self - buffer)..<(self + buffer))
            .contains(value)
    }
}
