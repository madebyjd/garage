//
//  RoundedButtonStyle.swift
//  
//
//  Created by Jonathan Danek on 5/22/23.
//

import SwiftUI

public struct RoundedButtonStyle: ButtonStyle {

    var color: Color = .accentColor

    public func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .padding(5.0)
            .background(
                RoundedRectangle(
                    cornerRadius: 6
                )
                .foregroundColor(color)
            )
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
    }
}


struct RoundedButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Button("test button") {

            }
            .buttonStyle(RoundedButtonStyle())
            .padding()

            Button("test button") {

            }
            .buttonStyle(RoundedButtonStyle(color: .red))
            .padding()

        }
    }
}
