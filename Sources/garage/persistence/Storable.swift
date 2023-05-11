//
//  Storable.swift
//  
//
//  Created by Jonathan Danek on 5/10/23.
//

import Foundation

public protocol Storable: Codable {

    var id: String { get }
    static var name: String { get }
}

extension Storable {

    public static var name: String {
        "\(self)"
    }
}

