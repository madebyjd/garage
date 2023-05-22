//
//  File.swift
//  
//
//  Created by Jonathan Danek on 5/22/23.
//

import SwiftUI

public struct BigButtonStyle: ButtonStyle {

  @State private var color: Color
  private var isEnabled: Bool

  public init(color: Color, isEnabled: Bool) {
    self.color = color
    self.isEnabled = isEnabled
  }

  public func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .font(.title.bold())
      .padding()
      .frame(maxWidth: .infinity, alignment: .center)
      .foregroundColor(isEnabled ? .white : Color.secondary)
      .background(isEnabled ? color : color.opacity(0.3))
      .cornerRadius(8)
      .overlay(
        Color(white: 1.0, opacity: 0.2)
            .cornerRadius(12)
            .isHidden(!configuration.isPressed)
      )
  }
}


struct BigButtonStyle_Previews: PreviewProvider {
    static var previews: some View {

        Button("test button") {
            
        }
        .buttonStyle(BigButtonStyle(color: .accentColor, isEnabled: true))
    }
}
