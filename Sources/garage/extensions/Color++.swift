//
//  File.swift
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

    static var appLightGray: Color {
        Color(hex: "#ededed")
    }

    static var appDarkGray: Color {
        Color(hex: "#1b1b1b")
    }
}

extension Color {

    public static var random: Color {
        Color.all.randomElement() ?? .white
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
        Color.all.randomElement() ?? .white
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

    var components: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)? {
        guard let components = self.cgColor?.components, components.count == 4 else { return nil }
        let red = components[0]
        let green = components[1]
        let blue = components[2]
        let alpha = components[3]

        return (red: red, green: green, blue: blue, alpha: alpha)
    }

    var isBright: Bool {
        if let (red: red, green: green, blue: blue, alpha: _) = self.components {
            let brightness = ((red * 299.0) + (green * 587.0) + (blue * 114.0)) / 1000.0

            return brightness > 0.3
        } else {
            return false
        }
    }
}
