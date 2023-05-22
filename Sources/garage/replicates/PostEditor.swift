//
//  SwiftUIView.swift
//  
//
//  Created by Jonathan Danek on 5/21/23.
//

import SwiftUI
import SwiftUICam
import PhotosUI

public protocol PostEditorDelegate {

    func didCancel()
    func didSave(title: String, text: String, on day: Day, at time: Time)
    func didSave(image: Data, on day: Day, at time: Time)
    func didSave(video: Data, on day: Day, at time: Time)
}


public struct PostEditor: View {

    @ObservedObject var model = PostEditorViewModel()

    let view = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth - 30.0, height: screenHeight * 0.6))

    public init(delegate: PostEditorDelegate? = nil) {
        self.model.delegate = delegate
    }
    
    var templates: [String] = PostEditor.default_templates

    var photoPickerConfiguration: PHPickerConfiguration {
        var config = PHPickerConfiguration(photoLibrary: .shared())
        config.selectionLimit = 10
        config.filter = PHPickerFilter.any(of: [.images])
        return config
    }
    
    public var body: some View {
        VStack {
            HStack {
                Text(self.model.day.formatted(style: .medium, includeToday: false))
                    .font(.title3)
                    .padding(6.0)
                    .fontWeight(.light)
                    .foregroundColor(.appDarkGray)
                    .background(Color.appLightGray)
                    .cornerRadius(8.0)
                Text(self.model.time.formatted)
                    .font(.title3)
                    .padding(6.0)
                    .fontWeight(.light)
                    .foregroundColor(.appDarkGray)
                    .background(Color.appLightGray)
                    .cornerRadius(8.0)
                
                Spacer()
                
                SymbolButton(systemName: "list.bullet.circle") {
                    self.model.title = nil
                    self.model.isTakingMedia = false
                    self.model.isSelectingMedia = false
                }
                .fontWeight(.thin)
                .isHidden(self.model.title == nil)
                
                SymbolButton(systemName: "x.circle") {
                    self.model.camera.images = []
                    self.model.title = nil
                    self.model.isTakingMedia = false
                    self.model.isSelectingMedia = false
                    self.model.isShowingMedia = false
                }
                .fontWeight(.thin)
            }

            Text(self.model.title ?? "")
                .font(.title3)
                .bold()
                .leftAlign()

            if self.model.isTakingMedia {
                #if TARGET_IPHONE_SIMULATOR
                Text("No camera")
                #else

                ZStack {
                    CameraPreview(camera: self.model.camera.wrapper!, view: view)

                    if self.model.selectedPhotoIndex >= 0, self.model.camera.images.count > self.model.selectedPhotoIndex {
                        Image(uiImage: self.model.camera.images[self.model.selectedPhotoIndex])
                            .resizable()
                            .frame(width: view.frame.width, height: view.frame.height)
                            .cornerRadius(10.0)
                    }
                }
                HStack {
                    SymbolButton(systemName: "arrow.triangle.2.circlepath") {
                        self.model.camera.wrapper!.toggleCamera()
                    }
                    Spacer()
                    SymbolButton(systemName: "camera.circle.fill") {
                        self.model.camera.wrapper!.capturePhoto()
                    }
                    Spacer()
                    SymbolButton(systemName: "checkmark.circle.fill") {
                        self.reset()
                        self.model.isShowingMedia = true
                    }
                }
                .font(.largeTitle)
                #endif

                ScrollView(.horizontal) {
                    HStack {
                        ForEach(Array(self.model.camera.images.enumerated()), id: \.0.self) { (idx, image) in
                            Image(uiImage: image)
                                .resizable()
                                .frame(width: 25.0, height: 40.0)
                        }
                    }
                }
                .padding(10.0)
            } else if self.model.isShowingMedia {
                if let uiImage = self.model.camera.images[safe: self.model.selectedPhotoIndex] {
                    Image(uiImage: uiImage)
                        .resizable()
                        .frame(width: view.frame.width, height: view.frame.height)
                        .cornerRadius(10.0)
                }

                HStack {
                    SymbolButton(systemName: "trash.circle.fill") {
                        _ = self.model.camera.images.remove(at: self.model.selectedPhotoIndex)
                        if !self.model.camera.images.isEmpty {
                            self.model.selectedPhotoIndex = max(0, self.model.selectedPhotoIndex - 1)
                        } else {
                            self.reset()
                        }
                    }
                    Spacer()
                    SymbolButton(systemName: "camera.macro.circle") {

                    }
                }
                .font(.largeTitle)

                ScrollView(.horizontal) {
                    HStack(spacing: 10.0) {
                        ForEach(Array(self.model.camera.images.enumerated()), id: \.0.self) { (idx, image) in
                            Image(uiImage: image)
                                .resizable()
                                .frame(width: 25.0, height: 40.0)
                                .onTapGesture {
                                    self.model.selectedPhotoIndex = idx
                                }
                                .background(self.model.selectedPhotoIndex == idx ? Color.accentColor : Color.clear)
                        }
                    }
                }
                .padding(10.0)
            } else if self.model.title != nil {
                textEntry
            } else {
                startView
            }
        }
        .photosPicker(isPresented: self.$model.isSelectingMedia, configuration: photoPickerConfiguration) { photos in
            let dispatchGroup = DispatchGroup()

            for item in photos.map(\.itemProvider) {
                dispatchGroup.enter()
                let loader = item.loadDataRepresentation(for: .image) { (data, _) in
                    if let data = data, let image = UIImage(data: data) {
                        Task { @MainActor in
                            self.model.camera.add(image: image)
                        }
                    }
                    dispatchGroup.leave() // signal OUT
                }
                loader.resume()

            }
            dispatchGroup.enter()
            self.model.isSelectingMedia = false
            if !self.model.camera.images.isEmpty {
                self.model.selectedPhotoIndex = 0
                self.model.isShowingMedia = true
            }
            dispatchGroup.leave() // signal OUT
        }
        .padding(15.0)
    }
    
    var textEntry: some View {

        TextEditor(text: self.$model.text)
            .toolbar {

                ToolbarItemGroup(placement: .keyboard) {

                    Spacer()

                    Button {} label: {
                        Image(systemName: "arrow.right.circle.fill")
                    }
                    .tint(Color.blue.opacity(0.7))
                }
        }
    }

    var startView: some View {
        VStack(spacing: 10.0) {
            ScrollView {
                Text("Templates")
                    .font(.title2)
                    .bold()
                    .leftAlign()

                RoundedButton(color: .gray.opacity(0.6), text: "Blank Post"){
                    self.model.title = ""
                }
                .padding(.horizontal, 5.0)

                RoundedButton(color: .blue.opacity(0.6), text: "Take Media"){
                    self.model.title = "Take Media"
                    self.model.isTakingMedia = true
                }
                .padding(.horizontal, 5.0)

                RoundedButton(color: .blue.opacity(0.6), text: "Select Media"){
                    self.model.title = "Select Media"
                    self.model.isSelectingMedia = true
                }
                .padding(.horizontal, 5.0)

                ForEach(self.templates, id: \.self) { template in
                    RoundedButton(color: .orange.opacity(0.6), text: template){
                        self.model.title = template
                    }
                    .padding(.horizontal, 5.0)
                }
            }
        }
    }

    func reset() {
        self.model.selectedPhotoIndex = 0
        self.model.isShowingMedia = false
        self.model.isTakingMedia = false
        self.model.isSelectingMedia = false
    }
}

struct PostEditor_Previews: PreviewProvider {
    static var previews: some View {
        PostEditor()
    }
}

extension PostEditor {

    public static var default_templates: [String] {
        [
            "What was the best thing that happened today?",
            "What was the worst thing that happened today?",
            "What was the most interesting thing I saw or heard today?",
            "What was the most challenging thing I faced today?",
            "What am I grateful for today?",
            "What did I learn today?",
            "What was the most fun thing I did today?",
            "What was the most surprising thing that happened today?",
            "What did I do today that I am proud of?",
        ]
    }
}
