//
//  SwiftUIView.swift
//  
//
//  Created by Jonathan Danek on 5/6/23.
//

import SwiftUI

struct SymbolButton: View {

    var content: any View
    var action: () -> Void

    init(systemName: String, action: @escaping () -> Void) {
        content = Image(systemName: systemName)
            .resizable().anyView()
        self.action = action
    }

    init(emoji: String, action: @escaping () -> Void) {
        content = Text(emoji).anyView()
        self.action = action
    }

    var body: some View {
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
