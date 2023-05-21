//
//  SwiftUIView.swift
//

import SwiftUI

public struct SymbolButton: View {

    var content: any View
    var action: () -> Void

    public init(systemName: String, action: @escaping () -> Void) {
        content = Image(systemName: systemName)
            .font(.largeTitle).anyView()
        self.action = action
    }

    public init(emoji: String, action: @escaping () -> Void) {
        content = Text(emoji).font(.largeTitle).anyView()
        self.action = action
    }

    public var body: some View {
        content
            .font(.title)
            .anyView()
            .onTapGesture {
                self.action()
            }
    }
}

struct SymbolButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SymbolButton(emoji: "🪛") {

            }
            SymbolButton(systemName: "figure.wave") {

            }
        }
    }
}
