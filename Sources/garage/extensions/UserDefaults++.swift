//
//  File.swift
//  
//
//  Created by Jonathan Danek on 5/4/23.
//

import Foundation

extension UserDefaults {

    public func date(forKey key: String) -> Date? {
        return object(forKey: key) as? Date
    }

    func object<T: Codable>(_ type: T.Type, with key: String, usingDecoder decoder: JSONDecoder = JSONDecoder()) -> T? {
        guard let data = value(forKey: key) as? Data else { return nil }
        return try? decoder.decode(type.self, from: data)
    }

    func set<T: Codable>(object: T, forKey key: String, usingEncoder encoder: JSONEncoder = JSONEncoder()) {
        let data = try? encoder.encode(object)
        set(data, forKey: key)
    }
}
