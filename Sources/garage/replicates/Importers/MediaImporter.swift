//
//  MediaImporter.swift
//  
//
//  Created by Jonathan Danek on 5/22/23.
//

import SwiftUI

public struct MediaImporter: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject public var model: ImporterViewModel

    public var body: some View {
        NavigationView {
            reviewView
        }
        .onSlightDelay {
            model.isShowingPhotoPicker = true
        }
        .photosPicker(isPresented: $model.isShowingPhotoPicker, selection: $model.selectedItem)
    }

    public var reviewView: some View {
        VStack {
            thumbnails
            if let index = self.model.selectedIndex, let image = self.model.images[safe: index] {
                Spacer()
                Image(cpImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Spacer()
            } else {
                Spacer()
            }

            toolbar
        }
        .navigationTitle("Media")
        .navigationBarTitleDisplayMode(.inline)
    }

    public var toolbar: some View {
        HStack(spacing: 15.0) {
            Button {
                if let index = self.model.selectedIndex {
                    self.model.images.remove(at: index)
                }
            } label: {
                Label("Delete", systemImage: "trash")
                    .labelStyle(StackLabelStyle())
            }

            Button {

            } label: {
                Label("Edit", systemImage: "slider.horizontal.3")
                    .labelStyle(StackLabelStyle())
            }

            Spacer()

            Button {
                self.model.save()
                self.dismiss()
            } label: {
                Label("Done", systemImage: "checkmark.square.fill")
                    .labelStyle(StackLabelStyle())
            }

        }
        .padding(.horizontal, 20.0)
        .frame(height: 50.0)
    }

    public var thumbnails: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 10.0) {
                ForEach(Array(self.model.images.enumerated()), id: \.0.self) { (idx, image) in
                    Image(cpImage: image)
                        .resizable()
                        .frame(width: 25.0, height: 40.0)
                        .onTapGesture {
                            self.model.selectedIndex = idx
                        }
                        .padding(5.0)
                        .background(self.model.selectedIndex == idx ? Color.accentColor.cornerRadius(5.0).anyView() : Color.clear.anyView())
                }
            }
        }
    }
}

struct MediaImporter_Previews: PreviewProvider {
    static let model = ImporterViewModel()
    static var previews: some View {
        MediaImporter(model: model)
    }
}
