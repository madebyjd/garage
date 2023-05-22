//
//  File.swift
//  
//
//  Created by Jonathan Danek on 5/21/23.
//

import Foundation
import SwiftUI
import Combine
#if os(iOS)
public class PostEditorViewModel: ObservableObject {
    @Published var day = Day.today
    @Published var time = Time.now
    @Published var title: String?
    @Published var text = ""
    @Published var isShowingMedia = false
    @Published var isTakingMedia = false
    @Published var selectedPhotoIndex = -1
    @Published var isSelectingMedia = false
    @Published var camera = CameraViewModel()

    var delegate: PostEditorDelegate?

    init() {

    }
}
#endif
