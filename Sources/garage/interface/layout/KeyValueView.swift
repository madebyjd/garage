//
//  SwiftUIView.swift
//

import SwiftUI

struct KeyValueView: View {
    var key: String
    var value: String
    var color: Color

    public init(key: String, value: String, color: Color = .randomSystem) {
        self.key = key
        self.value = value
        self.color = color
    }

    var body: some View {
        VStack {
            Text(key)
                .font(.subheadline)
                .fontWeight(.semibold)
                .leftAlign()
            Text(value)
                .font(.title)
                .fontWeight(.medium)
                .leftAlign()
                .foregroundColor(color)
        }
    }
}

struct KeyValueView_Previews: PreviewProvider {
    static var previews: some View {
        KeyValueView(key: "Workout Time", value: "0:37:25")
    }
}
