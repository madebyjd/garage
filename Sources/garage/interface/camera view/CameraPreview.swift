//
//  File.swift
//  
//
//  Created by Jonathan Danek on 5/21/23.
//

import Foundation
import SwiftUICam
import UIKit
import SwiftUI

struct CameraPreview: UIViewRepresentable {

    @ObservedObject var camera: CameraWrapper
    var view: UIView

    func makeUIView(context: Context) ->  UIView {
        return camera.makeUIView(view)
    }

    func updateUIView(_ uiView: UIView, context: Context) { }

}
