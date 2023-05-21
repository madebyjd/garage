//
//  RoundedTextFieldStyle.swift
//

import SwiftUI

struct RoundedTextFieldStyle: TextFieldStyle {

    var active: Bool

    var color: Color = .accentColor

    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .textFieldStyle(PlainTextFieldStyle())
            .padding(Constants.UI.smallPadding)
            .overlay(
                RoundedRectangle(cornerRadius: Constants.UI.cornerRadius, style: .continuous)
                    .stroke(active ? Color.accentColor : .gray, lineWidth: active ? 3.0 : 1.0)
            )
            .lineLimit(1)

    }
}
