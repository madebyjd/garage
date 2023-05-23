//
//  File.swift
//

import Foundation
import SwiftUI

extension CPImage {

    static func load(data: Data) -> CPImage? {
        CPImage(data: data)
    }
}

extension Image {

    init(cpImage: CPImage) {
        #if os(iOS)
        self.init(uiImage: cpImage)
        #else
        self.init(nsImage: cpImage)
        #endif
    }
}
#if os(iOS)

#else
import AppKit
extension NSImage {
    func pngData(
        size: CGSize? = nil,
        imageInterpolation: NSImageInterpolation = .high
    ) -> Data? {
        let size = size ?? self.size
        guard let bitmap = NSBitmapImageRep(
            bitmapDataPlanes: nil,
            pixelsWide: Int(size.width),
            pixelsHigh: Int(size.height),
            bitsPerSample: 8,
            samplesPerPixel: 4,
            hasAlpha: true,
            isPlanar: false,
            colorSpaceName: .deviceRGB,
            bitmapFormat: [],
            bytesPerRow: 0,
            bitsPerPixel: 0
        ) else {
            return nil
        }

        bitmap.size = size
        NSGraphicsContext.saveGraphicsState()
        NSGraphicsContext.current = NSGraphicsContext(bitmapImageRep: bitmap)
        NSGraphicsContext.current?.imageInterpolation = imageInterpolation
        draw(
            in: NSRect(origin: .zero, size: size),
            from: .zero,
            operation: .copy,
            fraction: 1.0
        )
        NSGraphicsContext.restoreGraphicsState()

        return bitmap.representation(using: .png, properties: [:])
    }


}
#endif
