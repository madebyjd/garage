//
//  File.swift
//

import Foundation

public class Constants {

    public class UI {

        static var smallPadding: CGFloat = 5.0
        static var medPadding: CGFloat = 10.0
        static var largePadding: CGFloat = 20.0
        static var cornerRadius: CGFloat = 10.0
    }
}

import SwiftUI

#if os(iOS)
    import UIKit
    public typealias CPImage = UIImage
#elseif os(OSX)
    import AppKit
    public typealias CPImage = NSImage
#endif
