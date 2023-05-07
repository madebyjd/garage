//
//  SwiftUIView.swift
//  
//
//  Created by Jonathan Danek on 5/6/23.
//

import SwiftUI

struct KeyValueView: View {
    var key: String
    var value: String
    var color: Color = .randomSystem

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
