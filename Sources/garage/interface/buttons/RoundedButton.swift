//
//  SwiftUIView.swift
//  
//
//  Created by Jonathan Danek on 5/21/23.
//

import SwiftUI

struct RoundedButton: View {

    var color: Color
    var text: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: 8.0)
                    .foregroundColor(color)
                Text(text)
                    .foregroundColor(.white)
                    .bold()
            }
        }
        .buttonStyle(.plain)
        .aspectRatio(5.5, contentMode: .fit)
    }
}

struct RoundedButton_Previews: PreviewProvider {
    static var previews: some View {
        RoundedButton(color: .red, text: "Test button") {

        }
    }
}
