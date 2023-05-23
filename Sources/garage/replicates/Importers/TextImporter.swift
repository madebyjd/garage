//
//  TextImporter.swift
//  
//
//  Created by Jonathan Danek on 5/22/23.
//

import SwiftUI

public struct TextImporter: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject public var model: ImporterViewModel

    public var title: String = ""

    public var body: some View {
        VStack {
            HStack {
                Text(title)
                    .leftAlign()
                    .font(.largeTitle)

                Spacer()

                SymbolButton(systemName: "checkmark.circle.fill") {
                    self.model.save()
                    dismiss()
                }
            }
            TextEditor(text: self.$model.text)
        }
        .padding(10.0)
    }
}

struct TextImporter_Previews: PreviewProvider {
    static var previews: some View {
        TextImporter(model: .init(), title: "New Task")
    }
}
