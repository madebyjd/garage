//
//  ImageDocumentDetailView.swift
//

import SwiftUI

struct ImageDocumentDetailView: View {

    var document: ImageDocument

    init(document: ImageDocument) {
        self.document = document
    }

    var image: Image {
        document.image ?? Image(systemName: "questionmark.square.dashed")
    }

    var body: some View {
        image.font(.largeTitle)
    }
}

struct ImageDocumentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        return ImageDocumentDetailView(document: ImageDocument(content: Data()))
    }
}
