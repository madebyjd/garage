//
//  ImporterView.swift
//  
//
//  Created by Jonathan Danek on 5/22/23.
//

import SwiftUI

public struct ImporterView: View {

    @Environment(\.dismiss) var dismiss

    @ObservedObject public var model: ImporterViewModel

    public init(model: ImporterViewModel = ImporterViewModel()) {
        self.model = model
    }

    public var body: some View {
        switch model.kind {
        case .none:
            startViewList
        case .text, .todo:
            TextImporter(model: model, title: model.title)
        case .media:
            MediaImporter(model: model)
        case .capture:
            Button("Back") {
                self.model.kind = .none
            }
        }
    }

    public var startViewList: some View {
        NavigationView {
            List {
                Text("Templates")
                    .font(.title2)
                    .bold()
                    .leftAlign()

                Button("Blank Text") {
                    self.model.select(kind: .text)
                }

                Button("Todo") {
                    self.model.select(kind: .todo)
                }

                Button("Take Media") {
                    self.model.select(kind: .capture)
                }

                Button("Select Media") {
                    self.model.select(kind: .media)
                }
            }
        }
    }

    public var startView: some View {
        VStack(spacing: 10.0) {
            ScrollView {
                Text("Templates")
                    .font(.title2)
                    .bold()
                    .leftAlign()

                Button("Blank Text") {
                    self.model.select(kind: .text)
                }
                .buttonStyle(RoundedButtonStyle())

                Button("Todo") {
                    self.model.select(kind: .todo)
                }
                .buttonStyle(RoundedButtonStyle())

                Button("Take Media") {
                    self.model.select(kind: .capture)
                }
                .buttonStyle(RoundedButtonStyle())

                Button("Select Media") {
                    self.model.select(kind: .media)
                }
                .buttonStyle(RoundedButtonStyle())
            }
        }
    }
}

struct ImporterView_Previews: PreviewProvider {
    static var previews: some View {
        ImporterView()
            .previewLayout(.fixed(width: 200, height: 100))
    }
}
