//
//  Fake+Person.swift
//
//
//  Created by Jonathan Danek on 5/4/23.
//

import Foundation

extension Fake.Person {

    public static func randomFirstName() -> String {
        let listLoader = try? ListLoader(name: "first-names", type: "txt")
        return listLoader?.list.randomElement() ?? ""
    }

    public static func randomLastName() -> String {
        let csvLoader = try? ListLoader(name: "first-names", type: "txt")
        return csvLoader?.list.randomElement() ?? ""
    }

    public static func randomName() -> String {
        "\(randomFirstName()) \(randomLastName())"
    }

    public static func randomAge() -> Int {
        Fake.Number.random(min: 3, max: 99)
    }

    public static func randomAddress() -> String {
        let number = Fake.Number.random(in: 111..<9999)
        let direction = ["North", "West", "South", "East", ""].shuffled()[0]
        let listLoader = try? ListLoader(name: "streets", type: "txt")
        let street = listLoader?.list.randomElement() ?? ""

        return ["\(number)", direction, street]
            .filter { !$0.isEmpty }
            .joined(separator: " ")
    }

    public static func randomCountry() -> (String, String) {
        let csvLoader = try? CSVLoader(name: "countries", type: "csv")
        let key = csvLoader?.list.keys.shuffled().first ?? ""
        let code = csvLoader?.get(key: key, value: "code") ?? ""
        let name = csvLoader?.get(key: key, value: "name") ?? ""

        return (name, code)

    }

}
