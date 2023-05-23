//
//  File.swift
//  
//
//  Created by Jonathan Danek on 5/21/23.
//

#if os(iOS)
import Foundation
import UIKit
import SwiftUI

struct CameraPreview: UIViewRepresentable {

    @ObservedObject var camera: CameraWrapper
    var view: UIView

    func makeUIView(context: Context) -> UIView {
        return camera.makeUIView(view)
    }

    func updateUIView(_ uiView: UIView, context: Context) { }

}

#endif
