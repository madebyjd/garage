//
//  StackLabelStyle.swift
//  
//
//  Created by Jonathan Danek on 5/22/23.
//

import SwiftUI

public struct StackLabelStyle: LabelStyle {
    public func makeBody(configuration: Configuration) -> some View {
        VStack {
            configuration.icon
            configuration.title
        }
    }
}
