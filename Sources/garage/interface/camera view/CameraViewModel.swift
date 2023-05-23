//
//  File.swift
//  
//
//  Created by Jonathan Danek on 5/21/23.
//

import Foundation
import Combine

#if os(iOS)
import UIKit

var screenHeight = UIScreen.main.bounds.height
var screenWidth = UIScreen.main.bounds.width

class CameraViewModel: ObservableObject {

    var wrapper: CameraWrapper?

    @Published private(set) var image: UIImage?
    @Published private(set) var vidURL: String?

    @Published var images: [UIImage] = []

    private var cancellables: [AnyCancellable] = []

    init() {
#if TARGET_IPHONE_SIMULATOR
#else
        let wrapper = CameraWrapper()
        wrapper.buildCamera()

        wrapper.$image
            .sink { image in
                guard let image = image else { return }
                self.images.append(image)
            }
            .store(in: &cancellables)
        self.wrapper = wrapper
#endif
    }

    func add(image: UIImage) {
        self.images.append(image)
    }

    func toggleCamera() {
        wrapper?.toggleCamera()
    }
    func capturePhoto() {
        wrapper?.capturePhoto()
    }
}

#else
import AppKit
class CameraViewModel: ObservableObject {

    init() {

    }

    var images: [NSImage] = []

    func toggleCamera() {

    }
    func capturePhoto() {

    }
}
#endif
