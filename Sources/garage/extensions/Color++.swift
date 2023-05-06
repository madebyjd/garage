//
//  File.swift
//  
//
//  Created by Jonathan Danek on 5/5/23.
//

import SwiftUI

extension Color {

    static var appBlue: Color {
        Color(hex: "#0095FF")
    }

    static var appLightBlue: Color {
        Color(hex: "#00FFFF")
    }

    static var appGreen: Color {
        Color(hex: "#00FF15")
    }

    static var appLightGreen: Color {
        Color(hex: "#AAFF00")
    }

    static var appYellow: Color {
        Color(hex: "#FFFF00")
    }

    static var appOrange: Color {
        Color(hex: "#FF9500")
    }

    static var appRed: Color {
        Color(hex: "#FF0014")
    }

    static var appPink: Color {
        Color(hex: "#FF00FF")
    }

    static var appPurple: Color {
        Color(hex: "#6A00FF")
    }
}

extension Color {

    public static var random: Color {
        Color.all.randomElement() ?? .red
    }

    public static var all: [Color] {
        [
            appBlue,
            appLightBlue,
            appGreen,
            appLightGreen,
            appYellow,
            appOrange,
            appRed,
            appPink,
            appPurple
        ]
    }

    public static var randomSystem: Color {
        Color.all.randomElement() ?? .red
    }

    public static var allSystem: [Color] {
        [
            .yellow,
            .red,
            .blue,
            .orange,
            .gray,
            .green,
            .brown,
            .indigo,
            .mint,
            .purple,
            .cyan
        ]
    }
}

extension Color {

    public init(hex: String) {
        var string: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if string.hasPrefix("#") {
            _ = string.removeFirst()
        }

        let scanner = Scanner(string: string)
        scanner.scanLocation = 0
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)

        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff

        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff
        )
    }

}
