//
//  ImporterViewModel.swift
//  
//
//  Created by Jonathan Danek on 5/22/23.
//

import Foundation
import Combine
import PhotosUI
import SwiftUI

public protocol ImporterDelegate {

    func didCancel()
    func didSave(todo: String, on dayTime: DayTime)
    func didSave(text: String, on dayTime: DayTime)
    func didSave(image: Data, on dayTime: DayTime)
    func didSave(video: Data, on dayTime: DayTime)
}

public class ImporterViewModel: ObservableObject {

    public init(kind: ImporterViewModel.Kind = Kind.none, delegate: ImporterDelegate? = nil, title: String = "", text: String = "", images: [CPImage] = [], selectedIndex: Int? = nil, isShowingPhotoPicker: Bool = false, selectedItem: [PhotosPickerItem]? = nil) {
        self.kind = kind
        self.delegate = delegate
        self.title = title
        self.text = text
        self.images = images
        self.selectedIndex = selectedIndex
        self.isShowingPhotoPicker = isShowingPhotoPicker
        self.selectedItem = selectedItem ?? []

        setupPipelines()
    }
    
    public enum Kind {
        case none
        case text
        case todo
        case capture
        case media
    }

    @Published public var kind = Kind.none

    public var delegate: ImporterDelegate?

    var pipelines = Set<AnyCancellable>()
    // MARK: - Text
    @Published public var title = ""
    @Published public var text = ""

    // MARK: - Media
    @Published public var images: [CPImage] = []
    @Published public var selectedIndex: Int?
    @Published public var isShowingPhotoPicker = false
    @Published public var selectedItem: [PhotosPickerItem] = []


    // MARK: - Setup

    public func setupPipelines() {
        self.$selectedItem
            .receive(on: RunLoop.main)
            .sink { items in
                for item in items {
                    item.loadTransferable(type: Data.self, completionHandler: { result in
                        if let imageData = try? result.get(), let image = CPImage(data: imageData) {
                            self.images.append(image)
                        }

                    })
                }
            }
            .store(in: &pipelines)
    }

    // MARK: - Actions

    public func select(kind: Kind) {

        switch kind {
        case .text:
            self.title = "Text"
        case .todo:
            self.title = "Todo"
        default:
            break
        }

        DispatchQueue.main.async {
            self.kind = kind
        }
    }

    public func save() {
        switch kind {
        case .none: break
        case .todo:
            self.delegate?.didSave(todo: text, on: .now)
        case .text:
            self.delegate?.didSave(text: text, on: .now)
        case .media, .capture:
            for image in images {
                guard let imageData = image.pngData() else { return }
                self.delegate?.didSave(image: imageData, on: .now)
            }
        }

        reset()
    }

    public func reset() {
        self.kind = .none
        self.title = ""
        self.text = ""
        self.images = []
        self.selectedIndex = nil
        self.isShowingPhotoPicker = false
        self.selectedItem = []
    }
}
