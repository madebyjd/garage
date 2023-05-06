//
//  URL++.swift
//
//
//  Created by Jonathan Danek on 5/4/23.
//

import Foundation

extension URL {

    public static var documents: URL {
        return FileManager
            .default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
