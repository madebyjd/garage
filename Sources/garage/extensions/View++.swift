//
//  File.swift
//  
//
//  Created by Jonathan Danek on 5/4/23.
//

import SwiftUI

extension View {
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
}


