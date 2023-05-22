//
//  File.swift
//
//
//  Created by Jonathan Danek on 5/4/23.
//

import SwiftUI
import PhotosUI

extension View {

    public func hide(_ hidden: Bool) -> some View {
        if hidden {
            return EmptyView().anyView()
        } else {
            return self.anyView()
        }
    }
    public func fillingSuperview() -> some View {
        return self.frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity
        )
    }

    public func fillingWidth() -> some View {
        return self.frame(maxWidth: .infinity)
    }

    public func fillingHeight() -> some View {
        return self.frame(maxHeight: .infinity)
    }

    public func leftAlign() -> some View {
        return HStack(spacing: 0.0) {
            self
            Spacer()
        }
    }

    public func rightAlign() -> some View {
        return HStack {
            Spacer()
            self
        }
    }

    public func centerHAlign() -> some View {
        return HStack {
            Spacer()
            self
            Spacer()
        }
    }

    public func centerVAlign() -> some View {
        return VStack {
            Spacer()
            self
            Spacer()
        }
    }

    public func topAlign() -> some View {
        return VStack {
            self
            Spacer()
        }
    }

    public func bottomAlign() -> some View {
        return VStack {
            Spacer()
            self
        }
    }

    public func anyView() -> AnyView {
        AnyView(self)
    }

    public func isHidden(_ hidden: Bool) -> AnyView {
        if hidden {
            return EmptyView().anyView()
        } else {
            return self.anyView()
        }
    }

    public func stroke(enabled: Bool, color: Color, lineWidth: CGFloat) -> some View {
        if enabled, let shape = self as? (any Shape) {
            return shape
                .stroke(color, lineWidth: lineWidth)
                .anyView()
        } else {
            return self
                .anyView()
        }
    }

    public func fadeOutTop(fadeLength: CGFloat = 50) -> some View {
        return mask(
            VStack(spacing: 0) {

                // Left gradient
                LinearGradient(gradient: Gradient(
                    colors: [Color.black.opacity(25), Color.black]),
                               startPoint: .top, endPoint: .center)
                .frame(height: fadeLength)

                Rectangle().fill(Color.black)
            }
        )
    }

    func photosPicker(
        isPresented: Binding<Bool>,
        configuration: PHPickerConfiguration = .init(),
        onDismiss: (([PHPickerResult]) -> Void)? = nil
    ) -> some View {
#if os(iOS)
        PhotosPickerSheet(isPresented: isPresented, configuration: configuration, onDismiss: onDismiss, content: self)
        #else
        self
        #endif
    }
}
