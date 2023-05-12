//
//  RoundedTextFieldStyle.swift
//  
//
//  Created by Jonathan Danek on 5/11/23.
//

import SwiftUI

struct RoundedTextFieldStyle: TextFieldStyle {

    var active: Bool

    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .textFieldStyle(PlainTextFieldStyle())
            .padding(Constants.UI.smallPadding)
            .overlay(
                RoundedRectangle(cornerRadius: Constants.UI.cornerRadius, style: .continuous)
                    .stroke(active ? Color.orange : .gray, lineWidth: active ? 2.5 : 0.5)
            )
            .lineLimit(1)

    }
}
