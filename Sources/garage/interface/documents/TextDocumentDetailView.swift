//
//  TextDocumentDetailView.swift
//

import SwiftUI

struct TextDocumentDetailView: View {

    var document: TextDocument

    init(document: TextDocument) {
        self.document = document
    }

    var body: some View {
        Text(document.content)
    }
}

struct TextDocumentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TextDocumentDetailView(document: TextDocument(kind: .text, content: "test"))
    }
}
